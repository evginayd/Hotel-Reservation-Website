<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cancel Result</title>
</head>
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

form {
    margin-top: 20px;
}

label {
    font-weight: bold;
}

input[type="number"],
input[type="text"] {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
}

button {
    padding: 10px 20px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #0056b3;
}

.room-box {
    width: 100px;
    height: 100px;
    border: 2px solid #ccc;
    margin: 10px;
    display: inline-block;
    text-align: center;
    line-height: 100px;
    font-size: 20px;
    font-weight: bold;
    border-radius: 5px;
}

.reserved {
    background-color: red;
    color: white;
}

.available {
    background-color: green;
    color: white;
}


</style>

<body>
    <div class="container">
        <h2>Cancel Result</h2>
        <% 
            // Kullanıcı tarafından post edilen form verilerini al
            String roomNumber = request.getParameter("roomNumber");
            
            // Veritabanı bağlantısı oluştur
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                // Veritabanına bağlan
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Website_users", "root", "Ilovethissite123*");
                
                // Rezervasyonu iptal et
                String sql = "DELETE FROM RoomBookings WHERE room_number = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, roomNumber);
                int rowsAffected = ps.executeUpdate();
                
                // İptal edilen rezervasyonun varsa kullanıcıya mesaj göster
                if (rowsAffected > 0) {
        %>
            <p>Reservation for room <%= roomNumber %> has been canceled.</p>
        <%
                } else {
        %>
            <p>There is no reservation for room <%= roomNumber %>.</p>
        <%
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            } finally {
                // Kapat
                try {
                    if (ps != null) {
                        ps.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
