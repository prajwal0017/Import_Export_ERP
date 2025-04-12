<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="database.GetConnection" %> <!-- Adjust package name accordingly -->
<%@ page import="operationsImp.ReportedProductsImp" %> 
<%@ page import="model.ReportedProductsPojo" %>
<%@ page import="java.io.IOException" %>

<%@ page import="model.SellerPojo"%>
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
    
    // Retrieve the reported products list from the request
    List<ReportedProductsPojo> reportedProductsList = (List<ReportedProductsPojo>) request.getAttribute("reportedProductsList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reported Products</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css" />

    <style>
        body {
            margin: 0;
            display: flex;
            height: 100vh;
            flex-direction: column;
            overflow: hidden;
            font-family: 'Roboto', sans-serif;
        }

        /* Common styles for sidebar and navbar */
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
            max-width: 800px;
            margin: 20px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.15);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            background-color: white;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f4f4f4;
            color: #333;
        }

        tr:hover {
            background-color: #f1f1f1;
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
            <li class="sidebar-menu-item ">
                <a href="reportedProducts.jsp" class="sidebar-menu-item-link">
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
            <h2>Reported Products</h2>
            <table>
                <tr>
                    <th>Report ID</th>
                    <th>Consumer Port ID</th>
                    <th>Product ID</th>
                    <th>Issue Type</th>
                    <th>Solution</th>
                </tr>
                <%
                    if (reportedProductsList != null) {
                        for (ReportedProductsPojo reportedProduct : reportedProductsList) {
                %>
                <tr>
                    <td><%= reportedProduct.getReportId() %></td>
                    <td><%= reportedProduct.getConsumerPortId() %></td>
                    <td><%= reportedProduct.getProductId() %></td>
                    <td><%= reportedProduct.getIssueType() %></td>
                    <td><%= reportedProduct.getSolution() != null ? reportedProduct.getSolution() : "Pending" %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">No reported products found.</td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
    </div>

    <script>
        function handleLogout() {
            window.location.href = 'login.jsp'; // Redirect to login page
        }
        
        function handleLogout() {
            window.location.href = 'LogoutServlet'; // Redirect to LogoutServlet
        }
    </script>
</body>
</html>
