/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

/**
 *
 * @author nadie
 */

package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.akun;


@WebServlet(name = "authController", urlPatterns = {"/authController"})
public class authController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equalsIgnoreCase(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            if (akun.register(username, password)) {
                request.getSession().setAttribute("msg", "Registrasi Sukses!");
                response.sendRedirect("index.jsp");
            } else {
                request.getSession().setAttribute("msg", "Registrasi Gagal.");
                response.sendRedirect("register.jsp");
            }

        } else if ("login".equalsIgnoreCase(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (akun.login(username, password)) {
                request.getSession().setAttribute("msg", "Login sukses!");
                response.sendRedirect("beranda.jsp");
            } else {
                response.sendRedirect("index.jsp?error=true");
            }
        }
    }
}
