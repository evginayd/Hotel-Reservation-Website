<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cancel Reservation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #1ABC9C;
            text-align: center;
            margin-top: 0;
        }
        .confirmation-msg {
            text-align: center;
            font-size: 18px;
        }
        .back-to-home {
            display: block;
            width: 100px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            background-color: #1ABC9C;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-to-home:hover {
            background-color: #16A085;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Reservation Canceled</h2>
        <div class="confirmation-msg">
            <% 
                int reservationId = Integer.parseInt(request.getParameter("reservationId"));

                // Database connection parameters
                String dbUrl = "jdbc:mysql://localhost:3306/Website_users";
                String dbUser = "root";
                String dbPassword = "Ilovethissite123*";

                Connection conn = null;
                PreparedStatement stmt = null;

                try {
                    // Establish database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                    // SQL query to delete the reservation
                    String deleteQuery = "DELETE FROM Bookings WHERE id = ?";
                    stmt = conn.prepareStatement(deleteQuery);
                    stmt.setInt(1, reservationId);
                    int rowsAffected = stmt.executeUpdate();

                    if (rowsAffected > 0) {
                        // Reservation successfully canceled
                        out.println("Your reservation has been canceled successfully.");
                    } else {
                        // No reservation found with the provided ID
                        out.println("No reservation found with the provided ID.");
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    // Handle any errors
                    e.printStackTrace();
                } finally {
                    // Close JDBC objects
                    if (stmt != null) {
                        try {
                            stmt.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (conn != null) {
                        try {
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </div>
    </div>

    <!-- JavaScript for redirection after 5 seconds -->
    <script>
        setTimeout(function() {
            window.location.href = "cancelreservation.jsp";
        }, 5000); // 5000 milliseconds = 5 seconds
    </script>
</body>
</html>
