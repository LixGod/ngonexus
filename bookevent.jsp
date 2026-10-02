<%@ page import="java.sql.*, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO Nexus</title>
    <link rel="stylesheet" href="css/bookevent.css">
</head>
<body>
<%
    String name = request.getParameter("name");
    String mobileNumber = request.getParameter("mobileNumber");
    String age = request.getParameter("age");
    String gender = request.getParameter("gender");
    String event = request.getParameter("event");

    String errorMessage = "";

    if (request.getParameter("register") != null) {
        if (name == null || name.isEmpty() ||
            mobileNumber == null || mobileNumber.length() != 10 ||
            age == null || age.length() > 3 ||
            gender == null || gender.isEmpty()) {
            errorMessage = "Please fill all the fields correctly!";
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pbl", "root", "password");

                String query = "INSERT INTO event_bookings (name, mobile_number, age, gender, event) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, mobileNumber);
                ps.setInt(3, Integer.parseInt(age));
                ps.setString(4, gender);
                ps.setString(5, event);
                ps.executeUpdate();
                errorMessage = "Registration Successful!";
                ps.close();
                con.close();
            } catch (Exception e) {
                errorMessage = "Database Error: " + e.getMessage();
            }
        }
    }
%>

    <div class="container">
        <div class="left-section">
            <form class="event-details" method="post">
                <div class="form-group">
                    <label for="event">Choose the Event:</label>
                    <select name="event" required>
                        <option value="Event 1">Event 1</option>
                        <option value="Event 2">Event 2</option>
                        <option value="Event 3">Event 3</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                
                <div class="form-group">
                    <label for="mobileNumber">Mobile Number:</label>
                    <input type="text" id="mobileNumber" name="mobileNumber" pattern="\d{10}" maxlength="10" placeholder="Enter mobile number" required>
                </div>
                
                <div class="form-group">
                    <label for="age">Age:</label>
                    <input type="text" id="age" name="age" pattern="\d{1,3}" maxlength="3" placeholder="Enter your age" required>
                </div>

                <div class="form-group">
                    <label for="gender">Gender:</label>
                    <input type="text" id="gender" name="gender" required>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="update-btn" name="register">Register</button>
                    <input type="reset" class="reset">
                </div>
            </form>
            <div class="back-button">
                <a href="events.jsp">&#x21A9; Back</a>
            </div>
        </div>

        <% if (!errorMessage.isEmpty()) { %>
        <div style="color:red;">
            <%= errorMessage %>
        </div>
        <% } %>

    </div>
</body>
</html>
