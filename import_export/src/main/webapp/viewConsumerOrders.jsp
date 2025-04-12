<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.OrdersPojo" %>
<%@ page import="model.ConsumerPojo"%>

<%
    ConsumerPojo consumer = (ConsumerPojo) session.getAttribute("userobj");

    if (consumer == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    List<OrdersPojo> orderList = (List<OrdersPojo>) request.getAttribute("orderList");
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
        .sidebar-menu-item-link:hover {
            background-color: #333;
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
        .navbar h1 {
            color: white;
            margin: 0;
            font-size: 24px;
        }
        .navbar .navbar-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-right: 20px;
        }
        .navbar .navbar-button:hover {
            background-color: #0056b3;
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
        .progress-button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .progress-button:hover {
            background-color: #218838;
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
        <h1>Order List</h1>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Order Date</th>
                <th>Action</th>
            </tr>
            <%
                if (orderList != null && !orderList.isEmpty()) {
                    for (OrdersPojo order : orderList) {
            %>
            <tr>
                <td><%= order.getOrderId() %></td>
                <td><%= order.getProductId() %></td>
                <td><%= order.getProductName() %></td>
                <td><%= order.getQuantity() %></td>
                <td><%= order.getOrderDate() %></td>
                <td>
                    <form action="orderProgress.jsp" method="get">
                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>" />
                        <button type="submit" class="progress-button">View Progress</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="6">No orders found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <script>
        function handleProfile() {
            window.location.href = 'LogoutServlet';
        }

        function handleLogout() {
            // Implement logout logic
            window.location.href = 'logout.jsp'; // Redirect to logout page
        }
    </script>
</body>
</html>
