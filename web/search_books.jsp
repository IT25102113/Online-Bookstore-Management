<%@ page import="utils.FileHandler" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Search Books - Bookstore</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .book-card-img { height: 250px; object-fit: cover; }
  </style>
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
  <div class="container">
    <a class="navbar-brand" href="dashboard.jsp">Bookstore</a>
  </div>
</nav>

<div class="container">
  <h2 class="text-center mb-4">Find Your Favorite Books</h2>

  <div class="row justify-content-center mb-5">
    <div class="col-md-6">
      <form action="search_books.jsp" method="GET" class="d-flex shadow-sm">
        <input type="text" name="query" class="form-control me-2" placeholder="Search by Title or Author..."
               value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
        <button type="submit" class="btn btn-primary px-4">Search</button>
      </form>
    </div>
  </div>

  <div class="row">
    <%
      String searchQuery = request.getParameter("query");
      List<String> allBooks = FileHandler.readFromFile("books.txt");
      boolean found = false;

      for (String bookRow : allBooks) {
        String[] d = bookRow.split(",");
        // d[0]=ID, d[1]=Title, d[2]=Author, d[3]=Price, d[4]=Type, d[5]=ImageURL
        if (searchQuery == null || searchQuery.isEmpty() ||
                d[1].toLowerCase().contains(searchQuery.toLowerCase()) ||
                d[2].toLowerCase().contains(searchQuery.toLowerCase())) {

          found = true;
    %>
    <div class="col-md-3 mb-4">
      <div class="card shadow-sm h-100 border-0">
        <img src="<%= d[5] %>" class="card-img-top book-card-img" alt="Book Cover">
        <div class="card-body text-center">
          <h5 class="card-title text-dark text-truncate"><%= d[1] %></h5>
          <p class="text-muted small">By <%= d[2] %></p>
          <h5 class="text-success">$<%= d[3] %></h5>
          <span class="badge bg-light text-dark mb-3"><%= d[4] %></span>
          <div class="d-grid">
            <button class="btn btn-primary btn-sm">Buy Now</button>
          </div>
        </div>
      </div>
    </div>
    <%
        }
      }
      if (!found) {
    %>
    <div class="text-center mt-5"><h4>No books found!</h4></div>
    <% } %>
  </div>
</div>
</body>
</html>