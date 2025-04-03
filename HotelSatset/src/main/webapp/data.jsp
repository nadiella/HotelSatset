<%-- 
    Document   : data.jsp
    Created on : Jan 2, 2025, 4:58:42 PM
    Author     : nadie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SATSET Hotel</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: Arial, sans-serif;
            background-color: #F8F4E3;
        }

        .bg-main {
            background-color: #9F8657;
        }

        .background-img {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            object-fit: cover;
            z-index: -1;
        }

        .form-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-box {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 20px 30px;
            width: 300px;
            text-align: center;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        }

        .form-box h2 {
            margin-bottom: 20px;
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }

        .form-box input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-box button {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            background-color: blue;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .form-box button:hover {
            background-color: #003cb3;
        }

        .header-logo {
            width: 100px;
        }

        .logo {
            width: 250px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="bg-main text-white p-4 fixed-top w-100">
        <div class="d-flex container align-items-start m-0">
            <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo" class="header-logo">
        </div>
    </header>

    <!-- Background Image -->
    <img src="<%= request.getContextPath() %>/images/background.png" alt="Background" class="background-img">

    <div class="form-container">
        <div class="form-box">
            
            <h2>FORMULIR</h2>
            <%
                String roomId = request.getParameter("id");
                String checkin = request.getParameter("checkin");
                String checkout = request.getParameter("checkout");
                if (roomId == null || roomId.isEmpty()) {
                    out.println("<p style='color:red;'>No room selected. Please go back and select a room.</p>");
                } else {
                    out.println("<p>Booking Room ID: " + roomId + "</p>");
                }
            %>
            
            <form action="ReservationController" method="post">
                <input type="hidden" name="room_id" value="<%= roomId %>">
                <input type="hidden" name="checkin" value="<%= checkin %>">
                <input type="hidden" name="checkout" value="<%= checkout %>">
                <input type="text" name="name" placeholder="Name" required>
                <input type="text" name="phone_number" placeholder="Mobile Number" required>
                <button type="submit">Book</button>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/js/bootstrap.min.js"></script>
</body>
</html>
