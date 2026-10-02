<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO NEXUS</title>
    <link rel="stylesheet" href="css/forngo1.css">
</head>
<body>
    <div class="container">
        <form class="event-details" action="forngo1.jsp" method="post">
            <div class="form-group">
                <label for="event-name">Event Name:</label>
                <input type="text" id="event-name" name="event-name" placeholder="Enter event name" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" placeholder="Enter event description" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="date">Date:</label>
                <input type="date" id="date" name="date" required>
            </div>
            
            <div class="form-group">
                <label for="location">Location:</label>
                <input type="text" id="location" name="location" placeholder="Enter location" required>
            </div>
            
            <div class="form-group">
                <label for="representative-id">Representative ID:</label>
                <input type="text" id="representative-id" name="representative-id" placeholder="Enter Representative ID" required>
            </div>

            <!-- Hidden input to determine action -->
            <input type="hidden" id="action" name="action" value="">

            <button type="submit" class="update-btn" onclick="document.getElementById('action').value='update'">Update Event</button>
            <button type="submit" class="delete-btn" onclick="document.getElementById('action').value='delete'">Delete Event</button>
        </form>

        <div class="back-button">
            <a href="proindex.jsp">&#x21A9; Back</a>
        </div>
    </div>

    <%
        // Check if the request method is POST
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Database connection details
            String jdbcURL = "jdbc:mysql://localhost:3306/pbl";
            String dbUser = "root";
            String dbPassword = "password";

            Connection connection = null;
            PreparedStatement statement = null;

            try {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection
                connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Retrieve event form data
                String eventName = request.getParameter("event-name");
                String description = request.getParameter("description");
                String eventDate = request.getParameter("date");
                String location = request.getParameter("location");
                String representativeId = request.getParameter("representative-id");
                String action = request.getParameter("action");

                // Check if Representative ID exists
                String checkRepSql = "SELECT * FROM representative WHERE representative_id = ?";
                PreparedStatement checkRepStmt = connection.prepareStatement(checkRepSql);
                checkRepStmt.setString(1, representativeId);
                ResultSet repResult = checkRepStmt.executeQuery();

                if (repResult.next()) {
                    // Representative exists, proceed with event operation
                    if ("update".equalsIgnoreCase(action)) {
                        // Create SQL Insert/Update Statement
                        String sql = "INSERT INTO events (event_name, description, event_date, location, representative_id, action) VALUES (?, ?, ?, ?, ?, ?)";
                        statement = connection.prepareStatement(sql);
                        statement.setString(1, eventName);
                        statement.setString(2, description);
                        statement.setString(3, eventDate);
                        statement.setString(4, location);
                        statement.setString(5, representativeId);
                        statement.setString(6, action);

                        // Execute the insert/update statement
                        int rowsAffected = statement.executeUpdate();
                        if (rowsAffected > 0) {
                            out.println("<script>alert('Event Updated Successfully!'); window.location.href = 'proindex.jsp';</script>");
                        } else {
                            out.println("<script>alert('Failed to Update Event.'); window.location.href = 'forngo1.jsp';</script>");
                        }
                    } else if ("delete".equalsIgnoreCase(action)) {
                        // Delete event logic
                        String deleteSql = "DELETE FROM events WHERE event_name = ? AND representative_id = ?";
                        statement = connection.prepareStatement(deleteSql);
                        statement.setString(1, eventName);
                        statement.setString(2, representativeId);

                        int rowsDeleted = statement.executeUpdate();
                        if (rowsDeleted > 0) {
                            out.println("<script>alert('Event Deleted Successfully!'); window.location.href = 'proindex.jsp';</script>");
                        } else {
                            out.println("<script>alert('Failed to Delete Event.'); window.location.href = 'forngo1.jsp';</script>");
                        }
                    }
                } else {
                    // Representative ID not found
                    out.println("<script>alert('Invalid Representative ID. Please try again.'); window.location.href = 'forngo1.jsp';</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
            } finally {
                // Clean up and close resources
                try {
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
