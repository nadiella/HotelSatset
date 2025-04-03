                                                                /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import models.Reservation;
import models.Room;

@WebServlet("/ReservationController")
public class ReservationController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override   
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String method = request.getParameter("_method");

        if ("PUT".equalsIgnoreCase(method)) {
            doPut(request, response);
        } else if ("DELETE".equalsIgnoreCase(method)) {
            doDelete(request, response);
        } else {
            handleCreateReservation(request, response);
        }

    }

    @Override
      protected void doGet(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {
          String action = request.getParameter("action");
          if ("edit".equals(action)) {
              String id = request.getParameter("id");
              if (id != null && !id.isEmpty()) {
                  Reservation reservation = new Reservation();
                  reservation = reservation.find(id);
                  if (reservation != null) {
                      ArrayList<Room> room = new Room().get();
                      request.setAttribute("rooms", room);
                      request.setAttribute("reservation", reservation);
                      RequestDispatcher dispatcher = request.getRequestDispatcher("editKamar.jsp");
                      dispatcher.forward(request, response);
                  } else {
                      response.sendRedirect("daftarPengunjung.jsp?error=Reservation not found");
                  }
              } else {
                  response.sendRedirect("daftarPengunjung.jsp?error=Invalid ID");
              }

        } else {
            Reservation reservation = new Reservation();
            ArrayList<Reservation> reservations = reservation.get();
            request.setAttribute("book", reservations);
            RequestDispatcher dispatcher = request.getRequestDispatcher("daftarPengunjung.jsp");
            dispatcher.forward(request, response);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("daftarPengunjung.jsp");
        dispatcher.forward(request, response);
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            Reservation reservation = new Reservation();
            reservation.id = Integer.parseInt(id); 
            reservation.delete(); 
            if (reservation.getMessage().contains("rows affected")) {
                response.sendRedirect("ReservationController?success=1");
            } else {
                response.sendRedirect("ReservationController?error=" + reservation.getMessage());
            }
        } else {
            response.sendRedirect("ReservationController?error=Invalid ID");
        }
    }
    
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            Reservation reservation = new Reservation();
            reservation.setId(Integer.parseInt(id));
            reservation.setName(request.getParameter("name"));
            reservation.setPhoneNumber(request.getParameter("phone_number"));
            reservation.setCheckIn(request.getParameter("checkin"));
            reservation.setCheckOut(request.getParameter("checkout"));
            reservation.setRoomId(Integer.parseInt(request.getParameter("room_id")));

            reservation.update();

            if (reservation.getMessage().contains("rows affected")) {
                response.sendRedirect("ReservationController?success=1");
            } else {
                response.sendRedirect("ReservationController?error=" + reservation.getMessage());
            }
        } else {
            response.sendRedirect("ReservationController?error=Invalid ID");
        }
}

    
    private void handleCreateReservation(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phone_number");
        String checkIn = request.getParameter("checkin");
        String checkOut = request.getParameter("checkout");
        String roomIdStr = request.getParameter("room_id");

        if (name == null || phoneNumber == null || checkIn == null || checkOut == null || roomIdStr == null) {
            response.getWriter().println("Error: Missing required fields.");
            return;
        }

        int roomId;
        try {
            roomId = Integer.parseInt(roomIdStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Error: Invalid room ID.");
            return;
        }

        Reservation reservation = new Reservation();
        reservation.setName(name);
        reservation.setPhoneNumber(phoneNumber);
        reservation.setCheckIn(checkIn);
        reservation.setCheckOut(checkOut);
        reservation.setRoomId(roomId);

        try {
            reservation.insert();
            response.sendRedirect("beranda.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

}
