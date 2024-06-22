<%
	if(session.getAttribute("name") == null)
	{
		response.sendRedirect("login.jsp");
	}

%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Reservations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            margin-top: 0;
        }

        .reservation {
            margin-bottom: 20px;
            padding: 20px;
            background-color: #f2f2f2;
            border-radius: 5px;
        }

        .room-details {
            margin-top: 10px;
        }

        .cancel-button {
            padding: 5px 10px;
            background-color: #dc3545;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .cancel-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<%
    // Check if the user is logged in (session attribute "name" is not null)
    String mailAddress = (String) session.getAttribute("usermail");
    boolean isLoggedIn = mailAddress != null && !mailAddress.isEmpty();
%>
<body>
    <a href="index.jsp">
        <img src="images/home_logo.png" alt="Home" width="50" height="50">
    </a>
    <div class="container">
        <h2>My Reservations</h2>
        <%  
            if (mailAddress != null) {
                try {
                    // Establish database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Website_users", "id", "password");
                    
                    // Query to fetch user's reservations based on email
                    String query = "SELECT * FROM Bookings WHERE email = ?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, mailAddress);
                    ResultSet rs = stmt.executeQuery();
                    
                    // Display user's reservations
                    while (rs.next()) {
                        int reservationId = rs.getInt("id");
                        int roomId = rs.getInt("room_id");
                        // Fetch room information based on roomId
                        PreparedStatement roomStmt = conn.prepareStatement("SELECT * FROM Rooms WHERE id = ?");
                        roomStmt.setInt(1, roomId);
                        ResultSet roomRs = roomStmt.executeQuery();

                        if (roomRs.next()) {
                            double capacity_m2 = roomRs.getDouble("capacity_m2");
                            int bed_count = roomRs.getInt("bed_count");
                            boolean sea_view = roomRs.getBoolean("sea_view");
                            double price = roomRs.getDouble("price");
                            String room_type = roomRs.getNString("room_type");
                            String special_features = roomRs.getNString("special_features");
                    %>
                            <div class="reservation">
                                <h3>Room <%= roomId %></h3>
                                <div class="room-details">
                                	<p>Room Type: <%= room_type %></p>
                                    <p>Capacity (m2): <%= capacity_m2 %></p>
                                    <p>Bed Count: <%= bed_count %></p>
                                    <p>Sea View: <%= sea_view ? "Yes" : "No" %></p>
                                    <p>Special Features: <%= special_features %></p>
                                    <p>Price: $<%= price %></p>
                                </div>
                                <div class="confirmation-container">
                                    <form id="cancelForm_<%= reservationId %>" action="cancel_reservation_logic.jsp" method="POST">
                                        <input type="hidden" name="reservationId" value="<%= reservationId %>">
                                        <button class="cancel-button" type="button" onclick="confirmCancel(<%= reservationId %>)">Cancel Reservation</button>
                                    </form>
                                    <div id="confirmationMsg_<%= reservationId %>" class="confirmation-msg" style="display: none;"></div>
                                </div>
                            </div>
                    <%
                        }
                    }
                    // Close all resources
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

    <!-- JavaScript for confirmation -->
    <script>
        function confirmCancel(reservationId) {
            if (confirm("Are you sure you want to cancel this reservation?")) {
                document.getElementById("confirmationMsg_" + reservationId).style.display = "block";
                document.getElementById("cancelForm_" + reservationId).submit();
            }
        }
    </script>
</body>


</html>
