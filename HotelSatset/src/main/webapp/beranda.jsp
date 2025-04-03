<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking Page</title>

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

            .content-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                text-align: center;
                padding-top: 100px;
            }

            .header-logo {
                width: 100px;
            }

            .logo {
                width: 250px;
                margin-bottom: 20px;
            }

            .booking-form {
                margin-top: 20px;
            }

            .form-control {
                width: 45%;
                margin: 0 5px;
            }

            .btn-primary {
                background-color: blue;
                border: none;
                padding: 10px 20px;
                font-size: 1rem;
                text-transform: uppercase;
            }

            .btn-primary:hover {
                background-color: #7C6A4B;
            }

            @media (max-width: 576px) {
                .form-control {
                    width: 100%;
                    margin: 5px 0;
                }
            }

            a {
                text-decoration: none;
                color: white;
            }

        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="bg-main text-white p-4 fixed-top w-100">
            <div class="d-flex container align-items-start m-0" >
                <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo" class="header-logo">
            </div>
        </header>

        <!-- Background Image -->
        <img src="<%= request.getContextPath() %>/images/background.png" alt="Background" class="background-img">

        <!-- Content Container -->
        <div class="content-container">
            <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo" class="logo">

            <!-- Booking Form -->
            <div class="booking-form">
                <form action="RoomController">
                    <div class="row text-white mb-2">
                        <div class="col">Check In</div>
                        <div class="col">Check Out</div>
                    </div>
                    <div class="d-flex justify-content-center">
                        <input type="date" class="form-control" id="checkin" name="checkin" required>
                        <input type="date" class="form-control" id="checkout" name="checkout" required>
                    </div>

                    <button type="submit" class="btn btn-primary mt-3">Cek Ketersediaan Kamar</button>
                </form>
                <form action="ReservationController" method="get">
                    <a href="daftarPengunjung.jsp"><button type="submit" class="btn btn-primary mt-3">Lihat Data Pengunjung</button></a>
                </form>
                <form action="RoomController">
                    <input type="hidden" name="_method" value="all">
                    <a href="daftarKamar.jsp"><button type="submit" class="btn btn-primary mt-3">Lihat Data Kamar</button></a>
                </form>
            </div>
        </div>
            

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/js/bootstrap.min.js"></script>
    </body>
</html>
