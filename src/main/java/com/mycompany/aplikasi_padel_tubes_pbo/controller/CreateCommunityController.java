/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.aplikasi_padel_tubes_pbo.controller;

import com.mycompany.aplikasi_padel_tubes_pbo.model.Club;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
/**
 *
 * @author ALFIAN
 */
public class CreateCommunityController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null && session.getAttribute("user_id") == null) {
            response.sendRedirect("view/Login.html");
            return;
    }
        request.getRequestDispatcher("view/create_community.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null && session.getAttribute("user_id") == null) {
            response.sendRedirect("view/Login.html");
            return;
        }

        Timestamp currenttime = new Timestamp(System.currentTimeMillis());
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        if (name != null && description != null && !name.trim().isEmpty() && !description.trim().isEmpty()) {
            Club newClub = new Club(name, description, status, currenttime);
        } else {
            response.sendRedirect("CreateCommunityController?status=empty");
        }
    
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
