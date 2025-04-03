<%-- 
    Document   : editKamar
    Created on : Jan 6, 2025, 11:50:43 PM
    Author     : Ando Holle
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="models.Room"%>
<%@page import="models.Reservation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Booking</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #F8F4E3;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h1>Edit Booking</h1>
            <%
                // Ambil data reservasi dan daftar kamar dari request attribute
                Reservation reservation = (Reservation) request.getAttribute("reservation");
                ArrayList<Room> rooms = (ArrayList<Room>) request.getAttribute("rooms");

                if (reservation != null && rooms != null) {
            %>
            <form action="ReservationController" method="POST">
                <input type="hidden" name="_method" value="PUT">
                <input type="hidden" name="id" value="<%= reservation.getId() %>">

                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%= reservation.getName() %>" required>
                </div>

                <div class="mb-3">
                    <label for="phone_number" class="form-label">Phone Number</label>
                    <input type="text" class="form-control" id="phone_number" name="phone_number" value="<%= reservation.getPhoneNumber() %>" required>
                </div>

                <div class="mb-3">
                    <label for="room_id" class="form-label">Room Type</label>
                    <select class="form-select" id="room_id" name="room_id" required>
                        <% for (Room room : rooms) { %>
                            <option value="<%= room.getId() %>" <%= reservation != null && reservation.getRoomId() == room.getId() ? "selected" : "" %>>
                                <%= room.getTipekamar()%>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="checkin" class="form-label">Check-in Date</label>
                    <input type="date" class="form-control" id="checkin" name="checkin" value="<%= reservation.getCheckIn() %>" required>
                </div>

                <div class="mb-3">
                    <label for="checkout" class="form-label">Check-out Date</label>
                    <input type="date" class="form-control" id="checkout" name="checkout" value="<%= reservation.getCheckOut() %>" required>
                </div>

                <button type="submit" class="btn btn-primary">Update Booking</button>
            </form>
            <% } else { %>
            <p>Data reservation or rooms not found.</p>
            <% } %>
        </div>
    </body>
</html>
