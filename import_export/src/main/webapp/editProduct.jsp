<%@page import="operationsImp.ProductImp"%>
<%@page import="model.ProductPojo"%>
<%@page import="model.SellerPojo"%>

<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" %>

<%
    // Check if the session contains a seller object
    SellerPojo seller = (SellerPojo) session.getAttribute("seller");
    
    if (seller == null) {
        // If no seller is logged in, redirect to the login page
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css" />
    <style>
        /* Common styles for sidebar and navbar */
        .sidebar {
            background-color: #000;
            width: 250px;
            height: calc(100vh - 60px); /* Sidebar height */
            position: fixed;
            top: 60px; /* Start below navbar */
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
            color: black; /* Text color for sidebar links */
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
            width: 100%; /* Navbar full width */
            position: fixed;
            top: 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            z-index: 1; /* Navbar above sidebar */
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
            background-color: #ff4d4d; /* Red background for logout */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .navbar .logout-button:hover {
            background-color: #ff6666; /* Lighter red on hover */
        }
        .main {
            margin-left: 250px; /* Space for sidebar */
            margin-top: 60px; /* Space for navbar */
            padding: 20px;
            background-color: #f8f9fa;
            overflow-y: auto;
        }
        .container {
            max-width: 600px; /* Limit container width */
            padding: 40px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.15);
            transition: box-shadow 0.3s ease;
            margin: 20px auto; /* Center the container */
        }
        .container:hover {
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        .container h2 {
            font-weight: bold;
            font-size: 28px;
            margin-bottom: 30px;
        }
        .form-control {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #ddd;
            transition: all 0.3s;
        }
        .form-control:focus {
            border-color: #4a90e2;
            box-shadow: 0 0 8px rgba(74, 144, 226, 0.4);
        }
        .btn-primary {
            border-radius: 8px;
            padding: 10px 16px;
            font-weight: 600;
            background-color: #4a90e2;
            border: none;
        }
        .btn-primary:hover {
            background-color: #357ab8;
            box-shadow: 0 4px 15px rgba(53, 122, 184, 0.4);
        }
        .btn-secondary {
            border-radius: 8px;
            padding: 10px 16px;
            font-weight: 600;
            background-color: #6c757d;
            color: white;
            border: none;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
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
            <h2 class="text-center mb-4">Update Product</h2>
            <%
                // Get product ID from request parameters
                int productId = Integer.parseInt(request.getParameter("productId"));
                ProductPojo pojo = new ProductPojo(); // Instantiate your DAO
                ProductPojo product = pojo.getProductById(productId); // Retrieve product details

                // Check if product details are retrieved successfully
                if (product != null) {
            %>
                <form action="UpdateProduct" method="post" style="margin-top: 20px;">
                    <input type="hidden" name="action" value="update"/> <!-- Action parameter -->
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>"/>

                    <!-- Form Group for Product Name -->
                    <div class="form-group mb-4">
                        <label for="productName">Product Name</label>
                        <input type="text" class="form-control" id="productName" name="productName" value="<%= product.getProductName() %>" required>
                    </div>

                    <!-- Form Group for Quantity -->
                    <div class="form-group mb-4">
                        <label for="quantity">Quantity</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" value="<%= product.getQuantity() %>" required>
                    </div>

                    <!-- Form Group for Price -->
                    <div class="form-group mb-4">
                        <label for="price">Price</label>
                        <input type="number" class="form-control" id="price" name="price" value="<%= product.getPrice() %>" required>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Update Product</button>
                        <a href="allProducts.jsp" class="btn btn-secondary">Back</a>
                    </div>
                </form>
            <%
                } else {
                    out.println("<p>Product not found!</p>");
                }
            %>
        </div>
    </div>

    <script>
        function handleLogout() {
            if (confirm("Are you sure you want to log out?")) {
                window.location.href = "LogoutServlet"; // Redirect to logout servlet
            }
        }
    </script>
</body>
</html>