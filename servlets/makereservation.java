package registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/makereservation")
public class makereservation extends HttpServlet {
	 private static final long serialVersionUID = 1L;

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Retrieve parameters from the request
	        String roomId = request.getParameter("roomId");
	        String customerName = request.getParameter("customerName");
	        String email = request.getParameter("email");
	        String checkInDate = request.getParameter("checkInDate");
	        String checkOutDate = request.getParameter("checkOutDate");

	        // Validate input fields
	        if (roomId == null || customerName == null || email == null || checkInDate == null || checkOutDate == null ||
	                roomId.isEmpty() || customerName.isEmpty() || email.isEmpty() || checkInDate.isEmpty() || checkOutDate.isEmpty()) {
	            response.getWriter().println("Please fill out all fields.");
	            return;
	        }

	        // Validate email format
	        if (!isValidEmail(email)) {
	            response.getWriter().println("Invalid email address.");
	            return;
	        }

	        // Database connection parameters
	        String url = "jdbc:mysql://localhost:3306/Website_users";
	        String username = "id";
	        String password = "password";

	        try (Connection conn = DriverManager.getConnection(url, username, password)) {
	            // Fetch userId based on email
	            int userId = -1; // Initialize userId to a default value
	            PreparedStatement userStmt = conn.prepareStatement("SELECT id FROM Users WHERE email = ?");
	            userStmt.setString(1, email);
	            ResultSet userRs = userStmt.executeQuery();
	            if (userRs.next()) {
	                userId = userRs.getInt("id"); // Get the user_id from the Users table
	            } else {
	                // Handle the case where userId is not found for the given email
	                response.getWriter().println("User with email " + email + " not found.");
	                return;
	            }

	            // Insert reservation into the Bookings table
	            String sql = "INSERT INTO Bookings (user_id, room_id, customer_name, email, check_in_date, check_out_date) VALUES (?, ?, ?, ?, ?, ?)";
	            PreparedStatement statement = conn.prepareStatement(sql);
	            statement.setInt(1, userId);
	            statement.setString(2, roomId);
	            statement.setString(3, customerName);
	            statement.setString(4, email);
	            statement.setString(5, checkInDate);
	            statement.setString(6, checkOutDate);

	            // Execute the insert statement
	            int rowsInserted = statement.executeUpdate();
	            if (rowsInserted > 0) {
	                // If the reservation was successfully inserted, redirect to payment.jsp
	                response.sendRedirect("payment.jsp?roomId=" + roomId + "&userId=" + userId);
	                return; // Add return statement to prevent further execution
	            } else {
	                // Handle error
	                response.getWriter().println("Failed to make reservation.");
	            }
	        } catch (SQLException e) {
	            // Handle SQL exception
	            e.printStackTrace();
	            response.getWriter().println("Database error: " + e.getMessage());
	        }
	    }

	    private boolean isValidEmail(String email) {
	        // Simple email validation using regex
	        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
	        Pattern pattern = Pattern.compile(emailRegex);
	        return pattern.matcher(email).matches();
	    }
	}
