package registration;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("name");
        String userpassword = request.getParameter("pass");
        String userrepeatedpassword = request.getParameter("re_pass");
        String usermail = request.getParameter("email");
        String usermobile = request.getParameter("contact");
        RequestDispatcher dispatcher = null;
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Website_users?useSSL=false", "id",
                    "password");

            // Check if email already exists
            boolean emailExists = checkEmailExists(con, usermail);

            if (username == null || username.equals("")) {
                request.setAttribute("status", "invalidName");
            } else if (userpassword == null || userpassword.equals("")) {
                request.setAttribute("status", "invalidPassword");
            } else if (!userpassword.equals(userrepeatedpassword)) {
                request.setAttribute("status", "invalidConfirmPassword");
            } else if (usermail == null || usermail.equals("")) {
                request.setAttribute("status", "invalidEmail");
            } else if (usermobile == null || usermobile.equals("")) {
                request.setAttribute("status", "invalidMobile");
            } else if (usermobile.length() > 11) {
                request.setAttribute("status", "invalidMobileLength");
            } else if (emailExists) {
                request.setAttribute("status", "duplicateEmail");
            } else {
                PreparedStatement pst = con
                        .prepareStatement("INSERT INTO Users(username, userpassword, usermail, usermobile) VALUES(?,?,?,?) ");
                pst.setString(1, username);
                pst.setString(2, userpassword);
                pst.setString(3, usermail);
                pst.setString(4, usermobile);

                int rowCount = pst.executeUpdate();
                dispatcher = request.getRequestDispatcher("registration.jsp");
                if (rowCount > 0) {
                    request.setAttribute("status", "success");

                } else {
                    request.setAttribute("status", "failed");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
        }
    }

    private boolean checkEmailExists(Connection con, String email) throws SQLException {
        PreparedStatement pst = con.prepareStatement("SELECT * FROM Users WHERE usermail = ?");
        pst.setString(1, email);
        ResultSet rs = pst.executeQuery();
        return rs.next(); // If rs.next() is true, email exists in the database
    }
}
