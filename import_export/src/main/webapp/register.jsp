<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="all_component/allCss.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Page</title>
    <!-- Include Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://static.vecteezy.com/system/resources/previews/041/053/506/non_2x/abstract-dark-background-with-shapes-gradient-orange-smooth-liquid-color-design-template-good-for-modern-website-wallpaper-cover-design-vector.jpg');
            background-size: cover;
            background-position: center;
            font-family: 'Arial', sans-serif;
            color: #4B4B4B;
        }

        #register-card {
            width: 400px;
            border-radius: 15px;
            background-color: rgba(255, 255, 255, 0.95);
            transition: 0.3s;
            margin-top: 100px;
            padding: 2rem;
        }

        h2 {
            color: #4B4B4B;
        }

        .btn-primary {
            background-color: #333;
            border: none;
            color: white;
            width: 100%;
            padding: 15px;
            margin: 5px 0;
        }

        .btn-primary:hover {
            background-color: #555;
        }

        .form-control {
            background-color: #fff;
            border: 1px solid #4B4B4B;
            color: #4B4B4B;
        }

        label {
            color: #4B4B4B;
        }

        #message-bar {
            margin-top: 15px;
            color: red;
            text-align: center;
            font-weight: bold;
        }

        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow-lg rounded" id="register-card">
            <h2 class="text-center mb-4">Register</h2>
            <div class="card-body">
                <form method="post" action="RegisterController" id="registerForm" onsubmit="return validateForm();">
                    <div class="form-group">
                        <label for="portId">Port ID</label>
                        <input type="text" class="form-control" id="portId" name="port_id" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <div class="form-group mb-4">
                        <label for="role">Role</label>
                        <select class="form-control" id="role" name="role" required>
                            <option value="" disabled selected>Select your role</option>
                            <option value="Consumer">Consumer</option>
                            <option value="Seller">Seller</option>
                        </select>
                    </div>
                    <!-- Hidden location field by default -->
                    <div class="form-group hidden" id="locationField">
                        <label for="location">Location</label>
                        <input type="text" class="form-control" id="location" name="location">
                    </div>
                   
                    <button type="submit" class="btn btn-primary">Register</button>
                </form>
                <div class="text-center mt-3">
                    <a href="login.jsp">Already have an account? Login here</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Notification -->
    <div class="toast align-items-center text-white bg-success" id="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                Registration Successful!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>

    <!-- Include Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JS for Role-based Location Field -->
    <script>
        const roleSelect = document.getElementById('role');
        const locationField = document.getElementById('locationField');
        const locationInput = document.getElementById('location');

        // Initially hide location field
        locationField.classList.add('hidden');
        locationInput.required = false;

        // Event listener for role selection
        roleSelect.addEventListener('change', function() {
            if (roleSelect.value === 'Consumer') {
                locationField.classList.remove('hidden');  // Show location field for 'Consumer'
                locationInput.required = true;             // Make location required
            } else {
                locationField.classList.add('hidden');     // Hide location field for 'Seller'
                locationInput.required = false;            // Remove 'required' attribute
            }
        });

        // Validation function to check password matching
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;

            if (password !== confirmPassword) {
                alert("Passwords do not match. Please try again.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
