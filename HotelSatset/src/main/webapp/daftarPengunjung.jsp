<%-- 
    Document   : data.jsp
    Created on : Jan 2, 2025, 4:58:42 PM
    Author     : nadie
--%>

<%@page import="models.Reservation"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Pengunjung</title>
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
            <div class="d-flex container align-items-start m-0" >
                <a href="beranda.jsp">
                    <img  src="<%= request.getContextPath() %>/images/logo.png" alt="Logo" class="header-logo">
                </a>
            </div>
     </header>   
    <div class="container">
        <h1>Data Reservasi</h1>
        <table>
            <thead>
                <tr>
                    <th>Nama</th>
                    <th>No. Telepon</th>
                    <th>Room ID</th>
                    <th>Tanggal Check-In</th>
                    <th>Tanggal Check-Out</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<Reservation> reservations = (ArrayList<Reservation>) request.getAttribute("book");
                    if (reservations != null && !reservations.isEmpty()) {
                        for (Reservation r : reservations) {
                %>
                <tr>
                    <td><%= r.getName() %></td>
                    <td><%= r.getPhoneNumber() %></td>
                    <td><%= r.getRoomId() %></td>
                    <td><%= r.getCheckIn() %></td>
                    <td><%= r.getCheckOut() %></td>
                    <td>
                        <div class="d-flex gap-2">
                            
                            <form action="ReservationController" method="GET">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="id" value="<%= r.getId() %>">
                                <button class="btn btn-warning" type="submit">Edit</button>
                            </form>

                            <form action="ReservationController" method="post" onsubmit="return confirm('Apakah Anda yakin ingin menghapus data ini?')">
                                <input type="hidden" name="id" value="<%= r.getId() %>">
                                <input type="hidden" name="_method" value="DELETE">
                                <button class="btn btn-danger" type="submit">Hapus</button>
                            </form>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5" class="center">Tidak ada pengunjung terdaftar.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
