<%@page import="models.Room"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Kamar</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #F8F4E3;
            margin: 200px auto
        }

        header {
            display: flex;
            align-items: center;
            background-color: #9F8657;
            padding: 20px 30px;
            color: white;
        }

        .header-title {
            font-size: 28px;
            font-weight: bold;
            margin: 0;
        }

        h1 {
            text-align: center;
            font-size: 32px;
            margin: 40px 0 20px 0;
            color: #333;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            font-size: 18px;
            background-color: #fff;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #b08f4b; 
            color: white;
        }

        td {
            background-color: #fefefe;
        }

        .center {
            text-align: center;
            font-size: 20px;
            color: #666;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <header class="bg-main text-white p-4 fixed-top w-100">
        <div class="d-flex container align-items-start m-0">
            <a href="beranda.jsp">
                <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo" class="header-logo">
            </a>
        </div>
    </header>
    <div class="container">
        <h1>Data Kamar</h1>
        <center>
            <div class="actions">
                <!-- Tombol Tambah Kamar -->
                <a href="RoomController?_method=tambah" class="btn btn-primary">Tambah Kamar</a>
            </div>
        </center>  
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tipe Kamar</th>
                    <th>Harga</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<Room> rooms = (ArrayList<Room>) request.getAttribute("rooms");
                    if (rooms != null && !rooms.isEmpty()) {
                        for (Room room : rooms) {
                %>
                <tr>
                    <td><%= room.getId() %></td>
                    <td><%= room.getTipekamar()%></td>
                    <td><%= room.getHarga() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="3" class="center">Tidak ada data kamar tersedia.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
