/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import models.Room;

/**
 *
 * @author Ando Holle
 */
@WebServlet(name = "RoomController", urlPatterns = {"/RoomController"})
public class RoomController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("_method");

        if ("all".equalsIgnoreCase(method)) {
            allRoom(request, response);
        } else if("tambah".equalsIgnoreCase(method)){
            response.sendRedirect("tambahKamar.jsp");
        }else {
            availRoom(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String tipeKamar = request.getParameter("tipe_kamar");
        String harga = request.getParameter("harga");

        if (tipeKamar == null || tipeKamar.isEmpty() || harga == null || harga.isEmpty()) {
            request.setAttribute("error", "Semua field harus diisi!");
            request.getRequestDispatcher("tambahKamar.jsp").forward(request, response);
            return;
        }

        Room room = new Room();
        room.setTipekamar(tipeKamar);
        room.setPrice(harga);

        try {
            room.insert();
            response.sendRedirect("RoomController?_method=all");
        } catch (Exception e) {
            request.setAttribute("error", "Gagal menambahkan kamar: " + e.getMessage());
            request.getRequestDispatcher("tambahKamar.jsp").forward(request, response);
        }
    }
    
    protected void allRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "Daftar Kamar");
        
        ArrayList<Room> rooms = new Room().get();
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("daftarKamar.jsp").forward(request, response);
        request.getSession().removeAttribute("msg");
    }
    
    protected void availRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String checkin = request.getParameter("checkin");
        String checkout = request.getParameter("checkout");
        if (checkin == null || checkin.isEmpty()) {
            checkin = LocalDate.now().toString();
        }
        if (checkout == null || checkout.isEmpty()) {
            checkout = LocalDate.now().plusDays(1).toString();
        }
        Room roomModel = new Room();
        ArrayList<Room> availableRooms = roomModel.getAvailableRooms(checkin, checkout);

        request.setAttribute("list", availableRooms);
        request.setAttribute("checkin", checkin);
        request.setAttribute("checkout", checkout);
        request.getRequestDispatcher("pilihKamar.jsp").forward(request, response);
    }
}
