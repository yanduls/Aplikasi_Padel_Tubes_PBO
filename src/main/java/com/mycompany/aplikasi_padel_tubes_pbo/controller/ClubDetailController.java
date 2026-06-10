package com.mycompany.aplikasi_padel_tubes_pbo.controller;

import com.mycompany.aplikasi_padel_tubes_pbo.model.Koneksi;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
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
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String clubIdStr = request.getParameter("id");
        int clubId = Integer.parseInt(clubIdStr);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try (Connection conn = Koneksi.getConnection()) {
            String sqlClub = "SELECT c.*, u.username AS creator_name " +
                             "FROM club c LEFT JOIN users u ON c.created_by = u.user_id " +
                             "WHERE c.club_id = ?";
            PreparedStatement psClub = conn.prepareStatement(sqlClub);
            psClub.setInt(1, clubId);
            ResultSet rsClub = psClub.executeQuery();

            if (!rsClub.next()) {
                out.print("{\"error\":true}");
                return;
            }

            String name    = rsClub.getString("name").replace("\"", "\\\"");
            String desc    = rsClub.getString("description").replace("\"", "\\\"");
            String creator = rsClub.getString("creator_name");
            if (creator == null) creator = "Unknown";

            String sqlMember = "SELECT u.username FROM users u " +
                               "JOIN club_member cm ON u.user_id = cm.user_id " +
                               "WHERE cm.club_id = ?";
            PreparedStatement psMember = conn.prepareStatement(sqlMember);
            psMember.setInt(1, clubId);
            ResultSet rsMember = psMember.executeQuery();

            StringBuilder members = new StringBuilder("[");
            boolean first = true;
            while (rsMember.next()) {
                if (!first) members.append(",");
                members.append("\"")
                       .append(rsMember.getString("username").replace("\"", "\\\""))
                       .append("\"");
                first = false;
            }
            members.append("]");

            out.print("{" +
                "\"name\":\""    + name    + "\"," +
                "\"desc\":\""    + desc    + "\"," +
                "\"creator\":\"" + creator + "\"," +
                "\"members\":"   + members +
            "}");

        } catch (SQLException e) {
    e.printStackTrace();
    out.print("{\"error\":true, \"msg\":\"" + e.getMessage() + "\"}");
}
    }
}
