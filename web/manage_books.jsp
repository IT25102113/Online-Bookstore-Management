<%@ page import="utils.FileHandler" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Books - Online Bookstore</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .book-img { width: 60px; height: 85px; object-fit: cover; border-radius: 5px; border: 1px solid #ddd; }
    .card { border: none; border-radius: 12px; }
    .table thead { background-color: #212529; color: white; }
  </style>
</head>
<body class="bg-light">
<div class="container mt-5 mb-5">
  <h2 class="text-center mb-4">📚 Inventory Management System</h2>

  <div class="card p-4 mb-5 shadow-sm">
    <h4 id="formTitle" class="mb-3">Add New Book</h4>
    <form action="BookServlet" method="POST" enctype="multipart/form-data" class="row g-3">
      <input type="hidden" name="action" id="formAction" value="add">
      <input type="hidden" name="oldData" id="oldData">
      <input type="hidden" name="bookId" id="bookId">
      <input type="hidden" name="type" id="bookType" value="Printed Book">

      <div class="col-md-3">
        <label class="form-label">Book Title</label>
        <input type="text" name="title" id="title" class="form-control" placeholder="Enter title" required>
      </div>
      <div class="col-md-3">
        <label class="form-label">Author</label>
        <input type="text" name="author" id="author" class="form-control" placeholder="Enter author" required>
      </div>
      <div class="col-md-2">
        <label class="form-label">Price ($)</label>
        <input type="number" name="price" id="price" class="form-control" step="0.01" placeholder="0.00" required>
      </div>
      <div class="col-md-4">
        <label class="form-label">Cover Image</label>
        <input type="file" name="image" id="imageInput" class="form-control" accept="image/*">
        <small class="text-muted" id="imageHelp">Required only for new books.</small>
      </div>

      <div class="col-12 d-flex justify-content-end mt-4">
        <button type="button" id="cancelBtn" class="btn btn-secondary me-2" style="display:none;" onclick="resetForm()">Cancel</button>
        <button type="submit" id="submitBtn" class="btn btn-primary px-5">Add Book</button>
      </div>
    </form>
  </div>

  <div class="card p-4 shadow-sm">
    <h4 class="mb-3">Current Book Stock</h4>
    <div class="table-responsive">
      <table class="table table-hover align-middle">
        <thead>
        <tr>
          <th>Cover</th>
          <th>ID</th>
          <th>Title</th>
          <th>Author</th>
          <th>Price</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
          List<String> books = FileHandler.readFromFile("books.txt");
          for (String bookRow : books) {
            String[] d = bookRow.split(",");
            // d[0]=ID, d[1]=Title, d[2]=Author, d[3]=Price, d[4]=Type, d[5]=ImageURL
        %>
        <tr>
          <td>
            <img src="<%= d[5] %>" class="book-img" alt="cover">
          </td>
          <td><small class="text-muted"><%= d[0] %></small></td>
          <td><strong><%= d[1] %></strong></td>
          <td><%= d[2] %></td>
          <td>$<%= d[3] %></td>
          <td>
            <button class="btn btn-sm btn-warning me-1"
                    onclick="editBook('<%= bookRow %>', '<%= d[0] %>', '<%= d[1] %>', '<%= d[2] %>', '<%= d[3] %>', '<%= d[4] %>')">Edit</button>

            <form action="BookServlet" method="POST" style="display:inline;">
              <input type="hidden" name="action" value="delete">
              <input type="hidden" name="oldData" value="<%= bookRow %>">
              <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this book?')">Delete</button>
            </form>
          </td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
    <% if(books.isEmpty()) { %>
    <p class="text-center text-muted mt-3">No books found in the inventory.</p>
    <% } %>
  </div>
</div>

<script>
  function editBook(row, id, title, author, price, type) {
    // Form එක Update mode එකට සකස් කිරීම
    document.getElementById('formTitle').innerText = "Update Book Details";
    document.getElementById('formAction').value = "update";
    document.getElementById('submitBtn').innerText = "Update Details";
    document.getElementById('submitBtn').className = "btn btn-success px-5";
    document.getElementById('cancelBtn').style.display = "block";

    // Edit කරද්දී අලුතින් image එකක් දැමීම අනිවාර්ය නැත
    document.getElementById('imageInput').required = false;
    document.getElementById('imageHelp').innerText = "Leave empty to keep current image.";

    // දත්ත Form එකට පිරවීම
    document.getElementById('oldData').value = row;
    document.getElementById('bookId').value = id;
    document.getElementById('title').value = title;
    document.getElementById('author').value = author;
    document.getElementById('price').value = price;
    document.getElementById('bookType').value = type;

    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  function resetForm() {
    document.getElementById('formTitle').innerText = "Add New Book";
    document.getElementById('formAction').value = "add";
    document.getElementById('submitBtn').innerText = "Add Book";
    document.getElementById('submitBtn').className = "btn btn-primary px-5";
    document.getElementById('cancelBtn').style.display = "none";
    document.getElementById('imageInput').required = true;
    document.getElementById('imageHelp').innerText = "Required for new books.";

    document.getElementById('title').value = "";
    document.getElementById('author').value = "";
    document.getElementById('price').value = "";
    document.getElementById('imageInput').value = "";
  }

  // මුලින්ම Add කරද්දී Image එක අනිවාර්යයි
  document.getElementById('imageInput').required = true;
</script>
</body>
</html>