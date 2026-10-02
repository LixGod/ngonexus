<%@ page import="java.sql.*, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO Nexus</title>
    <link rel="stylesheet" href="css/registerNGO.css">
</head>
<body>
<%
    String organisationID = request.getParameter("organisationID");
    String ngoName = request.getParameter("ngoName");
    String contactNumber = request.getParameter("contactNumber");
    String address = request.getParameter("address");

    // Initialize error message
    String errorMessage = "";

    // Check if form is submitted
    if (request.getParameter("register") != null) {
        if (organisationID == null || organisationID.isEmpty() ||
            ngoName == null || ngoName.isEmpty() ||
            contactNumber == null || contactNumber.length() != 10 ||
            address == null || address.isEmpty()) {
            errorMessage = "Please fill all the fields correctly!";
        } else {
            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pbl", "root", "password");

                // Insert the data into the database
                String query = "INSERT INTO ngo_registrations (organisation_id, ngo_name, contact_number, address) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, organisationID);
                ps.setString(2, ngoName);
                ps.setString(3, contactNumber);
                ps.setString(4, address);
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
        <form class="ngo-details" method="post">
            <div class="form-group">
                <label for="organisationID">Organisation ID:</label>
                <input type="text" id="organisationID" name="organisationID" placeholder="Enter Organisation ID" required>
            </div>

            <div class="form-group">
                <label for="ngoName">NGO Name:</label>
                <input type="text" id="ngoName" name="ngoName" placeholder="Enter NGO Name" required>
            </div>

            <div class="form-group">
                <label for="contactNumber">Contact Number:</label>
                <input type="text" id="contactNumber" name="contactNumber" pattern="\d{10}" maxlength="10" placeholder="Enter Contact Number" required>
            </div>

            <div class="form-group">
                <label for="address">Address:</label>
                <textarea id="address" name="address" placeholder="Enter NGO Address" required></textarea>
            </div>

            <div class="form-group">
                <button type="submit" class="reg-btn" name="register">Register</button>
                <input type="reset" class="reset" value="Reset">
            </div>
        </form>

        <div class="back-button">
            <a href="proindex.jsp">&#x21A9; Back</a>
        </div>

        <% if (!errorMessage.isEmpty()) { %>
        <div style="color:red;">
            <%= errorMessage %>
        </div>
        <% } %>
    </div>
</body>
</html>
