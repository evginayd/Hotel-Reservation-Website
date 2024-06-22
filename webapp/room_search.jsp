<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Room Search</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Add your CSS styles here -->
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

        .room-box {
            width: 270px; /* Increase the width of the box */
            height: 500px; /* Increase the height of the box */
            border: 2px solid #ccc;
            margin: 10px;
            display: inline-block;
            text-align: center;
            line-height: 20px; /* Adjust line height to center text vertically */
            font-size: 16px; /* Adjust font size */
            font-weight: bold;
            border-radius: 5px;
            padding: 20px; /* Increase padding around the text */
        }

        .reserved {
            background-color: red;
            color: white;
        }

        .available {
            background-color: green;
            color: white;
        }

        .make-reservation button {
            padding: 5px 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .make-reservation button:hover {
            background-color: #0056b3;
        }

        /* Additional CSS styles for the search form */
        form {
            margin-bottom: 20px;
            display: flex;
            flex-wrap: wrap;
        }

        label {
            width: 120px;
            flex-shrink: 0;
            margin-right: 10px;
            font-weight: bold;
            color: #333;
            text-align: right;
            line-height: 32px;
        }

        input[type="date"],
        input[type="number"],
        button[type="submit"] {
            flex: 1;
            padding: 0px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="date"],
        input[type="number"] {
            height: 32px;
        }

        button[type="submit"] {
            margin-left: 130px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<a href="index.jsp">
    <img src="images/home_logo.png" alt="Home" width="50" height="50">
</a>
    <div class="container">
        <h2>Room Search</h2>
        
       <form action="search_results.jsp" method="GET">
    <label for="checkInDate">Check-in Date:</label>
    <input type="date" id="checkInDate" name="checkInDate" min="<%= java.time.LocalDate.now() %>" max="<%= java.time.LocalDate.now().plusDays(20) %>">

    <label for="checkOutDate">Check-out Date:</label>
    <input type="date" id="checkOutDate" name="checkOutDate" min="<%= java.time.LocalDate.now().plusDays(1) %>" max="<%= java.time.LocalDate.now().plusDays(21) %>">

    <label for="guests">Guests:</label>
    <input type="number" id="guests" name="guests" min="1" max="5" value="1">

    <label for="rooms">Rooms:</label>
    <input type="number" id="rooms" name="rooms" min="1" max="3" value="1">

    <button type="submit">Search</button>
</form>

<script>

    // Function to validate check-out date based on check-in date
    document.getElementById('checkInDate').addEventListener('change', function() {
        var checkOutInput = document.getElementById('checkOutDate');
        checkOutInput.min = this.value; // Set minimum date for check-out date
        checkOutInput.value = ""; // Reset check-out date
    });
</script>


<%@ page import="java.sql.*" %>
<% 

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Website_users", "id", "password");

    // Fetch room information from the database based on selected category
    String category = request.getParameter("category");
    String query = "SELECT * FROM Rooms";
    if (category != null && !category.isEmpty()) {
        query += " WHERE category = ?";
    }
    stmt = conn.prepareStatement(query);
    if (category != null && !category.isEmpty()) {
        stmt.setString(1, category);
    }
    
    rs = stmt.executeQuery();
    
    // Display room information
    while (rs.next()) {
        int roomId = rs.getInt("id");
        double capacity_m2 = rs.getDouble("capacity_m2");
        int bed_count = rs.getInt("bed_count");
        boolean sea_view = rs.getBoolean("sea_view");
        double price = rs.getDouble("price");
        String room_type = rs.getNString("room_type");
        String special_features = rs.getNString("special_features");
        
        // Check if room is reserved
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM Bookings WHERE room_id = ?");
		ps.setInt(1, roomId);
		ResultSet rs2 = ps.executeQuery();
		while (rs2.next()) {
		    LocalDate checkOutDate = rs2.getDate("check_out_date").toLocalDate();
		    if (checkOutDate.isBefore(LocalDate.now())) {
		        // If check-out date has passed, delete the booking
		        PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM Bookings WHERE id = ?");
		        deleteStmt.setInt(1, rs2.getInt("id"));
		        deleteStmt.executeUpdate();
		    }
		}
        // Check if room is still reserved after deletion
        ps = conn.prepareStatement("SELECT COUNT(*) FROM Bookings WHERE room_id = ?");
        ps.setInt(1, roomId);
        ResultSet rs3 = ps.executeQuery();
        rs3.next();
        boolean isReserved = rs3.getInt(1) > 0;
%>
        <div class="room-box <%= isReserved ? "reserved" : "available" %>">
            <h3>Room <%= roomId %></h3>
            <%-- Store roomId in session --%>
            <% session.setAttribute("roomId", roomId); %>
            <img src="images/hotelpic_room1.png" alt="Room Image" style="max-width: 100%; height: auto;">
            
            <p style="margin-top: 20px;">Room Type: <%= room_type %></p>
            <p>Capacity (m2): <%= capacity_m2 %></p>
            <p>Bed Count: <%= bed_count %></p>
            <p>Sea View: <%= sea_view ? "Yes" : "No" %></p>
            <p>Special Features: <%= special_features %></p>
            <p>Price: $<%= price %></p>
            
            <div class="make-reservation">
                <% if (!isReserved) { %>
                <!-- Link to make reservation for available rooms -->
                <a href="makereservation.jsp?roomId=<%= roomId %>">Make Reservation</a>
                <% } else { %>
                <!-- Display modal for reserved rooms -->
                <button onclick="showReservationModal(<%= roomId %>)">Room Reserved</button>
                <div id="reservationModal_<%= roomId %>" class="modal" style="display: none;">
                    <div class="modal-content">
                        <span class="close" onclick="closeReservationModal(<%= roomId %>)">&times;</span>
                        <p>This room has been reserved.</p>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
<%
    }
} catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
    out.println("Error: " + e.getMessage());
} finally {
    try {
        if (rs != null) {
            rs.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (SQLException e) {
    }
}
%>

<style>
    /* Modal styles */
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.5);
    }

    /* Add this CSS to change text color to black */
    .modal-content p {
        color: black;
    }
    
    
    .modal-content {
        background-color: white;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 600px;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
</style>

<script>
    function showReservationModal(roomId) {
        var modal = document.getElementById("reservationModal_" + roomId);
        modal.style.display = "block";
    }
    
    function closeReservationModal(roomId) {
        var modal = document.getElementById("reservationModal_" + roomId);
        modal.style.display = "none";
    }
</script>
</div>
</body>
</html>





