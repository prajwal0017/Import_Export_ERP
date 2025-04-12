<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="model.ConsumerPojo" %>
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
    <title>Update Consumer</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css" />

    <style>
        /* Common styles for sidebar and navbar */
        .sidebar {
            background-color: #000;
            width: 250px;
            height: calc(100vh - 60px); /* Reduced height so it fits below the navbar */
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
            margin-top: 90px;
            padding: 20px;
            background-color: #f8f9fa;
            overflow-y: auto;
        }

       .container {
    max-width: 600px; /* Set to a smaller width as needed */
    margin: 20px auto;
    padding: 40px;
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 6px 25px rgba(0, 0, 0, 0.15);
}
       

        .form-control {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #ddd;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.4);
        }

        .btn-primary, .btn-danger {
            border-radius: 8px;
            padding: 10px 16px;
            font-weight: 600;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-danger:hover {
            background-color: #c82333;
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
    

    <!-- Main Content -->
    <div class="main">
        <div class="container">
            <h1>Update Consumer Profile</h1>

            <%
                // Retrieve the consumer's details from session
                ConsumerPojo consumer = (ConsumerPojo) session.getAttribute("userobj");
                String portId = (String) session.getAttribute("portId");

              
            %>

           <!-- Update Consumer Profile Form -->
<!-- Update Consumer Profile Form -->
<!-- Flex container for buttons -->
<!-- Update Consumer Profile Form -->
<!-- Update Consumer Profile Form -->
<form action="UpdateProfile" method="post" class="update-form d-inline">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="port_id" value="<%= portId %>">

    <!-- Form Group for New Password -->
    <div class="form-group">
        <label for="new_password">New Password:</label>
        <input type="password" class="form-control" id="new_password" name="new_password" placeholder="Leave blank to keep current password">
    </div>

    <!-- Form Group for New Location -->
    <div class="form-group">
        <label for="new_location">New Location:</label>
        <input type="text" class="form-control" id="new_location" name="new_location" placeholder="Leave blank to keep current location" value="<%= consumer.getLocation() %>">
    </div>

    <!-- Flex container for buttons -->
    <div class="d-flex align-items-center mt-3">
        <!-- Update button -->
        <button type="submit" class="btn btn-primary me-2">Update Consumer</button>
    </div>
</form>

<!-- Separate form for deleting the consumer to avoid conflicts -->
<form action="UpdateProfile" method="post" class="d-inline">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" name="port_id" value="<%= portId %>">

    <!-- Delete button in same flex container -->
    <div class="d-flex align-items-center mt-3">
        <button type="submit" class="btn btn-danger">Delete Account</button>
    </div>
</form>




           
            
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
