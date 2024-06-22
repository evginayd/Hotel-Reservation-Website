
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Sunset Heaven Hotel</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/index-styles.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Full Window Image</title>
    <style>
        /* Resetting default margin and padding for all elements */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        /* Set the HTML and body to take up the full viewport */
        html, body {
            height: 100%;
        }
        
        /* Style to make the image cover the entire window */
        img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Ensures the image covers the entire area without stretching */
            position: fixed; /* Positioning the image fixed to the viewport */
            top: 0;
            left: 0;
            z-index: -1; /* Ensures the image is behind other content */
        }
        
        .masthead {
    margin-bottom: 300px; /* Adjust the value as needed */
}

#about {
    margin-top: 300px; /* Adjust the value as needed */
}
    </style>
</head>
<body id="page-top">
	<%
    // Check if the user is logged in (session attribute "name" is not null)
    String fullName = (String) session.getAttribute("name");
    boolean isLoggedIn = fullName != null && !fullName.isEmpty();
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand" href="#page-top">SUNSET HAVEN HOTEL</a>
        <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menu <i class="fas fa-bars"></i>
        </button>

        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#about">About</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#makereservation">Make a Reservation</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#faq">FAQ</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#contact">Contact</a></li>
                
                <% if (isLoggedIn) { %>
                <li class="nav-item mx-0 mx-lg-1">
                    <a class="nav-link py-3 px-0 px-lg-3 rounded text-danger" href="logout.jsp">
                        <% 
                            if (fullName != null && fullName.contains(" ")) {
                                String[] parts = fullName.split(" ");
                                String firstName = parts[0]; // First part is the first name
                                String lastName = parts[1]; // Second part is the last name
                                out.print("Logout, " + firstName + " " + lastName);
                            } else {
                                out.print("Logout");
                            }
                        %>
                    </a>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

	<!-- Masthead-->
	<header class="masthead bg-primary text-white text-center">
		<div class="container d-flex align-items-center flex-column">
			<!-- Masthead Avatar Image-->
			<img src="images/hotelpic1.jpg"
				alt="..." />
			<!-- Masthead Heading-->
			<h1 class="masthead-heading text-uppercase mb-0">Welcome To Hotel Reservation Webpage</h1>
			<!-- Icon Divider-->
			<div class="divider-custom divider-light">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>
			<!-- Masthead Subheading-->
			
		</div>
	</header>
	<!-- About Section-->
<section class="page-section bg-primary text-white mb-0" id="about">
    <div class="container">
        <!-- About Section Heading-->
        <h2 class="page-section-heading text-center text-uppercase">About Us</h2>
        <!-- Icon Divider-->
        <div class="divider-custom divider-light">
            <div class="divider-custom-line"></div>
            <div class="divider-custom-icon">
                <i class="fas fa-star"></i>
            </div>
            <div class="divider-custom-line"></div>
        </div>
        <!-- About Section Content-->
        <div class="row">
            <div class="col-lg-6 mx-auto">
                <p class="lead text-center">Welcome to our new hotel reservation webpage. We pride ourselves on providing exceptional service and luxurious accommodations for our guests.</p>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-lg-6 mx-auto">
                <p class="lead text-center">With 40 beautifully appointed rooms, we offer a comfortable and memorable stay for every traveler. Whether you're here for business or leisure, we have the perfect room for you.</p>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-lg-6 mx-auto">
                <p class="lead text-center">We offer a swimming pool and a spa for an amazing experience in our hotel. The comfort of our customers is our priority.</p>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-lg-6 mx-auto">
                <p class="lead text-center">If you encounter any technical issues or have questions about your reservation, our dedicated support team is here to assist you. Simply reach out to us through the contact section, and we'll promptly address your concerns.</p>
            </div>
        </div>
    </div>
</section>

	
	
	
	
<!-- Make a Reservation Section -->
<section class="page-section" id="makereservation">
    <div class="container">
        <!-- Make Reservation Section Heading -->
		<h2 class="page-section-heading text-center text-uppercase" style="color: #1ABC9C;">Make a Reservation</h2>
		        <!-- FAQ Content -->
        <div class="row">
            <div class="col-lg-12 text-center">
                <p> </p>
            </div>
        </div>
        
        <!-- Reservation Options -->
        <div class="row">
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h4 class="card-title text-center">Room Search</h4>
                        <p class="card-text text-center">Find the perfect room for your stay.</p>
                        <div class="text-center">
                            <a href="room_search.jsp" class="btn btn-primary">Search</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h4 class="card-title text-center">Make Reservation</h4>
                        <p class="card-text text-center">Book your room now.</p>
                        <div class="text-center">
                            <a href="makereservation.jsp" class="btn btn-primary">Reserve</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h4 class="card-title text-center">Cancel Reservation</h4>
                        <p class="card-text text-center">Change your plans? Cancel your reservation.</p>
                        <div class="text-center">
                            <a href="cancelreservation.jsp" class="btn btn-primary">Cancel</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->
        
    </div>
</section>
<!-- FAQ Section -->
<section class="page-section" id="faq">
    <div class="container">
        <!-- FAQ Section Heading -->
        <h2 class="page-section-heading text-center text-uppercase" style="color: #1ABC9C;">Frequently Asked Questions</h2>

        <!-- FAQ Content -->
        <div class="row">
            <div class="col-lg-12 text-center">
                <p style="color: #1ABC9C;">Here are some common questions and answers:</p>
            </div>
        </div>

        <!-- FAQ Items - Initially display all -->
        <div class="faq-items">
            <div class="row">
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h4 class="card-title text-center">How can I make my reservation?</h4>
                            <p class="card-text" style="color: grey;">You can make your reservation in the make reservation part at the below. You can select the unreserved room within you reservation dates.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h4 class="card-title text-center">What is included with my reservation?</h4>
                            <p class="card-text" style="color: grey;">Our rooms come equipped with standard amenities such as free Wi-Fi, complimentary breakfast, and access to our fitness center. Additional amenities may vary depending on the room type and package selected.</p>
                        </div>
                    </div>
                </div>
                <!-- Add more FAQ items here -->
            </div>
        </div>

        <!-- See All Button - Toggle visibility of other questions -->
        <div class="row">
            <div class="col-lg-12 text-center mt-4">
                <button class="btn btn-primary" id="see-all-btn">See All</button>
            </div>
        </div>

        <!-- Additional FAQ Items - Initially hidden -->
        <div class="additional-faq-items" style="display: none;">
            <div class="row">
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h4 class="card-title text-center">How can I change my room?</h4>
                            <p class="card-text" style="color: grey;">You should change your room by firstly canceling your reservation and then reserve you desired room by using our system.</p>
                        </div>
                    </div>
                </div>
                <!-- Add more FAQ items as needed -->
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h4 class="card-title text-center">What are the check-in and check-out times?</h4>
                            <p class="card-text" style="color: grey;">Check-in time is at 2pm, and check-out time is at 4pm. 
                            Early check-in and late check-out may be available upon request, subject to availability and additional charges.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h4 class="card-title text-center">Is parking available at the hotel?</h4>
                            <p class="card-text" style="color: grey;"> Yes, we offer onsite parking for guests. There may be a daily fee associated with parking, which varies depending on the location and availability.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h4 class="card-title text-center">Do you offer special rates for group bookings?</h4>
                            <p class="card-text" style="color: grey;">Yes, we offer special rates for group bookings. Please contact our reservations team directly to inquire about group rates and availability.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    document.getElementById('see-all-btn').addEventListener('click', function() {
        document.querySelector('.additional-faq-items').style.display = 'flex'; // Change display property to flex
        this.style.display = 'none';
    });
</script>

	
	<!-- Contact Section-->
	<section class="page-section" id="contact">
		<div class="container">
			<!-- Contact Section Heading-->
			<h2
				class="page-section-heading text-center text-uppercase text-secondary mb-0">Contact
				Us</h2>
			<!-- Icon Divider-->
			<div class="divider-custom">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>
			<!-- Contact Section Form-->
			<div class="row justify-content-center">
				<div class="col-lg-8 col-xl-7">
					<!-- * * * * * * * * * * * * * * *-->
					<!-- * * SB Forms Contact Form * *-->
					<!-- * * * * * * * * * * * * * * *-->
					<!-- This form is pre-integrated with SB Forms.-->
					<!-- To make this form functional, sign up at-->
					<!-- https://startbootstrap.com/solution/contact-forms-->
					<!-- to get an API token!-->
					<form id="contactForm" data-sb-form-api-token="API_TOKEN">
						<!-- Name input-->
						<div class="form-floating mb-3">
							<input class="form-control" id="name" type="text"
								placeholder="Enter your name..." data-sb-validations="required" />
							<label for="name">Full name</label>
							<div class="invalid-feedback" data-sb-feedback="name:required">A
								name is required.</div>
						</div>
						<!-- Email address input-->
						<div class="form-floating mb-3">
							<input class="form-control" id="email" type="email"
								placeholder="name@example.com"
								data-sb-validations="required,email" /> <label for="email">Email
								address</label>
							<div class="invalid-feedback" data-sb-feedback="email:required">An
								email is required.</div>
							<div class="invalid-feedback" data-sb-feedback="email:email">Email
								is not valid.</div>
						</div>
						<!-- Phone number input-->
						<div class="form-floating mb-3">
							<input class="form-control" id="phone" type="tel"
								placeholder="(123) 456-7890" data-sb-validations="required" />
							<label for="phone">Phone number</label>
							<div class="invalid-feedback" data-sb-feedback="phone:required">A
								phone number is required.</div>
						</div>
						<!-- Message input-->
						<div class="form-floating mb-3">
							<textarea class="form-control" id="message" type="text"
								placeholder="Enter your message here..." style="height: 10rem"
								data-sb-validations="required"></textarea>
							<label for="message">Message</label>
							<div class="invalid-feedback" data-sb-feedback="message:required">A
								message is required.</div>
						</div>
						<!-- Submit success message-->
						<!---->
						<!-- This is what your users will see when the form-->
						<!-- has successfully submitted-->
						<div class="d-none" id="submitSuccessMessage">
							<div class="text-center mb-3">
								<div class="fw-bolder">Form submission successful!</div>
								To activate this form, sign up at <br /> <a
									href="https://startbootstrap.com/solution/contact-forms">https://startbootstrap.com/solution/contact-forms</a>
							</div>
						</div>
						<!-- Submit error message-->
						<!---->
						<!-- This is what your users will see when there is-->
						<!-- an error submitting the form-->
						<div class="d-none" id="submitErrorMessage">
							<div class="text-center text-danger mb-3">Error sending
								message!</div>
						</div>
						<!-- Submit Button-->
						<button class="btn btn-primary btn-xl disabled" id="submitButton"
							type="submit">Send</button>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer-->
<footer class="footer text-center">
    <div class="container">
        <div class="row">
            <!-- Footer Location-->
            <div class="col-lg-4 mb-5 mb-lg-0">
                <h4 class="text-uppercase mb-4">Location</h4>
                <p class="lead mb-0">
                    Sisli/ Istanbul <br /> No: 123/B
                </p>
            </div>
            <!-- Footer Contact Information-->
            <div class="col-lg-4 mb-5 mb-lg-0">
                <h4 class="text-uppercase mb-4">Contact</h4>
                <p class="lead mb-0">Phone: <a href="tel:+902126664000">0212-666-40-00</a></p>
            </div>
            <!-- Footer Social Icons-->
            <div class="col-lg-4 mb-5 mb-lg-0">
                <h4 class="text-uppercase mb-4">Around the Web</h4>
                <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-facebook-f"></i></a> 
                <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-twitter"></i></a> 
                <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-linkedin-in"></i></a> 
                <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-dribbble"></i></a>
            </div>
        </div>
    </div>
</footer>

	<!-- Copyright Section-->
	<div class="copyright py-4 text-center text-white">
		<div class="container">
			<small>Copyright &copy; Your Website 2024</small>
		</div>
	</div>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<!-- * *                               SB Forms JS                               * *-->
	<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>
