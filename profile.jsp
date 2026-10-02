<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO Nexus</title>
    <link rel="stylesheet" href="css/profilestyle.css">
</head>
<body>
    <%
        Connection conn = null;
        String dbURL = "jdbc:mysql://localhost:3306/pbl"; 
        String dbUser = "root"; 
        String dbPass = "password"; 

        String inputPassword = request.getParameter("password");
        String updateStatus = ""; 

        if (inputPassword == null || inputPassword.isEmpty()) {
            out.println("<script>alert('Password is required.'); window.location='index.jsp';</script>");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            PreparedStatement stmt = conn.prepareStatement("SELECT username, email, mobile FROM users WHERE password = ?");
            stmt.setString(1, inputPassword);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String username = rs.getString("username");
                String email = rs.getString("email");
                String mobile = rs.getString("mobile");

                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String newUsername = request.getParameter("username");
                    String newEmail = request.getParameter("email");
                    String newMobile = request.getParameter("mobile");

                    PreparedStatement updateStmt = conn.prepareStatement("UPDATE users SET username = ?, email = ?, mobile = ? WHERE password = ?");
                    updateStmt.setString(1, newUsername);
                    updateStmt.setString(2, newEmail);
                    updateStmt.setString(3, newMobile);
                    updateStmt.setString(4, inputPassword);
                    int rowsAffected = updateStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        updateStatus = "Profile updated successfully.";
                        response.sendRedirect("proindex.jsp");
                        return;
                    } else {
                        updateStatus = "Profile update failed. Please try again.";
                    }
                }

                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("mobile", mobile);
            } else {
                out.println("<script>alert('Invalid password. Please try again.'); window.location='index.jsp';</script>");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
    <div class="background">
        <div class="form-container">
            <form action="profile.jsp" method="post">
                <div class="input-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" placeholder="Enter Username" required>
                </div>
                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" placeholder="Enter Email" required>
                </div>
                <div class="input-group">
                    <label for="mobile">Mobile Number</label>
                    <input type="tel" id="mobile" name="mobile" value="<%= request.getAttribute("mobile") != null ? request.getAttribute("mobile") : "" %>" placeholder="Enter Mobile Number" required>
                </div>
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" value="<%= inputPassword %>" placeholder="Enter Password" readonly>
                </div>
                <button type="submit" class="cylindrical-button">Save</button>
            </form>
            <a href="proindex.jsp" class="cylindrical-button back-link">Back</a>
            <div class="status-message"><%= updateStatus %></div>
        </div>
    </div>
</body>
</html>
