<%@page import="models.Room"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kamar yang Tersedia</title>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>

        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <style>
            body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    background-color: #F8F4E3;
}

header {
    background-color: #9F8657;
    padding: 20px;
    color: white;
    text-align: left;
}

.container-room {
    padding: 20px;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1em;
    justify-content: center;
    text-align: center;
    max-width: 1200px;
    margin: 0 auto;
}

.room-card {
    display: flex;
    justify-content: center;
    background-color: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    width: 100%; /* Diubah dari max-content */
}

.room-card img {
    width: 250px;
    height: 200px;
    object-fit: cover;
    flex-shrink: 0;
}

.room-details {
    padding: 20px;
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: start;
    width: 100%;
}

.room-title {
    font-size: 1.5em;
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
}

.room-price {
    font-size: 1.2em;
    font-weight: bold;
    color: #9F8657;
}

.room-price span {
    font-size: 0.9em;
    color: #666;
}

.btn-book {
    background-color: #9F8657;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    text-decoration: none;
    cursor: pointer;
    font-size: 1em;
    transition: background-color 0.3s;
    width: 100%;
    margin-top: 15px;
}

.btn-book:hover {
    background-color: #7C6A4B;
}

.btn-book a {
    color: white;
    text-decoration: none;
}

.btn-view-visitors {
    margin-top: 20px;
    background-color: #007BFF;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    text-decoration: none;
    cursor: pointer;
    font-size: 1em;
    transition: background-color 0.3s;
}

.btn-view-visitors:hover {
    background-color: #0056b3;
}

.no-rooms-message {
    font-size: 1.2em;
    color: #333;
    margin-top: 20px;
}

/* Responsif untuk layar kecil */
@media (max-width: 768px) {
    .container-room {
        grid-template-columns: 1fr;
    }
    
    .room-card {
        flex-direction: column;
    }
    
    .room-card img {
        width: 100%;
        height: 200px;
    }
    
    .room-details {
        padding: 15px;
    }
}
        </style>
    </head>
    <body>
        <header class="bg-main text-white p-4 fixed-top w-100">
            <div class="d-flex container align-items-start m-0" >
                <a href="beranda.jsp">
                    <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo" class="header-logo">
                </a>
            </div>
        </header>

        <div class="container-room">
            <% 
                ArrayList<Room> prods = (ArrayList<Room>)request.getAttribute("list");
                String checkin = (String) request.getParameter("checkin");
                String checkout = (String) request.getParameter("checkout");
                if (prods != null && !prods.isEmpty()) {
                    for (Room p : prods) {
            %>
            <div class="room-card">
                <img src="${pageContext.request.contextPath}/images/room.png" alt="<%= p.getTipekamar() %>">
                <div class="room-details">
                    
                        <div class="room-title"><%= p.getTipekamar() %></div>
                        <div class="room-price">IDR <%= p.getHarga() %> <span>/ Malam</span></div>
                    
                    <form action="data.jsp" method="get">
                        <input type="hidden" name="id" value="<%= p.getId() %>">
                        <input type="hidden" name="checkin" value="<%= checkin %>">
                        <input type="hidden" name="checkout" value="<%= checkout %>">
                        <button type="submit" class="btn-book">Book Now</button>
                    </form>
                </div>
            </div>
            <% 
                    }
                } else {
            %>
            <p class="no-rooms-message">No rooms available for the selected dates.</p>
            <% 
                } 
            %>
        </div>

        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
