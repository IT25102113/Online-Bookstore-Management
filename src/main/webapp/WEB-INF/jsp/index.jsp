<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user}">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookLeaf - Premium Online Bookstore</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: { extend: { colors: { primary: '#546b41', secondary: '#99ad7a', accent: '#dcccac', base: '#fff8ec' },
                fontFamily: { sans: ['Inter', 'sans-serif'], display: ['Playfair Display', 'serif'] } } }
        }
    </script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        * { font-family: 'Inter', sans-serif; }
        body { background: #FFF8EC; }
        @keyframes float { 0%, 100% { transform: translateY(0px); } 50% { transform: translateY(-15px); } }
        .float { animation: float 4s ease-in-out infinite; }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
        .fade-up { animation: fadeInUp 0.8s ease forwards; }
        .fade-up-delay-1 { animation-delay: 0.2s; opacity: 0; }
        .fade-up-delay-2 { animation-delay: 0.4s; opacity: 0; }
        .fade-up-delay-3 { animation-delay: 0.6s; opacity: 0; }
    </style>
</head>
<body class="bg-base">
    <nav class="fixed top-0 left-0 right-0 z-50 bg-white/80 backdrop-blur-xl border-b border-accent/30">
        <div class="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
            <a href="/" class="flex items-center gap-3">
                <div class="w-10 h-10 bg-primary rounded-xl flex items-center justify-center">
                    <i class="fas fa-leaf text-white text-lg"></i>
                </div>
                <span class="font-display text-2xl font-bold text-primary">BookLeaf</span>
            </a>
            <div class="flex items-center gap-4">
                <a href="/login" class="px-6 py-2.5 text-primary font-semibold hover:bg-base rounded-xl transition-all text-sm">Sign In</a>
                <a href="/register" class="px-6 py-2.5 bg-primary text-white font-semibold rounded-xl hover:bg-dark transition-all shadow-lg shadow-primary/20 text-sm">Get Started</a>
            </div>
        </div>
    </nav>

    <section class="pt-32 pb-20 px-6">
        <div class="max-w-7xl mx-auto">
            <div class="grid md:grid-cols-2 gap-16 items-center">
                <div class="fade-up">
                    <div class="inline-flex items-center gap-2 bg-secondary/10 text-primary px-4 py-2 rounded-full text-sm font-semibold mb-6">
                        <i class="fas fa-sparkles text-secondary"></i>
                        <span>Premium Online Bookstore</span>
                    </div>
                    <h1 class="font-display text-6xl font-bold text-primary leading-tight mb-6">
                        Discover Your <br>
                        <span class="text-secondary">Next Great</span> <br>
                        Read Today
                    </h1>
                    <p class="text-lg text-secondary/80 mb-10 leading-relaxed max-w-lg">
                        Explore thousands of books across every genre. From bestsellers to hidden gems, find your perfect read at BookLeaf.
                    </p>
                    <div class="flex gap-4">
                        <a href="/register" class="px-8 py-4 bg-primary text-white font-bold rounded-2xl hover:bg-dark transition-all shadow-xl shadow-primary/30 text-sm flex items-center gap-2">
                            <i class="fas fa-rocket"></i> Start Shopping
                        </a>
                        <a href="/login" class="px-8 py-4 border-2 border-primary text-primary font-bold rounded-2xl hover:bg-primary hover:text-white transition-all text-sm flex items-center gap-2">
                            <i class="fas fa-sign-in-alt"></i> Sign In
                        </a>
                    </div>
                </div>
                <div class="relative fade-up fade-up-delay-1">
                    <div class="float">
                        <div class="w-full h-96 bg-gradient-to-br from-primary/10 to-secondary/10 rounded-[3rem] flex items-center justify-center border border-accent/30">
                            <div class="text-center">
                                <i class="fas fa-book-open text-8xl text-primary/30 mb-4"></i>
                                <p class="text-primary/50 font-display text-2xl font-bold">BookLeaf</p>
                                <p class="text-secondary/50 text-sm mt-1">Your Literary Companion</p>
                            </div>
                        </div>
                    </div>
                    <div class="absolute -top-4 -right-4 w-20 h-20 bg-secondary/20 rounded-2xl rotate-12 float" style="animation-delay: 0.5s;"></div>
                    <div class="absolute -bottom-4 -left-4 w-16 h-16 bg-accent/40 rounded-full float" style="animation-delay: 1s;"></div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-20 px-6 bg-white/50">
        <div class="max-w-7xl mx-auto">
            <div class="text-center mb-16 fade-up fade-up-delay-1">
                <h2 class="font-display text-4xl font-bold text-primary mb-4">Why Choose BookLeaf?</h2>
                <p class="text-secondary text-lg">Everything you need for the perfect reading experience</p>
            </div>
            <div class="grid md:grid-cols-3 gap-8">
                <div class="bg-white p-8 rounded-3xl shadow-lg border border-accent/20 hover:shadow-2xl transition-all hover:-translate-y-2 fade-up fade-up-delay-1">
                    <div class="w-16 h-16 bg-primary/10 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-book text-3xl text-primary"></i>
                    </div>
                    <h3 class="text-xl font-bold text-primary mb-3">Vast Collection</h3>
                    <p class="text-secondary">Thousands of titles across fiction, non-fiction, academic, and more.</p>
                </div>
                <div class="bg-white p-8 rounded-3xl shadow-lg border border-accent/20 hover:shadow-2xl transition-all hover:-translate-y-2 fade-up fade-up-delay-2">
                    <div class="w-16 h-16 bg-secondary/10 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-bolt text-3xl text-secondary"></i>
                    </div>
                    <h3 class="text-xl font-bold text-primary mb-3">Instant E-Books</h3>
                    <p class="text-secondary">Get 20% off on e-book versions. Start reading instantly after purchase.</p>
                </div>
                <div class="bg-white p-8 rounded-3xl shadow-lg border border-accent/20 hover:shadow-2xl transition-all hover:-translate-y-2 fade-up fade-up-delay-3">
                    <div class="w-16 h-16 bg-accent/30 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-shield-alt text-3xl text-primary"></i>
                    </div>
                    <h3 class="text-xl font-bold text-primary mb-3">Secure Payments</h3>
                    <p class="text-secondary">Multiple payment options with bank-level security for every transaction.</p>
                </div>
            </div>
        </div>
    </section>

    <c:if test="${not empty books}">
    <section class="py-20 px-6">
        <div class="max-w-7xl mx-auto">
            <div class="flex items-center justify-between mb-12">
                <div>
                    <h2 class="font-display text-4xl font-bold text-primary">Our Collection</h2>
                    <p class="text-secondary mt-2">Explore our latest arrivals</p>
                </div>
                <a href="/login" class="px-6 py-3 border-2 border-primary text-primary font-bold rounded-xl hover:bg-primary hover:text-white transition-all text-sm">
                    View All <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-6">
                <c:forEach var="book" items="${books}" end="9">
                    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 overflow-hidden hover:shadow-2xl transition-all hover:-translate-y-2">
                        <div class="h-48 bg-gradient-to-br from-primary/5 to-secondary/5 flex items-center justify-center p-6">
                            <c:choose>
                                <c:when test="${not empty book.imageUrl}">
                                    <img src="${book.imageUrl}" alt="${book.title}" class="max-h-full object-contain rounded-lg">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-book text-5xl text-primary/20"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="p-4">
                            <p class="text-[10px] text-secondary font-bold uppercase">${book.category}</p>
                            <h4 class="font-bold text-sm text-primary truncate mt-1">${book.title}</h4>
                            <p class="text-xs text-secondary mt-1">${book.author != null ? book.author.name : 'Unknown'}</p>
                            <p class="text-primary font-bold mt-2">LKR ${book.price}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
    </c:if>

    <section class="py-20 px-6">
        <div class="max-w-4xl mx-auto">
            <div class="bg-gradient-to-br from-primary to-dark rounded-[3rem] p-16 text-center text-white shadow-2xl relative overflow-hidden">
                <div class="absolute inset-0 opacity-10">
                    <div class="absolute top-10 left-10 w-40 h-40 bg-white rounded-full"></div>
                    <div class="absolute bottom-10 right-10 w-60 h-60 bg-white rounded-full"></div>
                </div>
                <div class="relative z-10">
                    <h2 class="font-display text-4xl font-bold mb-4">Ready to Start Reading?</h2>
                    <p class="text-white/80 text-lg mb-8 max-w-lg mx-auto">Join BookLeaf today and get access to our entire collection of books.</p>
                    <a href="/register" class="inline-flex items-center gap-2 px-10 py-4 bg-white text-primary font-bold rounded-2xl hover:shadow-2xl transition-all text-sm">
                        <i class="fas fa-user-plus"></i> Create Free Account
                    </a>
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-white/50 border-t border-accent/30 py-8 px-6">
        <div class="max-w-7xl mx-auto text-center">
            <p class="text-secondary text-sm">&copy; 2026 BookLeaf — Premium Online Bookstore. All Rights Reserved.</p>
        </div>
    </footer>
</body>
</html>
</c:if>

<c:if test="${not empty sessionScope.user}">
<%@ include file="common/header.jsp" %>

<div class="space-y-10 animate__animated animate__fadeIn">

    <div class="relative overflow-hidden rounded-3xl bg-gradient-to-br from-primary to-dark p-10 text-white shadow-2xl">
        <div class="absolute inset-0 opacity-5">
            <div class="absolute top-0 right-0 w-96 h-96 bg-white rounded-full -translate-y-1/2 translate-x-1/2"></div>
            <div class="absolute bottom-0 left-0 w-64 h-64 bg-white rounded-full translate-y-1/2 -translate-x-1/2"></div>
        </div>
        <div class="relative z-10 max-w-2xl">
            <h2 class="font-display text-4xl font-bold mb-3">Welcome to BookLeaf</h2>
            <p class="text-white/80 text-lg">Discover, explore, and purchase your next favorite books from our curated collection.</p>
        </div>
    </div>

    <c:if test="${not empty categories}">
    <div class="flex items-center gap-3 flex-wrap">
        <span class="text-sm font-bold text-primary mr-2">Categories:</span>
        <a href="/" class="px-4 py-2 rounded-full text-sm font-medium transition-all ${empty selectedCategory ? 'bg-primary text-white' : 'bg-white text-primary border border-accent/30 hover:bg-primary hover:text-white'}">
            All Books
        </a>
        <c:forEach var="cat" items="${categories}">
            <a href="/?category=${cat}" class="px-4 py-2 rounded-full text-sm font-medium transition-all ${selectedCategory == cat ? 'bg-primary text-white' : 'bg-white text-primary border border-accent/30 hover:bg-primary hover:text-white'}">
                ${cat}
            </a>
        </c:forEach>
    </div>
    </c:if>

    <c:if test="${not empty searchQuery}">
        <div class="flex items-center gap-3 bg-white rounded-2xl p-4 border border-accent/20">
            <i class="fas fa-search text-secondary"></i>
            <p class="text-primary text-sm">Showing results for "<strong>${searchQuery}</strong>"</p>
            <a href="/" class="ml-auto text-sm text-secondary hover:text-primary"><i class="fas fa-times mr-1"></i>Clear</a>
        </div>
    </c:if>

    <div>
        <div class="flex items-center justify-between mb-6">
            <h3 class="text-2xl font-bold text-primary font-display">
                <c:choose>
                    <c:when test="${not empty searchQuery}">Search Results</c:when>
                    <c:when test="${not empty selectedCategory}">${selectedCategory}</c:when>
                    <c:otherwise>All Books</c:otherwise>
                </c:choose>
            </h3>
            <p class="text-secondary text-sm">${books.size()} books found</p>
        </div>

        <c:choose>
            <c:when test="${not empty books}">
                <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-6">
                    <c:forEach var="book" items="${books}">
                        <a href="/book/${book.id}" class="group bg-white rounded-2xl shadow-lg border border-accent/20 overflow-hidden card-hover flex flex-col">
                            <!-- Book Image -->
                            <div class="h-52 bg-gradient-to-br from-primary/5 to-secondary/5 flex items-center justify-center p-6 relative overflow-hidden">
                                <c:choose>
                                    <c:when test="${not empty book.imageUrl}">
                                        <img src="${book.imageUrl}" alt="${book.title}" class="max-h-full object-contain rounded-lg group-hover:scale-110 transition-transform duration-500">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-book text-6xl text-primary/15 group-hover:scale-110 transition-transform duration-500"></i>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${book.hasEbook}">
                                    <span class="absolute top-3 right-3 bg-secondary text-white text-[10px] font-bold px-2 py-1 rounded-full">E-Book</span>
                                </c:if>
                            </div>
                            <!-- Book Info -->
                            <div class="p-4 flex-1 flex flex-col">
                                <p class="text-[10px] text-secondary font-bold uppercase tracking-wider">${book.category}</p>
                                <h4 class="font-bold text-sm text-primary mt-1 truncate">${book.title}</h4>
                                <p class="text-xs text-secondary/70 mt-1">${book.author != null ? book.author.name : 'Unknown Author'}</p>
                                <div class="mt-auto pt-3 flex items-center justify-between">
                                    <span class="text-primary font-bold text-lg">LKR ${book.price}</span>
                                    <c:if test="${book.quantity > 0}">
                                        <span class="text-[10px] text-secondary bg-secondary/10 px-2 py-1 rounded-full">In Stock</span>
                                    </c:if>
                                    <c:if test="${book.quantity <= 0}">
                                        <span class="text-[10px] text-red-500 bg-red-50 px-2 py-1 rounded-full">Out of Stock</span>
                                    </c:if>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-20">
                    <i class="fas fa-book-open text-7xl text-accent mb-6"></i>
                    <h3 class="text-2xl font-bold text-primary mb-2">No Books Found</h3>
                    <p class="text-secondary">Try searching with different keywords or browse all categories.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
</c:if>
