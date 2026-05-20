<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html lang="en">
    <jsp:include page="/WEB-INF/templates/head.jsp">
      <jsp:param name="pageTitle" value="About Us — Paw Furr-Ever" />
      <jsp:param name="description" value="Meet the amazing team behind Paw Furr-Ever." />
      <jsp:param name="cssFile" value="about.css" />
    </jsp:include>

    <body>

      <jsp:include page="/WEB-INF/templates/nav.jsp">
        <jsp:param name="activeLink" value="about" />
      </jsp:include>

      <section class="about-hero">
        <div class="container">
          <h1>About Us</h1>
          <p>We are a passionate team of pet lovers dedicated to providing the best for your pets</p>
        </div>
      </section>

      <section class="team-section">
        <div class="container">
          <h2 class="section-title">Meet Our Team</h2>
          <div class="team-grid">
            <!-- Member 1 -->
            <div class="team-card">
              <div class="team-img-wrapper"><a href="https://sohangrg.vercel.app/" target="_blank">
                <img src="${pageContext.request.contextPath}/images/Members/Member1.png" alt="Sohan Gurung"
                     class="team-img" />
              </a>
              </div>
              <h3>Sohan Gurung</h3>
              <p class="role">System Security</p>
              <p class="bio">Sohan was responsible for developing the core authentication system of the application.
              </p>
            </div>
            <!-- Member 2 -->
            <div class="team-card">
              <div class="team-img-wrapper">
                <img src="${pageContext.request.contextPath}/images/Members/Member2.jpeg" alt="Priyanka Gurung"
                  class="team-img" />
              </div>
              <h3>Priyanka Gurung</h3>
              <p class="role">Authentication and Validation</p>
              <p class="bio">Priyanka handled the error handling and filter implementation across the application.</p>
            </div>
            <!-- Member 3 -->
            <div class="team-card">
              <div class="team-img-wrapper">
                <img src="${pageContext.request.contextPath}/images/Members/Member3.jpeg" alt="Sandeep Gurung"
                  class="team-img" />
              </div>
              <h3>Sandeep Gurung</h3>
              <p class="role">Admin CRUD Operations</p>
              <p class="bio">Sandeep was responsible for building the product, user and image handling modules for admin.</p>
            </div>
            <!-- Member 4 -->
            <div class="team-card">
              <div class="team-img-wrapper">
                <img src="${pageContext.request.contextPath}/images/Members/Member4.png" alt="Sashank Bikram Shahi"
                  class="team-img" />
              </div>
              <h3>Sashank Bikram Shahi</h3>
              <p class="role">Admin CRUD Operations</p>
              <p class="bio">
                Sashank developed the Admin panel, including the dashboard with the sales graph and the order.</p>
            </div>
            <!-- Member 5 -->
            <div class="team-card">
              <div class="team-img-wrapper">
                <img src="${pageContext.request.contextPath}/images/Members/Member5.jpeg" alt="Ayush Sharma"
                  class="team-img" />
              </div>
              <h3>Ayush Sharma</h3>
              <p class="role">Product page</p>
              <p class="bio">
                Ayush built the product detail pages, shopping cart, checkout process and order placement functionality.</p>
            </div>
            <!-- Member 6 -->
            <div class="team-card">
              <div class="team-img-wrapper">
                <img src="${pageContext.request.contextPath}/images/Members/Member6.png" alt="Aayush Thapa"
                  class="team-img" />
              </div>
              <h3>Aayush Thapa</h3>
              <p class="role">CSS and DB connection</p>
              <p class="bio">Aayush designed and developed the Home page, About Us page and ensured full mobile responsiveness across the application.</p>
            </div>
          </div>
        </div>
      </section>

      <section class="contact-section">
        <div class="container">
          <h2 class="section-title">Contact Us</h2>
          <div class="contact-grid">
            <div class="contact-card">
              <div class="contact-icon">📧</div>
              <h3>Email</h3>
              <p><a href="mailto:pawfurr-ever@gmail.com">pawfurr-ever@gmail.com</a></p>
            </div>
            <div class="contact-card">
              <div class="contact-icon">📞</div>
              <h3>Phone</h3>
              <p><a href="tel:+9779800000000">+977 980-0000000</a></p>
            </div>
            <div class="contact-card">
              <div class="contact-icon">📍</div>
              <h3>Address</h3>
              <p>Pokhara, Nepal<br>Street 4, XYZ</p>
            </div>
          </div>
        </div>
      </section>

      <jsp:include page="/WEB-INF/templates/footer.jsp" />

    </body>

    </html>