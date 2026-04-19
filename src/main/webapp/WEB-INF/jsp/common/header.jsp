<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookLeaf - Premium Online Bookstore</title>
    <meta name="description" content="BookLeaf - Your premium destination for books online. Browse, discover, and purchase your next favorite read.">

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#546b41',
                        secondary: '#99ad7a',
                        accent: '#dcccac',
                        base: '#fff8ec',
                        dark: '#3A4D2E',
                    },
                    fontFamily: {
                        sans: ['Inter', 'system-ui', 'sans-serif'],
                        display: ['Playfair Display', 'serif'],
                    }
                }
            }
        }
    </script>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

    <style>
        * { font-family: 'Inter', system-ui, sans-serif; }
        body { background-color: #fff8ec; }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #fff8ec; }
        ::-webkit-scrollbar-thumb { background: #dcccac; border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: #99ad7a; }

        /* Sidebar hover effects */
        .sidebar-item {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }
        .sidebar-item::before {
            content: '';
            position: absolute;
            left: 0; top: 0;
            width: 3px; height: 100%;
            background: #99ad7a;
            transform: scaleY(0);
            transition: transform 0.3s ease;
        }
        .sidebar-item:hover::before { transform: scaleY(1); }
        .sidebar-item:hover { background: rgba(153, 173, 122, 0.15); padding-left: 1.25rem; }

        /* Toast Animation */
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }
        .toast-enter { animation: slideInRight 0.5s ease forwards; }
        .toast-exit { animation: slideOutRight 0.5s ease forwards; }

        /* Glass effect */
        .glass {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
        }

        /* Gradient text */
        .gradient-text {
            background: linear-gradient(135deg, #546b41, #99ad7a);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Card hover lift */
        .card-hover {
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .card-hover:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(84, 107, 65, 0.15);
        }

        /* Pulse animation for badges */
        @keyframes pulse-badge {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.2); }
        }
        .badge-pulse { animation: pulse-badge 2s infinite; }

        /* Star rating */
        .star-rating input { display: none; }
        .star-rating label { cursor: pointer; font-size: 1.5rem; color: #dcccac; transition: color 0.2s; }
        .star-rating label:hover, .star-rating label:hover ~ label,
        .star-rating input:checked ~ label { color: #f59e0b; }

        /* Floating animation */
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        .float-animation { animation: float 3s ease-in-out infinite; }
    </style>
</head>
<body class="bg-base min-h-screen">

    <!-- ============================================================ -->
    <!-- TOAST NOTIFICATION SYSTEM -->
    <!-- ============================================================ -->
    <c:if test="${not empty success}">
        <div id="toastSuccess" class="fixed top-6 right-6 z-[9999] px-6 py-4 rounded-2xl shadow-2xl text-white font-bold flex items-center gap-3 toast-enter bg-gradient-to-r from-primary to-secondary max-w-md">
            <div class="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center flex-shrink-0">
                <i class="fas fa-check text-lg"></i>
            </div>
            <span class="text-sm">${success}</span>
            <button onclick="closeToast('toastSuccess')" class="ml-auto text-white/70 hover:text-white"><i class="fas fa-times"></i></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div id="toastError" class="fixed top-6 right-6 z-[9999] px-6 py-4 rounded-2xl shadow-2xl text-white font-bold flex items-center gap-3 toast-enter bg-gradient-to-r from-red-500 to-red-700 max-w-md">
            <div class="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center flex-shrink-0">
                <i class="fas fa-exclamation-triangle text-lg"></i>
            </div>
            <span class="text-sm">${error}</span>
            <button onclick="closeToast('toastError')" class="ml-auto text-white/70 hover:text-white"><i class="fas fa-times"></i></button>
        </div>
    </c:if>

    <div class="flex min-h-screen">

        <!-- ============================================================ -->
        <!-- FIXED LEFT SIDEBAR -->
        <!-- ============================================================ -->
        <c:if test="${not empty sessionScope.user}">
        <aside class="w-72 bg-primary fixed left-0 top-0 h-full z-40 shadow-2xl flex flex-col overflow-y-auto">

            <!-- Logo -->
            <div class="p-6 border-b border-white/10">
                <a href="/" class="flex items-center gap-3">
                    <div class="w-12 h-12 bg-secondary/30 rounded-2xl flex items-center justify-center">
                        <i class="fas fa-leaf text-2xl text-white"></i>
                    </div>
                    <div>
                        <h1 class="text-white font-display text-xl font-bold tracking-tight">BookLeaf</h1>
                        <p class="text-secondary text-[10px] font-medium tracking-widest uppercase">Online Bookstore</p>
                    </div>
                </a>
            </div>

            <!-- Navigation -->
            <nav class="flex-1 p-4 space-y-1">

                <!-- CUSTOMER Navigation -->
                <c:if test="${sessionScope.user.role == 'CUSTOMER'}">
                    <p class="text-secondary/60 text-[10px] font-bold uppercase tracking-widest px-3 mb-3">Browse</p>

                    <a href="/" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'home' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-home w-6"></i>
                        <span class="ml-3 font-medium text-sm">Home</span>
                    </a>
                    <a href="/books" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'books' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-book-open w-6"></i>
                        <span class="ml-3 font-medium text-sm">Browse Books</span>
                    </a>
                    <a href="/about" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'about' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-users w-6"></i>
                        <span class="ml-3 font-medium text-sm">About Us</span>
                    </a>

                    <p class="text-secondary/60 text-[10px] font-bold uppercase tracking-widest px-3 mt-6 mb-3">Shopping</p>

                    <a href="/cart" class="flex items-center justify-between p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'cart' ? 'bg-secondary/30 text-white' : ''}">
                        <div class="flex items-center">
                            <i class="fas fa-shopping-cart w-6"></i>
                            <span class="ml-3 font-medium text-sm">My Cart</span>
                        </div>
                        <c:if test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
                            <span class="bg-secondary text-white text-xs font-bold px-2 py-0.5 rounded-full badge-pulse">${sessionScope.cart.size()}</span>
                        </c:if>
                    </a>
                    <a href="/wishlist" class="flex items-center justify-between p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'wishlist' ? 'bg-secondary/30 text-white' : ''}">
                        <div class="flex items-center">
                            <i class="fas fa-heart w-6"></i>
                            <span class="ml-3 font-medium text-sm">My Wishlist</span>
                        </div>
                        <c:if test="${not empty sessionScope.wishlistCount && sessionScope.wishlistCount > 0}">
                            <span class="bg-red-400 text-white text-xs font-bold px-2 py-0.5 rounded-full">${sessionScope.wishlistCount}</span>
                        </c:if>
                    </a>
                    <a href="/my-orders" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'orders' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-receipt w-6"></i>
                        <span class="ml-3 font-medium text-sm">My Orders</span>
                    </a>

                    <p class="text-secondary/60 text-[10px] font-bold uppercase tracking-widest px-3 mt-6 mb-3">Account</p>

                    <a href="/profile" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'profile' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-user-circle w-6"></i>
                        <span class="ml-3 font-medium text-sm">My Profile</span>
                    </a>
                    <a href="/queries" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'queries' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-envelope-open-text w-6"></i>
                        <span class="ml-3 font-medium text-sm">Support Queries</span>
                    </a>
                </c:if>

                <!-- AUTHOR Navigation -->
                <c:if test="${sessionScope.user.role == 'AUTHOR'}">
                    <p class="text-secondary/60 text-[10px] font-bold uppercase tracking-widest px-3 mb-3">Author Panel</p>

                    <a href="/author/dashboard" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'authorDashboard' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-chart-pie w-6"></i>
                        <span class="ml-3 font-medium text-sm">Dashboard</span>
                    </a>

                    <p class="text-secondary/60 text-[10px] font-bold uppercase tracking-widest px-3 mt-6 mb-3">Store</p>

                    <a href="/" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'home' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-store w-6"></i>
                        <span class="ml-3 font-medium text-sm">View Store</span>
                    </a>
                    <a href="/books" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'books' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-book-open w-6"></i>
                        <span class="ml-3 font-medium text-sm">Browse Books</span>
                    </a>
                    <a href="/about" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'about' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-users w-6"></i>
                        <span class="ml-3 font-medium text-sm">About Us</span>
                    </a>
                </c:if>

                <!-- ADMIN Navigation -->
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <p class="text-secondary/60 text-[10px] font-bold uppercase tracking-widest px-3 mb-3">Admin Panel</p>

                    <a href="/admin/dashboard" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'dashboard' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-chart-pie w-6"></i>
                        <span class="ml-3 font-medium text-sm">Dashboard</span>
                    </a>

                    <p class="text-secondary/60 text-[10px] font-bold uppercase tracking-widest px-3 mt-6 mb-3">Management</p>

                    <a href="/admin/books" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'manageBooks' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-book w-6"></i>
                        <span class="ml-3 font-medium text-sm">Manage Books</span>
                    </a>
                    <a href="/admin/orders" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'manageOrders' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-box-open w-6"></i>
                        <span class="ml-3 font-medium text-sm">Manage Orders</span>
                    </a>
                    <a href="/admin/authors" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'manageAuthors' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-pen-fancy w-6"></i>
                        <span class="ml-3 font-medium text-sm">Manage Authors</span>
                    </a>
                    <a href="/admin/users" class="flex items-center justify-between p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'manageUsers' ? 'bg-secondary/30 text-white' : ''}">
                        <div class="flex items-center">
                            <i class="fas fa-users-cog w-6"></i>
                            <span class="ml-3 font-medium text-sm">Manage Users</span>
                        </div>
                        <c:if test="${not empty pendingAuthors && pendingAuthors > 0}">
                            <span class="bg-amber-400 text-primary text-xs font-bold px-2 py-0.5 rounded-full badge-pulse">${pendingAuthors}</span>
                        </c:if>
                    </a>
                    <a href="/admin/reviews" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'manageReviews' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-star-half-alt w-6"></i>
                        <span class="ml-3 font-medium text-sm">Manage Reviews</span>
                    </a>
                    <a href="/admin/discounts" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'manageDiscounts' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-tags w-6"></i>
                        <span class="ml-3 font-medium text-sm">Manage Discounts</span>
                    </a>
                    <a href="/admin/queries" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'manageQueries' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-headset w-6"></i>
                        <span class="ml-3 font-medium text-sm">Customer Queries</span>
                    </a>

                    <p class="text-secondary/60 text-[10px] font-bold uppercase tracking-widest px-3 mt-6 mb-3">Store</p>

                    <a href="/" class="flex items-center p-3 sidebar-item rounded-lg text-white/80 hover:text-white ${page == 'home' ? 'bg-secondary/30 text-white' : ''}">
                        <i class="fas fa-store w-6"></i>
                        <span class="ml-3 font-medium text-sm">View Store</span>
                    </a>
                </c:if>
            </nav>

            <!-- User Info at Bottom -->
            <div class="p-4 border-t border-white/10">
                <div class="flex items-center gap-3 p-3 rounded-xl bg-white/5">
                    <div class="w-10 h-10 rounded-full bg-secondary/30 flex items-center justify-center text-white font-bold text-sm">
                        ${sessionScope.user.fullName.substring(0,1)}
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="text-white text-sm font-semibold truncate">${sessionScope.user.fullName}</p>
                        <p class="text-secondary text-[10px] truncate">${sessionScope.user.role == 'AUTHOR' ? 'Author' : sessionScope.user.email}</p>
                    </div>
                </div>
                <a href="/logout" class="mt-3 flex items-center justify-center gap-2 p-2.5 rounded-xl text-white/60 hover:text-white hover:bg-red-500/20 transition-all text-sm font-medium">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </div>
        </aside>
        </c:if>

        <!-- ============================================================ -->
        <!-- MAIN CONTENT AREA -->
        <!-- ============================================================ -->
        <main class="${not empty sessionScope.user ? 'ml-72' : ''} flex-1 flex flex-col min-h-screen">

            <!-- Top Bar -->
            <c:if test="${not empty sessionScope.user}">
            <header class="sticky top-0 z-30 glass border-b border-accent/30 px-8 py-4">
                <div class="flex items-center justify-between">
                    <div>
                        <h2 class="text-xl font-bold text-primary">
                            <c:choose>
                                <c:when test="${page == 'home'}">Welcome back, ${sessionScope.user.fullName}!</c:when>
                                <c:when test="${page == 'dashboard'}">Admin Dashboard</c:when>
                                <c:when test="${page == 'authorDashboard'}">Author Dashboard</c:when>
                                <c:when test="${page == 'manageBooks'}">Book Management</c:when>
                                <c:when test="${page == 'manageAuthors'}">Author Management</c:when>
                                <c:when test="${page == 'manageUsers'}">User Management</c:when>
                                <c:when test="${page == 'manageReviews'}">Review Management</c:when>
                                <c:when test="${page == 'manageDiscounts'}">Discount Management</c:when>
                                <c:when test="${page == 'cart'}">Shopping Cart</c:when>
                                <c:when test="${page == 'wishlist'}">My Wishlist</c:when>
                                <c:when test="${page == 'orders'}">Order History</c:when>
                                <c:when test="${page == 'profile'}">My Profile</c:when>
                                <c:otherwise>BookLeaf</c:otherwise>
                            </c:choose>
                        </h2>
                        <p class="text-secondary text-xs mt-0.5">
                            <c:choose>
                                <c:when test="${sessionScope.user.role == 'ADMIN'}">Administrator Panel</c:when>
                                <c:when test="${sessionScope.user.role == 'AUTHOR'}">Author Panel</c:when>
                                <c:otherwise>Your premium bookstore experience</c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <div class="flex items-center gap-4">
                        <!-- Search (Customer only) -->
                        <c:if test="${sessionScope.user.role == 'CUSTOMER'}">
                            <form action="/" method="GET" class="relative">
                                <input type="text" name="query" placeholder="Search books, authors..."
                                       value="${searchQuery}"
                                       class="w-72 pl-10 pr-4 py-2.5 bg-white rounded-xl border border-accent/30 focus:outline-none focus:ring-2 focus:ring-secondary/50 transition-all text-sm text-primary placeholder-secondary/60">
                                <i class="fas fa-search absolute left-3.5 top-3 text-secondary/50 text-sm"></i>
                            </form>

                            <!-- Wishlist Icon -->
                            <a href="/wishlist" class="p-2.5 text-primary hover:bg-white rounded-xl transition-all relative" title="My Wishlist">
                                <i class="fas fa-heart text-lg"></i>
                                <c:if test="${not empty sessionScope.wishlistCount && sessionScope.wishlistCount > 0}">
                                    <span class="absolute -top-1 -right-1 bg-red-400 text-white text-[10px] font-bold w-5 h-5 rounded-full flex items-center justify-center">${sessionScope.wishlistCount}</span>
                                </c:if>
                            </a>

                            <!-- Cart Icon -->
                            <a href="/cart" class="p-2.5 text-primary hover:bg-white rounded-xl transition-all relative" title="View Cart">
                                <i class="fas fa-shopping-bag text-lg"></i>
                                <c:if test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
                                    <span class="absolute -top-1 -right-1 bg-secondary text-white text-[10px] font-bold w-5 h-5 rounded-full flex items-center justify-center badge-pulse">${sessionScope.cart.size()}</span>
                                </c:if>
                            </a>

                            <!-- Notification Icon -->
                            <a href="/notifications" class="p-2.5 text-primary hover:bg-white rounded-xl transition-all relative" title="Notifications">
                                <i class="fas fa-bell text-lg"></i>
                                <c:if test="${not empty unreadNotificationsCount && unreadNotificationsCount > 0}">
                                    <span class="absolute -top-1 -right-1 bg-red-500 text-white text-[10px] font-bold w-5 h-5 rounded-full flex items-center justify-center badge-pulse">${unreadNotificationsCount}</span>
                                </c:if>
                            </a>
                        </c:if>

                        <!-- Profile Dropdown -->
                        <div class="relative" id="profileDropdown">
                            <button onclick="toggleDropdown()" class="flex items-center gap-2 p-2 rounded-xl hover:bg-white transition-all">
                                <div class="w-9 h-9 rounded-full bg-primary text-white flex items-center justify-center font-bold text-sm">
                                    ${sessionScope.user.fullName.substring(0,1)}
                                </div>
                                <i class="fas fa-chevron-down text-xs text-secondary"></i>
                            </button>
                            <div id="dropdownMenu" class="hidden absolute right-0 top-full mt-2 w-56 bg-white rounded-2xl shadow-2xl border border-accent/20 py-2 animate__animated animate__fadeIn">
                                <div class="px-4 py-3 border-b border-accent/10">
                                    <p class="text-sm font-bold text-primary">${sessionScope.user.fullName}</p>
                                    <p class="text-xs text-secondary">${sessionScope.user.email}</p>
                                </div>
                                <c:if test="${sessionScope.user.role == 'CUSTOMER'}">
                                    <a href="/profile" class="flex items-center gap-3 px-4 py-2.5 text-sm text-primary hover:bg-base transition-all"><i class="fas fa-user-circle w-4"></i>My Profile</a>
                                    <a href="/wishlist" class="flex items-center gap-3 px-4 py-2.5 text-sm text-primary hover:bg-base transition-all"><i class="fas fa-heart w-4"></i>My Wishlist</a>
                                    <a href="/my-orders" class="flex items-center gap-3 px-4 py-2.5 text-sm text-primary hover:bg-base transition-all"><i class="fas fa-receipt w-4"></i>My Orders</a>
                                </c:if>
                                <c:if test="${sessionScope.user.role == 'AUTHOR'}">
                                    <a href="/author/dashboard" class="flex items-center gap-3 px-4 py-2.5 text-sm text-primary hover:bg-base transition-all"><i class="fas fa-chart-pie w-4"></i>My Dashboard</a>
                                </c:if>
                                <div class="border-t border-accent/10 mt-1 pt-1">
                                    <a href="/logout" class="flex items-center gap-3 px-4 py-2.5 text-sm text-red-500 hover:bg-red-50 transition-all"><i class="fas fa-sign-out-alt w-4"></i>Logout</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
            </c:if>

            <!-- Page Content -->
            <section class="flex-1 p-8">
