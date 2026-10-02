<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>NGO Nexus</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap" rel="stylesheet">
</head>
<body>

    <div class="main">  
        <input type="checkbox" id="chk" aria-hidden="true">

        <!-- Sign Up Form -->
        <div class="signup">
            <form action="index.jsp" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="signup">
                <label for="chk" aria-hidden="true">Sign up</label>
                <input type="text" name="username" placeholder="Username" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="tel" name="mobile" placeholder="Mobile Number" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit" class="button">Sign up</button>
            </form>
        </div>

        <!-- Login Form -->
        <div class="login">
            <form action="index.jsp" method="post" onsubmit="return validateLoginForm()">
                <input type="hidden" name="action" value="login">
                <label for="chk" aria-hidden="true">Login</label>
                <input type="email" name="email" placeholder="Email" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit" class="button">Login</button>
            </form>
        </div>
    </div>

    <script>
        function validateForm() {
            var username = document.querySelector('input[name="username"]').value;
            var email = document.querySelector('input[name="email"]').value;
            var mobile = document.querySelector('input[name="mobile"]').value;
            var password = document.querySelector('input[name="password"]').value;

            // Validate Username
            if (username.length > 20 || !/^[a-zA-Z0-9]+$/.test(username)) {
                alert("Invalid username. It should be alphanumeric and maximum 20 characters.");
                return false;
            }

            // Validate Email
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Invalid email format.");
                return false;
            }

            // Validate Mobile Number
            if (!/^\d{10}$/.test(mobile)) {
                alert("Invalid mobile number. It should be exactly 10 digits.");
                return false;
            }

            // Validate Password
            var passwordPattern = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if (!passwordPattern.test(password)) {
                alert("Password must have at least 8 characters, including uppercase, numbers, or special characters.");
                return false;
            }

            return true;
        }

        function validateLoginForm() {
            var email = document.querySelector('.login input[name="email"]').value;
            var password = document.querySelector('.login input[name="password"]').value;

            // Validate Email
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Invalid email format.");
                return false;
            }

            // Validate Password
            if (password.length < 8) {
                alert("Password must be at least 8 characters long.");
                return false;
            }

            return true;
        }
    </script>

    <!-- JSP Scriptlet for Database Connectivity -->
    <%
        String action = request.getParameter("action");

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/pbl";
        String dbUser = "root";
        String dbPassword = "password";

        Connection connection = null;
        PreparedStatement statement = null;

        if ("signup".equals(action)) {
            try {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection
                connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Retrieve signup form data
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String mobileNumber = request.getParameter("mobile");
                String password = request.getParameter("password");

                // Create SQL Insert Statement
                String sql = "INSERT INTO users (username, email, mobile, password) VALUES (?, ?, ?, ?)";
                statement = connection.prepareStatement(sql);
                statement.setString(1, username);
                statement.setString(2, email);
                statement.setString(3, mobileNumber);
                statement.setString(4, password);

                // Execute the insert statement
                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<script>alert('Registration Successful! Please login.'); window.location.href = 'index.jsp';</script>");
                } else {
                    out.println("<script>alert('Registration failed. Please try again.'); window.location.href = 'index.jsp';</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            } finally {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }
        } else if ("login".equals(action)) {
            try {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection
                connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Retrieve login form data
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                // Create SQL Query to validate login
                String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, email);
                statement.setString(2, password);

                ResultSet resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    response.sendRedirect("proindex.jsp");
                } else {
                    out.println("<script>alert('Invalid email or password.'); window.location.href = 'index.jsp';</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            } finally {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }
        }
    %>

</body>
</html>