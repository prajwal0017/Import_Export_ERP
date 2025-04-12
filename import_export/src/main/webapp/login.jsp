<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="all_component/allCss.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://static.vecteezy.com/system/resources/previews/041/053/506/non_2x/abstract-dark-background-with-shapes-gradient-orange-smooth-liquid-color-design-template-good-for-modern-website-wallpaper-cover-design-vector.jpg');
            background-size: cover;
            background-position: center;
            font-family: 'Arial', sans-serif;
            color: #4B4B4B;
        }

        #login-card {
            width: 400px;
            border-radius: 15px;
            background-color: rgba(255, 255, 255, 0.95);
            transition: 0.3s;
            margin-top: 100px;
            padding: 2rem;
        }

        h2, .form-label {
            color: #4B4B4B;
        }

        .btn-custom {
            background-color: #333;
            border: none;
            color: white;
            width: 100%;
            padding: 15px;
            margin: 5px 0;
            transition: background-color 0.3s ease-in-out;
        }

        .btn-custom:hover {
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

        a {
            color: #0072ff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .container-fluid {
            max-width: 500px;
        }

        /* Toast positioning */
        .toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            min-width: 250px;
        }
    </style>
</head>
<body>
    <div class="container-fluid d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow-lg rounded" id="login-card">
            <div class="card-header bg-transparent text-center">
                <i class="fas fa-user fa-3x text-dark"></i>
                <h2 class="mt-3">Login</h2>
            </div>
            <div class="card-body">
                <form method="post" action="LoginController" onsubmit="handleFormSubmit(event);">
                    <div class="mb-3">
                        <label for="portId" class="form-label">Enter Port ID</label>
                        <input type="text" class="form-control" id="portId" name="port_id" required>
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label">Enter Password</label>
                        <input type="password" class="form-control" id="exampleInputPassword1" name="password" required>
                    </div>
                    <div class="mb-4">
                        <label for="role" class="form-label">Select Role</label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="" disabled selected>Select your role</option>
                            <option value="Consumer">Consumer</option>
                            <option value="Seller">Seller</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-custom w-100 text-uppercase">Login</button>
                </form>
                <div class="text-center mt-3">
                    <p>Don't have an account? <a href="register.jsp">Register now</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Notification -->
    <div class="toast align-items-center text-white bg-success" id="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                Login Successful!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Optional JavaScript to handle form submission
    </script>
</body>
</html>
