<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
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
    <title>Add Product</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css">

    <style>
        /* Common styles for sidebar and navbar */
        body {
            background-color: #fbfbfb;
            margin: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
            font-family: 'Roboto', sans-serif;
        }

        .sidebar {
    background-color: #000;
    width: 250px;
    height: calc(100vh - 60px); /* Reduced height to fit below the navbar */
    position: fixed;
    top: 60px; /* Start the sidebar below the navbar */
    left: 0;
    padding: 20px;
    color: white;
    overflow-y: auto;
    scrollbar-width: none; /* Hides scrollbar for Firefox */
}

/* Hide scrollbar for Chrome, Safari, and Edge */
.sidebar::-webkit-scrollbar {
    display: none;
}

/* Hide scrollbar for Internet Explorer and Edge */
.sidebar {
    -ms-overflow-style: none; /* IE and Edge */
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
            color: black;
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
            width: 100%; /* Navbar spans full width */
            position: fixed;
            top: 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
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

        /* Main content styles */
        main {
            margin-left: 250px;
            margin-top: 60px;
            flex-grow: 1;
            background-color: #f8f9fa;
            overflow-y: auto;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.15);
            transition: box-shadow 0.3s ease;
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

        .form-group label {
            font-weight: 500;
            margin-bottom: 10px;
        }

        .btn-primary {
            border-radius: 8px;
            padding: 10px 16px;
            font-weight: 600;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            background-color: #4a90e2;
            border: none;
        }

        .btn-primary:hover {
            background-color: #357ab8;
            box-shadow: 0 4px 15px rgba(53, 122, 184, 0.4);
        }

        .btn-outline-secondary, .btn-outline-danger {
            border-radius: 50px;
            font-weight: 600;
            transition: transform 0.2s ease;
        }

        .btn-outline-danger:hover {
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
        }

        button:hover {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        
        .sidebar::-webkit-scrollbar {
    display: none; /* Hides scrollbar for Chrome, Safari, and Edge */
}
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="navbar">
            <a href="sellerDashboard.jsp" class="logo">
    <h1>Seller Dashboard</h1>
</a>
        <button class="logout-button" onclick="handleLogout()">Log Out</button>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul class="sidebar-menu">
            <li class="sidebar-menu-item">
                <a href="addProduct.jsp" class="sidebar-menu-item-link">
                    <i class="ri-add-line sidebar-menu-item-link-icon"></i>
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
                    <i class="ri-box-line sidebar-menu-item-link-icon"></i>
                    <span class="sidebar-menu-item-link-text">View Products</span>
                </a>
            </li>
        </ul>
    </div>
    <!-- end: Navbar -->

    <!-- Main content -->
    <main>
        <div class="container mt-5 p-5">
            <h2>Add New Product</h2>
            <form action="AddProductController" method="post" novalidate>
                <div class="form-group mb-4">
                    <label for="product_id">Product ID:</label>
                    <input type="number" class="form-control" id="product_id" name="product_id" required placeholder="Enter product ID">
                </div>
                <div class="form-group mb-4">
                    <label for="product_name">Product Name:</label>
                    <input type="text" class="form-control" id="product_name" name="product_name" required placeholder="Enter product name">
                </div>
                <div class="form-group mb-4">
                    <label for="quantity">Product Quantity:</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" required placeholder="Enter product quantity">
                </div>
                <div class="form-group mb-4">
                    <label for="price">Product Price:</label>
                    <input type="number" class="form-control" id="price" name="price" required placeholder="Enter product price" step="0.01">
                </div>
                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">Add Product</button>
                    <button type="button" class="btn btn-outline-danger" onclick="window.location.href='sellerDashboard.jsp'">Cancel</button>
                </div>
            </form>
        </div>
    </main>
    <!-- end: Main content -->

    <script>
        function handleLogout() {
            // Implement logout functionality
            alert('Logged out successfully!');
            window.location.href = 'logout.jsp'; // Redirect to logout page
        }
        
        function handleLogout() {
            window.location.href = 'LogoutServlet'; // Redirect to LogoutServlet
        }
    </script>
</body>
</html>
