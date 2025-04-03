<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Page</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
            background-image: url('<%= request.getContextPath() %>/images/background.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .header {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #9F8657; 
            padding: 10px 20px;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .header-logo {
            width: 100px;
            margin-right: 40px;
        }

        .header-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: white;
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 40px;
            width: 400px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .header-text {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 20px;
            color: #9F8657; 
        }

        .form-control {
            margin-bottom: 20px;
            border-radius: 5px;
            padding: 10px;
        }

        .btn-login {
            background-color: #9F8657;
            border: none;
            padding: 10px 20px;
            width: 100%;
            color: white;
            font-size: 16px;
            border-radius: 5px;
        }

        .btn-login:hover {
            background-color: #7C6A4B;
        }

        .alert {
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
            font-size: 14px;
        }

        .alert-success {
            color: white;
            background-color: #28a745;
            border: 1px solid #28a745;
        }

        .alert-danger {
            color: white;
            background-color: #dc3545;
            border: 1px solid #dc3545;
        }
    </style>
</head>
<body>

    <div class="header">
        <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo" class="header-logo">
    </div>

    <div class="login-container">
        <div class="header-text">DAFTAR</div>

        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if ("true".equals(success)) {
        %>
            <div class="alert alert-success">
                Pendaftaran berhasil! Silakan login.
            </div>
        <%
            } else if ("true".equals(error)) {
        %>
            <div class="alert alert-danger">
                Pendaftaran gagal. Username mungkin sudah digunakan.
            </div>
        <%
            }
        %>

        <form action="authController" method="POST">

            <input type="hidden" name="action" value="register">
            <input type="text" class="form-control" name="username" placeholder="Username" required>
            <input type="password" class="form-control" name="password" placeholder="Password" required>
            <button type="submit" class="btn-login">DAFTAR</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/js/bootstrap.min.js"></script>
</body>
</html>
