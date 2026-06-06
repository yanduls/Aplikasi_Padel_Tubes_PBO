/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.aplikasi_padel_tubes_pbo.controller;

import com.mycompany.aplikasi_padel_tubes_pbo.model.Koneksi;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "JoinController", urlPatterns = {"/JoinController"})
public class JoinController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Cek apakah user sudah login (ambil dari Session)
        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("user_id");

        if (userObj == null) {
            response.sendRedirect("view/Login.html");
            return;
        }

        // 2. Tangkap ID Club yang dikirim dari tombol (parameter URL)
        String clubIdStr = request.getParameter("club_id");
        
        if (clubIdStr == null || clubIdStr.trim().isEmpty()) {
            response.sendRedirect("CommunityController?status=error");
            return;
        }

        // Ubah bentuk ID menjadi integer (angka)
        int userId = Integer.parseInt(userObj.toString());
        int clubId = Integer.parseInt(clubIdStr);

        try (Connection conn = Koneksi.getConnection()) {
            // 3. CEK DULU: Apakah user ini sudah pernah gabung di komunitas ini?
            // (Biar datanya nggak double di tabel club_member)
            String checkSql = "SELECT * FROM club_member WHERE club_id = ? AND user_id = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, clubId);
            checkPs.setInt(2, userId);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // Kalau datanya ketemu, berarti udah pernah join
                // Kembalikan ke halaman community dengan status peringatan
                response.sendRedirect("CommunityController?status=already_joined");
            } else {
                // 4. Kalau belum join, masukkan ke tabel club_member
                String insertSql = "INSERT INTO club_member (club_id, user_id) VALUES (?, ?)";
                PreparedStatement insertPs = conn.prepareStatement(insertSql);
                insertPs.setInt(1, clubId);
                insertPs.setInt(2, userId);
                
                insertPs.executeUpdate();

                // Berhasil join, kembali ke halaman community
                response.sendRedirect("CommunityController?status=joined_success");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("CommunityController?status=error_db");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kita pakai doGet karena pengirimannya lewat link <a>
    }
}

