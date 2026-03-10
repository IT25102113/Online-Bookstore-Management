<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.User" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Profile - Bookstore</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .profile-card { border-radius: 15px; overflow: hidden; }
    .profile-header { background: linear-gradient(135deg, #212529 0%, #343a40 100%); color: white; padding: 40px 20px; }
    .profile-img { width: 120px; height: 120px; border-radius: 50%; border: 5px solid white; margin-top: -60px; background: white; object-fit: cover; }
  </style>
</head>
<body class="bg-light">
<%@ include file="navbar.jsp" %>

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card profile-card shadow border-0 text-center">
        <div class="profile-header">
          <h3 class="mb-0">User Profile</h3>
        </div>
        <div class="card-body pt-0">
          <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" class="profile-img mb-3 shadow" alt="User Image">

          <%
            User user = (User) session.getAttribute("loggedUser");
            if (user != null) {
          %>
          <h4 class="fw-bold mt-2"><%= user.getName() %></h4>
          <p class="text-muted"><%= user.getEmail() %></p>

          <hr class="my-4">

          <div class="row text-start px-4">
            <div class="col-6 mb-3">
              <small class="text-muted d-block">Account Status</small>
              <span class="badge bg-success text-white">Active</span>
            </div>
            <div class="col-6 mb-3">
              <small class="text-muted d-block">User Role</small>
              <span class="fw-bold text-dark">Member</span>
            </div>
          </div>

          <div class="d-grid gap-2 mt-4 px-4 pb-4">
            <button class="btn btn-outline-primary rounded-pill">Edit Profile</button>
            <a href="login.jsp" class="btn btn-danger rounded-pill">Logout</a>
          </div>
          <% } else { %>
          <div class="py-5">
            <p class="text-danger">Please login to view your profile.</p>
            <a href="login.jsp" class="btn btn-primary rounded-pill">Go to Login</a>
          </div>
          <% } %>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>