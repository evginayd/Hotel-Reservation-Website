<%
	if(session.getAttribute("name") == null)
	{
		response.sendRedirect("login.jsp");
	}

%>
     
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make Reservation</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    background-image: url('background_image.jpg'); /* Add your background image URL here */
	    background-size: cover;
	    background-position: center;
	}

        .home-logo {
	    position: absolute;
	    top: 20px;
	    left: 20px;
	    width: 50px;
	    height: 50px;
	    z-index: 1; /* Ensure the logo is above the background */
	}
	
        /* Styling for the image */
        .masthead-container {
            position: relative;
            width: 100%;
            height: 100vh; /* Adjust height to cover the full viewport */
            overflow: hidden;
            border-radius: 10px;
        }

        .masthead-image {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Ensure the image covers the container */
            border-radius: 10px;
        }

        /* Styling for the reservation form */
        .reservation-form {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(255, 255, 255, 0.8); /* Adjust the opacity as needed */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        .reservation-form h2 {
            margin-top: 0;
        }

        .reservation-form form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .reservation-form label {
            font-weight: bold;
        }

        .reservation-form input[type="text"],
        .reservation-form input[type="email"],
        .reservation-form input[type="number"],
        .reservation-form input[type="date"],
        .reservation-form select {
            width: calc(50% - 10px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .reservation-form button {
            width: 100%;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .reservation-form button:hover {
            background-color: #0056b3;
        }
   
    </style>
</head>
<body>

    <!-- Image Section with Reservation Form -->
    <%
    String fullName = (String) session.getAttribute("name");
    String firstName = "";
    String lastName = "";

    // Check if fullName is not null and contains a space
    if (fullName != null && fullName.contains(" ")) {
        // Split the full name into first name and last name
        String[] parts = fullName.split(" ");
        firstName = parts[0]; // First part is the first name
        lastName = parts[1]; // Second part is the last name
    } else {
        // If fullName is null or doesn't contain a space, set default values
        firstName = "";
        lastName = "";
    }
%>
<%
    String roomId = request.getParameter("roomId");
    session.setAttribute("roomId", roomId);
%>
<a href="index.jsp">
    <img src="images/home_logo.png" alt="Home" width="50" height="50">
</a>
    <div class="masthead-container">
        <img class="masthead-image" src="images/hotelpic2.jpg" alt="Hotel Picture">
        <div class="reservation-form">
            <h2>Make Reservation</h2>
            
            <form action="payment.jsp" method="post">
		    <input type="text" id="firstName" name="firstName" placeholder="First Name" value="<%= firstName %>" required>
		    <input type="text" id="lastName" name="lastName" placeholder="Last Name" value="<%= lastName %>" required>
		    <input type="email" id="email" name="email" placeholder="Email" value="<%= session.getAttribute("usermail") %>" required>
		    <input type="number" id="roomNumber" name="roomNumber" placeholder="Room Number" min="1" max="40" value="<%= session.getAttribute("roomId") %>" required>
		    <input type="date" id="checkinDate" name="checkinDate" placeholder="Check-in Date" min="<%= java.time.LocalDate.now() %>" required>
		    <input type="date" id="checkoutDate" name="checkoutDate" placeholder="Check-out Date" min="<%= java.time.LocalDate.now() %>" max="<%= java.time.LocalDate.now().plusDays(20) %>" required>
		    <button type="submit">Submit</button>
		    <!-- Hidden fields to store reservation data -->
		    <input type="hidden" name="firstName" value="<%= firstName %>">
		    <input type="hidden" name="lastName" value="<%= lastName %>">
		    <input type="hidden" name="email" value="<%= session.getAttribute("usermail") %>">
		    <input type="hidden" name="roomNumber" value="<%= session.getAttribute("roomId") %>">
		    <input type="hidden" name="checkinDate" value="<%= java.time.LocalDate.now() %>">
		    <input type="hidden" name="checkoutDate" value="<%= java.time.LocalDate.now().plusDays(20) %>">
			</form>

        </div>
    </div>
</body>
</html>
