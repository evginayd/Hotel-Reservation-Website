<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up Form by Colorlib</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<a href="index.jsp">
    <img src="images/home_logo.png" alt="Home" width="50" height="50">
</a>
    <input type="hidden" id="status" value="<%= request.getAttribute("status") %>">

    <div class="main">
        <!-- Sign in Form -->
        <section class="sign-in">
            <div class="container">
                <div class="signin-content">
                    <div class="signin-image">
                        <figure>
                            <img src="images/hotelpic1.jpg" alt="sing up image">
                        </figure>
                        <a href="registration.jsp" class="signup-image-link">Create an account</a>
                    </div>

                    <div class="signin-form">
                        <h2 class="form-title">Sign in</h2>
                        <form method="post" action="login" class="register-form" id="login-form">
                            <div class="form-group">
                                <label for="username"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="text" name="username" id="username" placeholder="Your Name" required="required" />
                            </div>
                            <div class="form-group">
                                <label for="password"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="password" id="password" placeholder="Password" required="required" />
                            </div>
                            <div class="form-group">
                                <a href="forgotPassword.jsp">Forgot Password?</a>
                            </div>
                            <div class="form-group form-button">
                                <input type="submit" name="signin" id="signin" class="form-submit" value="Log in" />
                            </div>
                        </form>
                        <div class="social-login">
                            <span class="social-label">Or login with</span>
                            <ul class="socials">
                                <li><a href="#"><i class="display-flex-center zmdi zmdi-facebook"></i></a></li>
                                <li><a href="#"><i class="display-flex-center zmdi zmdi-twitter"></i></a></li>
                                <li><a href="#"><i class="display-flex-center zmdi zmdi-google"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
        </section>
    </div>

    <!-- JS -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="alert/dist/sweetalert.css">

    <script type="text/javascript">
        var status = document.getElementById("status").value;
        if (status == "failed") {
            swal("Error", "Wrong Username or Password", "error");
        } else if (status == "invalidEmail") {
            swal("Error", "Please enter username", "error");
        } else if (status == "invalidPassword") {
            swal("Error", "Please enter password", "error");
        } else if (status == "resetSuccess") {
            swal("Success", "Password successfully changed", "success");
        } else if (status == "resetFailed") {
            swal("Error", "Can not change the password", "error");
        }

        // Client-side validation to ensure both username and password are provided
        document.getElementById("login-form").addEventListener("submit", function (event) {
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;

            if (!username.trim() || !password.trim()) {
                event.preventDefault();
                swal("Error", "Please fill in both username and password", "error");
            }
            
        });
    </script>
</body>

<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>
