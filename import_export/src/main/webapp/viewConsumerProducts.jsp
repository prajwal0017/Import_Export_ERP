
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="model.ProductPojo"%>
<%@ page import="model.ConsumerPojo"%>

<%@ page import="model.ConsumerPojo"%>
<%
    // Check if the session contains a seller object
    ConsumerPojo consumerExists = (ConsumerPojo) session.getAttribute("userobj");
    
    if (consumerExists == null) {
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
    <title>Order Products</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css" />

    <style>
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

        .sidebar-menu-item-danger a {
            color: #ff4d4d;
        }

        .sidebar-menu-item.active a {
            color: white;
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
            overflow-y: auto;
        }

        .container {
            max-width: 1000px;
            margin: 20px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.15);
        }

        .container:hover {
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        /* Table styles */
          table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        border-radius: 8px;
        overflow: hidden; /* Ensures borders are rounded */
    }

    th, td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
    }

    th {
        background-color: #007bff; /* Bootstrap primary color */
        color: white;
        font-size: 18px;
        text-transform: uppercase; /* Uppercase for header */
        letter-spacing: 1px; /* Spacing for better readability */
    }

    td {
        font-size: 16px;
        color: #333;
        transition: background-color 0.3s ease; /* Smooth transition on hover */
    }

    /* Adding hover effect to table rows */
    tbody tr {
        transition: background-color 0.3s ease;
    }

    tbody tr:hover {
        background-color: #e9ecef; /* Light gray on hover */
        cursor: pointer;
    }

    /* Alternate row colors for better readability */
    tbody tr:nth-child(even) {
        background-color: #f8f9fa; /* Light background for even rows */
    }

    tbody tr:nth-child(odd) {
        background-color: #ffffff; /* White background for odd rows */
    }

    /* Styling the input number field */
    input[type="number"] {
        width: 60px; /* Fixed width for consistency */
        border: 1px solid #ced4da; /* Bootstrap border color */
        border-radius: 4px; /* Rounded corners */
        padding: 5px; /* Padding inside the input */
        margin-right: 10px; /* Space between input and button */
        outline: none; /* Remove outline on focus */
        transition: border-color 0.3s; /* Transition for border color */
    }

    input[type="number"]:focus {
        border-color: #007bff; /* Change border color on focus */
    }

    /* Style for the order button */
    .btn-primary {
        transition: background-color 0.3s, border-color 0.3s; /* Smooth transition for button */
    }

    .btn-primary:hover {
        background-color: #0056b3; /* Darker shade on hover */
        border-color: #0056b3; /* Change border color on hover */
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
        <div class="container">
            <h2>Available Products</h2>
            <table>
                <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Available Quantity</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    // Get the product list from the request
                    List<ProductPojo> productList = (List<ProductPojo>) request.getAttribute("productList");
                    if (productList != null) {
                        for (ProductPojo p : productList) {
                    %>
                    <tr>
                        <td><%= p.getProductName() %></td>
                        <td><%= p.getPrice() %></td>
                        <td><%= p.getQuantity() %></td> <!-- Display fetched quantity -->
                        <td>
                            <form action="PlaceOrderServlet" method="post" style="display:inline;">
                                <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                <input type="hidden" name="consumerPortId" value="<%= consumerExists.getPortId() %>">
                                <input type="number" name="quantity"  max="<%= p.getQuantity() %>">
                                <button type="submit" class="btn btn-primary">Order</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
    function handleLogout() {
        window.location.href = 'LogoutServlet'; // Redirect to LogoutServlet
    }
    
    function handleProfile() {
        window.location.href = 'viewProfile.jsp'; // Redirect to profile page
    }
    </script>
</body>
</html>
