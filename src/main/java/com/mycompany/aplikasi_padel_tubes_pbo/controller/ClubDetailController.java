package com.mycompany.aplikasi_padel_tubes_pbo.controller;

import com.mycompany.aplikasi_padel_tubes_pbo.model.Koneksi;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "ClubDetailController", urlPatterns = {"/ClubDetailController"})
public class ClubDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("user_id") == null) {
            response.sendRedirect("view/Login.html");
            return;
        }

        String clubIdStr = request.getParameter("id");
        int clubId = Integer.parseInt(clubIdStr);
        Map<String, Object> clubData = new HashMap<>();
        List<String> memberList = new ArrayList<>();

        try (Connection conn = Koneksi.getConnection()) {
            // Ambil data Klub
            String sqlClub = "SELECT * FROM club WHERE club_id = ?";
            PreparedStatement psClub = conn.prepareStatement(sqlClub);
            psClub.setInt(1, clubId);
            ResultSet rsClub = psClub.executeQuery();
            if (rsClub.next()) {
                clubData.put("club_id", rsClub.getInt("club_id"));
                clubData.put("name", rsClub.getString("name"));
                clubData.put("description", rsClub.getString("description"));
                clubData.put("status", rsClub.getString("status"));
                clubData.put("creator", "ADMIN"); 
            }

            // Ambil data Anggota (DENGAN DETEKTIF)
            // Coba kueri ini (Jika tabel user kamu pakai nama 'user' dan kolom 'username')
String sqlMember = "SELECT u.username FROM user u JOIN club_member cm ON u.user_id = cm.user_id WHERE cm.club_id = ?";
            PreparedStatement psMember = conn.prepareStatement(sqlMember);
            psMember.setInt(1, clubId);
            ResultSet rsMember = psMember.executeQuery();

            boolean found = false;
            while (rsMember.next()) {
                memberList.add(rsMember.getString("username"));
                found = true;
            }
            
            if (!found) {
                System.out.println("DEBUG: Tidak ada anggota ditemukan untuk club_id: " + clubId);
                System.out.println("DEBUG: Coba cek manual di DB: SELECT * FROM club_member WHERE club_id = " + clubId);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        clubData.put("next_match", "SABTU, 13 JUNI - 19.00 WIB");
        clubData.put("contact", "0812-3456-7890");
        clubData.put("quota", memberList.size() + " / 20 PLAYS");

        request.setAttribute("clubData", clubData);
        request.setAttribute("members", memberList);
        request.getRequestDispatcher("view/club_detail.jsp").forward(request, response);
    }
}