<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
        }
        
        h1 {
            text-align: center;
            color: #333;
        }
        
        form {
            margin-top: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        label {
            margin-bottom: 10px;
            color: #555;
        }
        
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        
        input[type="text"]:focus {
            outline: none;
            border-color: #007bff;
        }
        
        button[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 18px;
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
    <div class="container">
        <h1>Payment</h1>
        <p>Please complete your payment to confirm your reservation.</p>
        
        <!-- Payment form -->
<form action="confirm_reservation.jsp" method="POST" onsubmit="return validateForm()">
    <label for="cardNumber">Card Number:</label>
	<input type="text" id="cardNumber" name="cardNumber" required maxlength="19" oninput="formatCardNumber(this)">

    <label for="expiryDate">Expiry Date:</label>
    <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
    
    <label for="cvv">CVV:</label>
    <input type="text" id="cvv" name="cvv" required>
    
    <!-- Hidden fields for room_id, user_id, etc. -->
    <input type="hidden" name="roomId" value="<%= request.getParameter("roomId") %>">
    <input type="hidden" name="userId" value="<%= request.getParameter("userId") %>">
    <!-- Add more hidden fields as needed -->
    <!-- Hidden fields to store reservation data -->
    <input type="hidden" name="firstName" value="<%= firstName %>">
    <input type="hidden" name="lastName" value="<%= lastName %>">
    <input type="hidden" name="email" value="<%= session.getAttribute("usermail") %>">
    <input type="hidden" name="roomNumber" value="<%= session.getAttribute("roomId") %>">
    <input type="hidden" name="checkinDate" value="<%= java.time.LocalDate.now() %>">
    <input type="hidden" name="checkoutDate" value="<%= java.time.LocalDate.now().plusDays(20) %>">
    
    <button type="submit">Pay Now</button>
</form>

<script>
	function formatCardNumber(input) {
	    // Remove any non-numeric characters
	    var cardNumber = input.value.replace(/\D/g, '');
	
	    // Check if the card number is longer than 4 characters
	    if (cardNumber.length > 4) {
	        // Insert a space every 4 characters
	        cardNumber = cardNumber.match(/.{1,4}/g).join(' ');
	    }
	
	    // Update the input value with the formatted card number
	    input.value = cardNumber;
	}


    // Function to add "/" after the user enters the month in MM format
    function formatExpiryDate() {
        var expiryDateInput = document.getElementById("expiryDate");
        var inputValue = expiryDateInput.value;
        if (inputValue.length === 2 && !inputValue.includes("/")) {
            expiryDateInput.value = inputValue + "/";
        }
    }
    
    // Event listener to call formatExpiryDate function when typing in expiryDate field
    document.getElementById("expiryDate").addEventListener("input", formatExpiryDate);
    
    function validateForm() {
        var cardNumberInput = document.getElementById("cardNumber");
        var expiryDateInput = document.getElementById("expiryDate");
        var cvvInput = document.getElementById("cvv");

        // Remove any non-numeric characters from card number
        var cardNumber = cardNumberInput.value.replace(/\D/g, '');

        var expiryDate = expiryDateInput.value;
        var cvv = cvvInput.value;

        // Check if card number is 16 digits
        if (cardNumber.length !== 16) {
            alert("Please enter a valid 16-digit card number.");
            cardNumberInput.style.borderColor = "red"; // Set border color to red
            return false;
        }

        // Check if expiry date is in MM/YY format
        if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(expiryDate)) {
            alert("Please enter expiry date in MM/YY format.");
            expiryDateInput.style.borderColor = "red"; // Set border color to red
            return false;
        }

        // Check if CVV is 3 digits
        if (!/^\d{3}$/.test(cvv)) {
            alert("Please enter a valid 3-digit CVV.");
            cvvInput.style.borderColor = "red"; // Set border color to red
            return false;
        }

        return true; // Form is valid, proceed with submission
    }

</script>
    </div>
</body>
</html>
