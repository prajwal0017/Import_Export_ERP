<%@page import="java.util.List"%>
<%@ page import="model.OrdersPojo"%>
<%@ page import="model.ConsumerPojo"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    // Check if the session contains a consumer object
    ConsumerPojo consumerExists = (ConsumerPojo) session.getAttribute("userobj");
    
    if (consumerExists == null) {
        // If no consumer is logged in, redirect to the login page
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
    <title>Your Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css" />

    <style>
        /* (your existing styles here) */
        /* Common styles for sidebar and navbar */
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

        .sidebar-brand-link {
            display: flex;
            align-items: center;
            color: #fff;
            text-decoration: none;
            margin-bottom: 20px;
        }

        .sidebar-brand-link-icon {
            font-size: 24px;
            margin-right: 10px;
        }

        .sidebar-brand-link-text {
            font-size: 18px;
            font-weight: bold;
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
        }

        .sidebar-menu-item-link-icon {
            font-size: 20px;
            margin-right: 10px;
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

        .navbar .nav-links {
            display: flex;
            gap: 20px;
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
            overflow-y: auto; /* Enable vertical scrolling */
            max-height: calc(100vh - 60px); /* Adjust height based on navbar and sidebar */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }
        
         .navbar .navbar-button {
            background-color: #007bff; /* Primary button color */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-right: 20px; /* Space between Profile and Logout buttons */
        }

        .navbar .navbar-button:hover {
            background-color: #0056b3; /* Darker shade on hover */
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <a href="consumerDashboard.jsp" class="logo">
            <h1>Consumer Dashboard</h1>
        </a>
        <div class="nav-links">
            <button class="navbar-button" onclick="handleProfile()">Profile</button>
            <button class="logout-button" onclick="handleLogout()">Logout</button>
        </div>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="consumerDashboard.jsp" class="sidebar-menu-item-link">
                    <i class="ri-dashboard-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">Dashboard</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="allProducts" class="sidebar-menu-item-link">
                    <i class="ri-shopping-bag-3-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">Order Products</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="reportProduct" class="sidebar-menu-item-link">
                    <i class="ri-alert-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">Report Products</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="viewConsumerOrders" class="sidebar-menu-item-link">
                    <i class="ri-user-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">View Orders</span>
                </a>
            </li>
            <li class="sidebar-menu-item sidebar-menu-item-danger">
                <a href="updateProfile.jsp" class="sidebar-menu-item-link">
                    <i class="ri-edit-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">Edit Profile</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="main">
        <h2>View Orders</h2>
        <%
            List<OrdersPojo> orders = (List<OrdersPojo>) request.getAttribute("orderList");

            if (orders != null && !orders.isEmpty()) {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Order Date</th>
                        <th>Report Issue</th>
                        <th>Action</th>
                    </tr>
                </thead>
    <tbody>
    <%
    for (OrdersPojo order : orders) {
    %>
        <tr>
            <td><strong><%= order.getOrderId() %></strong></td>
            <td><%= order.getProductId() %></td>
            <td><%= order.getProductName() %></td>
            <td><%= order.getQuantity() %></td>
            <td><%= order.getOrderDate() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(order.getOrderDate()) : "N/A" %></td>
            <td>
                <form action="ReportProductController" method="post" style="display:inline;">
                    <input type="hidden" name="consumerPortId" value="<%= consumerExists.getPortId() %>">
                    <input type="hidden" name="productId" value="<%= order.getProductId() %>">
                    <select name="issue_type" class="form-control" required>
                            <option value="" disabled selected>Select Issue Type</option>
                            <option value="Damage">Damage</option>
                            <option value="Wrong Product">Wrong Product</option>
                            <option value="Delayed">Delayed</option>
                            <option value="Still Not Received">Still Not Received</option>
                            <option value="Missing">Missing</option>
                        </select>
                    </td>
                    <td>
                    <button type="submit" class="btn btn-warning">Report</button>
                    </td>
                </form>
            
        </tr>
    <%
    }
    %>
</tbody>
    
        
                
            </table>
        <%
            } else {
        %>
            <p>No orders found.</p>
        <%
            }
        %>
    </div>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script>
        function handleProfile() {
            window.location.href = 'updateProfile.jsp';
        }

        function handleLogout() {
            // Add logout logic here
            window.location.href = 'LogoutServlet'; // Assuming you have a logout servlet mapped to this URL
        }
    </script>
</body>
</html>
