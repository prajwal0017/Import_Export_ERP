<%@ page import="operationsImp.OrderImp"%>
<%@ page import="model.OrdersPojo"%>
<%@ page import="model.ConsumerPojo"%>
<%@ page import="java.sql.*, java.util.List"%>
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

    String orderIdParam = request.getParameter("orderId");
    int orderId = Integer.parseInt(orderIdParam);

    OrdersPojo orderService = new OrdersPojo();
    OrdersPojo order = orderService.getOrderById(orderId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Progress</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    
    <style>
        .progress-container {
            position: relative;
            width: 100%;
            background-color: #e9ecef;
            border-radius: 5px;
            height: 30px;
            margin-bottom: 20px;
        }

        .progress-bar {
            height: 100%;
            transition: width 0.3s ease;
            background-color: green;
            position: relative;
        }

        .progress-bar::after {
            content: '';
            position: absolute;
            right: -5px;
            top: 0;
            height: 100%;
            width: 10px;
            background-color: green;
            border-radius: 5px;
            animation: blink 1s infinite;
        }

        @keyframes blink {
            0%, 100% {
                opacity: 0;
            }
            50% {
                opacity: 1;
            }
        }

        .status-label {
            display: flex;
            justify-content: space-between;
            font-weight: bold;
            font-size: 14px;
            margin-top: 5px;
        }

        .status-label span {
            display: flex;
            align-items: center;
            margin-right: 20px;
        }

        .status-label i {
            margin-right: 5px;
        }

        .label-placed { color: <%= order.isOrderPlaced() ? "green" : "grey" %>; }
        .label-shipped { color: <%= order.isShipped() ? "green" : "grey" %>; }
        .label-out-for-delivery { color: <%= order.isOutForDelivery() ? "green" : "grey" %>; }
        .label-delivered { color: <%= order.isDelivered() ? "green" : "grey" %>; }

        .sidebar {
            background-color: #000;
            width: 250px;
            height: calc(100vh - 60px);
            position: fixed;
            top: 60px;
            left: 0;
            padding: 20px;
            color: white;
        }

        .navbar {
            background-color: #2F4F4F;
            padding: 15px 30px;
            width: 100%;
            position: fixed;
            top: 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }

        .main {
            flex-grow: 1;
            margin-left: 250px;
            margin-top: 60px;
            padding: 20px;
            background-color: #f8f9fa;
            overflow-y: auto;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin-top: 50px;
        }

        .sidebar-menu-item {
            margin: 40px 2px;
        }

        .sidebar-menu-item-link {
            display: flex;
            align-items: center;
            text-decoration: none;
            padding: 4px 10px;
            border-radius: 20px;
            transition: grey 0.3s ease;
            color: black;
            background: white;
        }

        .sidebar-menu-item-link:hover {
            background-color: #333;
            color: white;
        }

        .navbar h1 {
            color: white;
            margin: 0;
            font-size: 24px;
        }

        .logout-button {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .logout-button:hover {
            background-color: #ff6666;
        }

        .order-details {
            background-color: #f1f1f1;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .order-id {
            font-weight: bold;
            color: #007bff;
        }

        .order-name {
            font-weight: bold;
            color: #28a745;
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
                <a href="viewConsumerOrders.jsp" class="sidebar-menu-item-link">
                    <i class="ri-user-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">View Orders</span>
                </a>
            </li>
            <li class="sidebar-menu-item">
                <a href="viewProfile.jsp" class="sidebar-menu-item-link">
                    <i class="ri-user-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">Profile</span>
                </a>
            </li>
            
        </ul>
    </div>

    <div class="main">
        <div class="container mt-5">
            <h1>Track Your Orders</h1>
            <div class="order-details">
                <h4>Order ID: <span class="order-id"><%= order.getOrderId() %></span></h4>
                <h4>Product Name: <span class="order-name"><%= order.getProductName() %></span></h4>
            </div>
            <div class="progress-container">
                <div class="progress-bar" style="width: 
                    <%= order.isDelivered() ? "100%" : 
                        order.isOutForDelivery() ? "75%" : 
                        order.isShipped() ? "50%" : 
                        order.isOrderPlaced() ? "25%" : 
                        "0%" %>;">
                </div>
            </div>
            <div class="status-label">
                <span class="label-placed <%= order.isOrderPlaced() ? "green" : "grey" %>">
                    <i class="ri-checkbox-circle-line"></i>
                    Order Placed
                </span>
                <span class="label-shipped <%= order.isShipped() ? "green" : "grey" %>">
                    <i class="ri-truck-line"></i>
                    Shipped
                </span>
                <span class="label-out-for-delivery <%= order.isOutForDelivery() ? "green" : "grey" %>">
                    <i class="ri-map-pin-line"></i>
                    Out for Delivery
                </span>
                <span class="label-delivered <%= order.isDelivered() ? "green" : "grey" %>">
                    <i class="ri-check-line"></i>
                    Delivered
                </span>
            </div>
        </div>
    </div>

    <script>
        function handleProfile() {
            // Redirect to the profile page
            window.location.href = "viewProfile.jsp";
        }

        function handleLogout() {
            // Redirect to the logout page
            window.location.href = "logout.jsp";
        }
    </script>
</body>
</html>
