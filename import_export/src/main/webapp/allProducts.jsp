<%@page import="operationsImp.ProductImp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.ProductPojo" %>
<%@ page import="java.util.List" %>
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
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin: All Products</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css" />

    <style>
        /* Reuse sidebar and navbar styles from Seller Dashboard */
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
            margin-left: 250px;
            margin-top: 80px; /* Increased from 60px to 80px to move it down */
            padding: 20px;
            background-color: #f8f9fa;
            height: calc(100vh - 80px); /* Adjusted to keep the full height minus navbar */
            overflow-y: auto; /* Enable scrolling if content overflows */
        }

        h2 {
            margin-bottom: 20px; /* Space below the heading */
            color: #343a40; /* Darker color for the heading */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px; /* Rounded corners */
            overflow: hidden; /* Ensures that rounded corners are respected */
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #007bff; /* Primary color for headers */
            color: white; /* White text for better contrast */
            font-weight: bold;
        }

        tbody tr {
            transition: background-color 0.3s; /* Smooth transition for hover effect */
        }

        tbody tr:nth-child(odd) {
            background-color: #f9f9f9; /* Light gray for odd rows */
        }

        tbody tr:nth-child(even) {
            background-color: #ffffff; /* White for even rows */
        }

        tbody tr:hover {
            background-color: #e0e0e0; /* Light hover effect */
            cursor: pointer;
        }

        /* Optional: Style for action buttons */
        .btn {
            padding: 6px 12px; /* Consistent padding for buttons */
            border-radius: 5px; /* Rounded corners for buttons */
            border: none; /* Remove default button border */
            font-size: 14px; /* Font size for buttons */
        }

        .btn:hover {
            opacity: 0.8; /* Slightly transparent on hover for effect */
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
            <li class="sidebar-menu-item ">
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
            <h2>All Products</h2>
            <div class="mb-3">
                <a href="addProduct.jsp" class="btn btn-primary">Add Product</a>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
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
                        <td><%= p.getProductId() %></td>
                        <td><%= p.getProductName() %></td>
                        <td><%= p.getQuantity() %></td>
                        <td><%= p.getPrice() %></td>
                        <td>
                            <a href="editProduct.jsp?productId=<%= p.getProductId() %>" class="btn btn-warning">
                                Update
                            </a>
                            <form action="UpdateProduct" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this product?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" class="text-center">No products available.</td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
   
    <script>
        function handleLogout() {
            window.location.href = 'LogoutServlet';
        }
    </script>
</body>
</html>