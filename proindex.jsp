<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NGO Nexus</title>
<link rel="stylesheet" href="css/styleproj.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<nav class="navbar">
<ul class="nav-list">
<li class="nav-item item2-gap"><a href="proindex.jsp" class="nav-link">NGO NEXUS</a></li>
<li class="nav-item"><a href="registerNGO.jsp" class="nav-link">Register NGO</a></li>
<li class="nav-item"><a href="#" class="nav-link" onclick="promptPassword()">Profile</a></li> <!-- Profile link with password prompt -->
<li class="nav-item"><a href="#" class="nav-link" onclick="scrollToFooter()">Get in Touch</a></li> <!-- Updated to call scroll function -->
</ul>
</nav>

<!-- Password Prompt Form (hidden initially) -->
<form action="proindex.jsp" method="post" id="passwordForm" style="display: none;">
<input type="password" name="password" id="passwordInput" placeholder="Enter your password" required>
<button type="submit">Submit</button>
</form>

<div class="text-container">
<p class="text-line">Fostering</p>
<p class="text-line">Communication</p>
<div class="button-group">
<a href="events.jsp" class="but">Book Event</a>
<a href="forngo1.jsp" class="but">Register Event</a>
</div>
</div>

<!-- Announcements Box for Latest Events -->
<div class="events-box">
<h2>Latest Events</h2>
<ul class="event-list">
<li><a href="events.jsp">Event Title 1</a></li>
<li><a href="events.jsp">Event Title 2</a></li>
<li><a href="events.jsp">Event Title 3</a></li>
</ul>
</div>

<footer class="partners-footer">
    <div class="partner">
        <p>Misha Parekh</p>
        <div class="social-icons">
            <a href="#"><i class="fa-brands fa-linkedin"></i></a>
            <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
            <a href="#"><i class="fa-brands fa-instagram"></i></a>
        </div>
        <p><i class="fa-solid fa-envelope"></i> partner1@example.com</p>
    </div>
    
    <div class="partner">
        <p>Ronak Parmar</p>
        <div class="social-icons">
            <a href="#"><i class="fa-brands fa-linkedin"></i></a>
            <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
            <a href="#"><i class="fa-brands fa-instagram"></i></a>
        </div>
        <p><i class="fa-solid fa-envelope"></i> partner2@example.com</p>
    </div>
    
    <div class="partner">
        <p>Atharva Puranik</p>
        <div class="social-icons">
            <a href="#"><i class="fa-brands fa-linkedin"></i></a>
            <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
            <a href="https://www.instagram.com/atharva_puranik_/"><i class="fa-brands fa-instagram"></i></a>
        </div>
        <p><i class="fa-solid fa-envelope"></i> partner3@example.com</p>
    </div>
    
    <div class="partner">
        <p>Adnan Rampurawala</p>
        <div class="social-icons">
            <a href="#"><i class="fa-brands fa-linkedin"></i></a>
            <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
            <a href="#"><i class="fa-brands fa-instagram"></i></a>
        </div>
        <p><i class="fa-solid fa-envelope"></i> partner4@example.com</p>
    </div>
</footer>

<script>
// Prompt the user for a password
function promptPassword() {
const password = prompt("Please enter your password:");
if (password) {
// Set the password into the hidden form and submit it
document.getElementById("passwordInput").value = password;
document.getElementById("passwordForm").submit();
}
}

// Scroll to the footer
function scrollToFooter() {
    const footer = document.querySelector('.partners-footer');
    footer.scrollIntoView({ behavior: 'smooth' });
}
</script>

<%
// Validate the password against the database
String dbURL = "jdbc:mysql://localhost:3306/pbl"; // Change to your database URL
String dbUser = "root"; // Change to your DB username
String dbPass = "password"; // Change to your DB password

String inputPassword = request.getParameter("password");

if (inputPassword != null && !inputPassword.isEmpty()) {
Connection conn = null;
try {
Class.forName("com.mysql.cj.jdbc.Driver"); // Load the JDBC driver
conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

// Prepare and execute the SQL query to check the password
PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE password = ?");
stmt.setString(1, inputPassword);
ResultSet rs = stmt.executeQuery();

if (rs.next() && rs.getInt(1) > 0) {
// Password is valid; redirect to profile.jsp with password
response.sendRedirect("profile.jsp?password=" + inputPassword);
} else {
// Invalid password; show an error message
out.println("<script>alert('Invalid password. Please try again.');</script>");
}
} catch (Exception e) {
e.printStackTrace();
} finally {
if (conn != null) {
try {
conn.close(); // Close the connection
} catch (SQLException e) {
e.printStackTrace();
}
}
}
}
%>
</body>
</html>
