<%@page import="model.OrdersPojo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.SellerPojo" %>
<%
    // Check if the session contains a seller object
    SellerPojo seller = (SellerPojo) session.getAttribute("seller");
    
    if (seller == null) {
        // If no seller is logged in, redirect to the login page
        response.sendRedirect("login.jsp");
        return;
    }
    
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css" />
    
    <style>
        /* Common styles for sidebar and navbar */
        body {
            background-color: #fbfbfb;
            margin: 0;
            font-family: 'Roboto', sans-serif;
            height: 100vh;
            overflow: hidden; /* Prevent default scrolling */
            display: flex;
            flex-direction: column;
        }
        .sidebar {
            background-color: #000;
            width: 250px;
            height: calc(100vh - 60px); /* Reduce height so it fits below the navbar */
            position: fixed;
            top: 60px; /* Start the sidebar a little lower, below the navbar */
            left: 0;
            padding: 20px;
            color: white;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin-top: 30px;
        }

        .sidebar-menu-item {
            margin: 15px 0;
        }

        .sidebar-menu-item-link {
            display: flex;
            align-items: center;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 20px;
            transition: background-color 0.3s ease;
            color: black;
        }

        .sidebar-menu-item-link:hover {
            background-color: #333;
        }

        .navbar {
            background-color: #2F4F4F;
            padding: 15px 30px;
            width: 100%; /* Navbar now spans the full width */
            position: fixed;
            top: 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            z-index: 1; /* Ensure the navbar stays above the sidebar */
        }

        .navbar h1 {
            color: white;
            margin: 0;
            font-size: 24px;
        }

        .navbar .logout-button {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .navbar .logout-button:hover {
            background-color: #ff6666;
        }

        .main {
            flex-grow: 1;
            margin-left: 250px;
            margin-top: 60px;
            padding: 20px;
            background-color: #f8f9fa;
            overflow-y: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            word-wrap: break-word;
        }
        th {
            background-color: #f4f4f4;
            color: #333;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
            width: 100%;
            box-sizing: border-box;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <a href="sellerDashboard.jsp" class="logo">
            <h1>Seller Dashboard</h1>
        </a>
        <div class="nav-links">
            <button class="logout-button" onclick="handleLogout()">Logout</button>
        </div>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="addProduct.jsp" class="sidebar-menu-item-link">
                    <i class="ri-dashboard-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">Add Product</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="orderedProducts" class="sidebar-menu-item-link">
                    <i class="ri-shopping-bag-3-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">View Ordered Products</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="reportedProducts" class="sidebar-menu-item-link">
                    <i class="ri-alert-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">View Reported Products</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="allProducts" class="sidebar-menu-item-link">
                    <i class="ri-map-pin-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">View Products</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="main">
        <div class="container">
            <h1>Order List</h1>
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Product ID</th>
                     <th>Product Name</th>
                    
                    <th>Consumer Port ID</th>
                    <th>Quantity</th>
                    <th>Order Date</th>
                    <th>Order Placed</th>
                    <th>Shipped</th>
                    <th>Out for Delivery</th>
                    <th>Delivered</th>
                    <th>Action</th>
                </tr>
                <%
                    // Fetching order list from request attribute
                    List<OrdersPojo> orderList = (List<OrdersPojo>) request.getAttribute("orderList");
                    if (orderList != null) {
                        for (OrdersPojo order : orderList) {
                %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getProductId() %></td>
                     <td><%= order.getProductName() %></td>
                    <td><%= order.getConsumerPortId() %></td>
                    <td><%= order.getQuantity() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td><%= order.isOrderPlaced() ? "<i class='ri-checkbox-circle-fill' style='color: green;'></i>" : "<i class='ri-close-circle-fill' style='color: red;'></i>" %></td>
                    <td><%= order.isShipped() ? "<i class='ri-checkbox-circle-fill' style='color: green;'></i>" : "<i class='ri-close-circle-fill' style='color: red;'></i>" %></td>
                    <td><%= order.isOutForDelivery() ? "<i class='ri-checkbox-circle-fill' style='color: green;'></i>" : "<i class='ri-close-circle-fill' style='color: red;'></i>" %></td>
                    <td><%= order.isDelivered() ? "<i class='ri-checkbox-circle-fill' style='color: green;'></i>" : "<i class='ri-close-circle-fill' style='color: red;'></i>" %></td>
                    <td>
                        <form action="UpdateOrderStatusServlet" method="post">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <input type="submit" value="Update Status">
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="10">No orders found.</td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
    </div>

    <script>
        function handleLogout() {
            window.location.href = 'LogoutServlet'; // Redirect to the logout servlet
        }
    </script>
</body>
</html>
