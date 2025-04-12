<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ConsumerPojo" %>
<%
    // Retrieve the ConsumerPojo object from the session
    ConsumerPojo consumer = (ConsumerPojo) session.getAttribute("userobj");

    if (consumer == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if the profile is not found
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
    <title>View Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css" />
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .profile-header {
            background-color: #007bff;
            color: white;
            padding: 20px;
            border-radius: 5px 5px 0 0;
        }
        .profile-details {
            padding: 20px;
        }
        .btn-custom {
            background-color: #28a745;
            color: white;
        }
        .btn-custom:hover {
            background-color: #218838;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .card {
            max-width: 500px; /* Adjust the width */
            margin: 0 auto; /* Center the card */
        }
        /* Sidebar styles */
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
        .main {
            flex-grow: 1;
            margin-left: 250px;
            margin-top: 60px;
            padding: 20px;
            background-color: #f8f9fa;
            overflow-y: auto;
        }
        
        .profile-info p {
        padding: 10px 0;
        font-size: 18px; /* Increase font size for better readability */
    }

    .profile-info strong {
        color: #007bff; /* Change the color of labels */
    }

    .profile-header {
        background-color: #007bff;
        color: white;
        padding: 30px; /* Increased padding for better aesthetics */
        border-radius: 5px 5px 0 0;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Added shadow for depth */
    }

    .card {
        border: none; /* Remove default border */
        border-radius: 10px; /* Add rounded corners */
    }

    .btn-custom, .btn-danger {
        padding: 10px 20px; /* Increase padding for buttons */
        font-size: 16px; /* Increase font size for buttons */
    }

    .btn-custom:hover {
        background-color: #218838; /* Darker shade for hover */
    }

    .btn-danger:hover {
        background-color: #c82333; /* Darker shade for hover */
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
    <div class="container mt-5">
        <div class="card shadow">
            <div class="profile-header text-center">
                <h1>Consumer Profile</h1>
                <p><i class="fas fa-user-circle fa-5x"></i></p>
            </div>
            <div class="card-body profile-details">
                <h5 class="card-title">Profile Details</h5>
                <hr>
                <div class="profile-info">
                    <p><strong><i class="fas fa-id-badge"></i> Port ID:</strong> <%= consumer.getPortId() %></p>
                    <p><strong><i class="fas fa-map-marker-alt"></i> Location:</strong> <%= consumer.getLocation() %></p>
                    <p><strong><i class="fas fa-user-tag"></i> Role:</strong> <%= consumer.getRole() %></p>
                </div>
                <div class="mt-4 text-center">
                    <a href="updateProfile.jsp" class="btn btn-custom btn-lg">Update Profile</a>
                    <a href="login.jsp" class="btn btn-danger btn-lg">Logout</a>
                </div>
            </div>
        </div>
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

    <!-- Bootstrap JS and dependencies (Optional for Bootstrap components) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
