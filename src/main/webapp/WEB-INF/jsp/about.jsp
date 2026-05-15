<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | BookLeaf</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .member-card:hover { transform: translateY(-5px); }
        .member-card { transition: all 0.3s ease; }
    </style>
</head>
<body class="bg-amber-50/30 flex flex-col min-h-screen font-sans text-stone-800">

    <jsp:include page="common/header.jsp" />

    <main class="flex-grow container mx-auto px-6 py-12">
        <div class="text-center mb-16">
            <h1 class="text-4xl font-bold text-emerald-900 mb-4">Meet the Team</h1>
            <p class="text-lg text-stone-600 max-w-2xl mx-auto">
                We are a passionate team of 6 software engineering students from SLIIT who built BookLeaf as part of our SE1020 OOP Module. Our goal was to create a modern, efficient, and beautiful online bookstore system.
            </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            
            <!-- Dulara -->
            <div class="member-card bg-white rounded-2xl shadow-sm border border-emerald-100 p-6 text-center">
                <div class="w-24 h-24 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center text-3xl font-bold mx-auto mb-4">
                    DA
                </div>
                <h3 class="text-xl font-bold text-emerald-900">Dulara Anjana</h3>
                <p class="text-sm font-semibold text-emerald-600 mb-3">Team Leader / Core Architecture</p>
                <p class="text-sm text-stone-600 mb-4 h-16">Developed the core system architecture, authentication, user management, and overall UI/UX dashboards.</p>
                <a href="https://www.linkedin.com/in/dulara-anjana-074b3a2b2/" class="inline-flex items-center justify-center text-stone-400 hover:text-blue-600 transition-colors">
                    <i class="fab fa-linkedin text-2xl"></i>
                </a>
            </div>

            <!-- Rashin -->
            <div class="member-card bg-white rounded-2xl shadow-sm border border-emerald-100 p-6 text-center">
                <div class="w-24 h-24 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center text-3xl font-bold mx-auto mb-4">
                    RS
                </div>
                <h3 class="text-xl font-bold text-emerald-900">Rashin</h3>
                <p class="text-sm font-semibold text-emerald-600 mb-3">Book Management</p>
                <p class="text-sm text-stone-600 mb-4 h-16">Implemented the book catalog, author relations, book details viewing, and admin inventory management.</p>
                <a href="#" class="inline-flex items-center justify-center text-stone-400 hover:text-blue-600 transition-colors">
                    <i class="fab fa-linkedin text-2xl"></i>
                </a>
            </div>

            <!-- Udayangani -->
            <div class="member-card bg-white rounded-2xl shadow-sm border border-emerald-100 p-6 text-center">
                <div class="w-24 h-24 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center text-3xl font-bold mx-auto mb-4">
                    UD
                </div>
                <h3 class="text-xl font-bold text-emerald-900">Udayangani</h3>
                <p class="text-sm font-semibold text-emerald-600 mb-3">Order Processing</p>
                <p class="text-sm text-stone-600 mb-4 h-16">Handled the checkout flow, order status tracking, financial calculations, and admin order management.</p>
                <a href="#" class="inline-flex items-center justify-center text-stone-400 hover:text-blue-600 transition-colors">
                    <i class="fab fa-linkedin text-2xl"></i>
                </a>
            </div>

            <!-- Gayathri -->
            <div class="member-card bg-white rounded-2xl shadow-sm border border-emerald-100 p-6 text-center">
                <div class="w-24 h-24 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center text-3xl font-bold mx-auto mb-4">
                    GY
                </div>
                <h3 class="text-xl font-bold text-emerald-900">Gayathri</h3>
                <p class="text-sm font-semibold text-emerald-600 mb-3">Support & Notifications</p>
                <p class="text-sm text-stone-600 mb-4 h-16">Developed the customer support query system and the real-time user notification center.</p>
                <a href="https://www.linkedin.com/in/gayathri-hettiarachchi-a675973a2/" class="inline-flex items-center justify-center text-stone-400 hover:text-blue-600 transition-colors">
                    <i class="fab fa-linkedin text-2xl"></i>
                </a>
            </div>

            <!-- Beneesha -->
            <div class="member-card bg-white rounded-2xl shadow-sm border border-emerald-100 p-6 text-center">
                <div class="w-24 h-24 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center text-3xl font-bold mx-auto mb-4">
                    BN
                </div>
                <h3 class="text-xl font-bold text-emerald-900">Beneesha</h3>
                <p class="text-sm font-semibold text-emerald-600 mb-3">Reviews & Ratings</p>
                <p class="text-sm text-stone-600 mb-4 h-16">Created the dynamic book review system, star rating calculations, and feedback moderation.</p>
                <a href="#" class="inline-flex items-center justify-center text-stone-400 hover:text-blue-600 transition-colors">
                    <i class="fab fa-linkedin text-2xl"></i>
                </a>
            </div>

            <!-- Peneesha -->
            <div class="member-card bg-white rounded-2xl shadow-sm border border-emerald-100 p-6 text-center">
                <div class="w-24 h-24 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center text-3xl font-bold mx-auto mb-4">
                    PN
                </div>
                <h3 class="text-xl font-bold text-emerald-900">Peneesha</h3>
                <p class="text-sm font-semibold text-emerald-600 mb-3">Cart & Discounts</p>
                <p class="text-sm text-stone-600 mb-4 h-16">Engineered the shopping cart session management, wishlist logic, and promotional discount system.</p>
                <a href="#" class="inline-flex items-center justify-center text-stone-400 hover:text-blue-600 transition-colors">
                    <i class="fab fa-linkedin text-2xl"></i>
                </a>
            </div>

        </div>
    </main>

    <jsp:include page="common/footer.jsp" />

</body>
</html>
