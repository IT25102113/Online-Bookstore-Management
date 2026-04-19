<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - BookLeaf</title>
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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        * { font-family: 'Inter', system-ui, sans-serif; }
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

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-15px) rotate(2deg); }
        }
        .float-1 { animation: float 6s ease-in-out infinite; }
        .float-2 { animation: float 8s ease-in-out infinite 1s; }
        .float-3 { animation: float 7s ease-in-out infinite 2s; }
    </style>
</head>
<body class="bg-base min-h-screen flex">

    <c:if test="${not empty success}">
        <div id="toastSuccess" class="fixed top-6 right-6 z-[9999] px-6 py-4 rounded-2xl shadow-2xl text-white font-bold flex items-center gap-3 toast-enter bg-gradient-to-r from-primary to-secondary max-w-md">
            <div class="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center flex-shrink-0">
                <i class="fas fa-check text-lg"></i>
            </div>
            <span class="text-sm">${success}</span>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div id="toastError" class="fixed top-6 right-6 z-[9999] px-6 py-4 rounded-2xl shadow-2xl text-white font-bold flex items-center gap-3 toast-enter bg-gradient-to-r from-red-500 to-red-700 max-w-md">
            <div class="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center flex-shrink-0">
                <i class="fas fa-exclamation-triangle text-lg"></i>
            </div>
            <span class="text-sm">${error}</span>
        </div>
    </c:if>

    <div class="hidden lg:flex w-1/2 bg-gradient-to-br from-primary to-dark p-16 flex-col justify-between relative overflow-hidden">
        <div class="absolute inset-0 opacity-[0.07]">
            <div class="absolute top-20 right-20 w-96 h-96 bg-white rounded-full"></div>
            <div class="absolute bottom-20 left-20 w-64 h-64 bg-white rounded-full"></div>
            <div class="absolute top-1/2 left-1/2 w-48 h-48 bg-white rounded-full -translate-x-1/2 -translate-y-1/2"></div>
        </div>

        <div class="absolute top-32 right-32 float-1 opacity-20">
            <i class="fas fa-book text-white text-6xl"></i>
        </div>
        <div class="absolute bottom-48 left-32 float-2 opacity-15">
            <i class="fas fa-book-open text-white text-5xl"></i>
        </div>
        <div class="absolute top-1/2 right-16 float-3 opacity-10">
            <i class="fas fa-feather-alt text-white text-4xl"></i>
        </div>

        <div class="relative z-10">
            <a href="/" class="flex items-center gap-3 group">
                <div class="w-14 h-14 bg-white/10 rounded-2xl flex items-center justify-center group-hover:bg-white/20 transition-all">
                    <i class="fas fa-leaf text-3xl text-white"></i>
                </div>
                <div>
                    <span class="font-display text-3xl font-bold text-white">BookLeaf</span>
                    <p class="text-white/40 text-xs tracking-widest uppercase">Online Bookstore</p>
                </div>
            </a>
        </div>

        <div class="relative z-10">
            <h2 class="font-display text-5xl font-bold text-white leading-tight mb-6">
                Welcome<br>
                <span class="text-secondary">Back!</span>
            </h2>
            <p class="text-white/60 text-lg max-w-sm leading-relaxed">
                Sign in to continue your literary journey and discover amazing books waiting for you.
            </p>
            <div class="flex items-center gap-4 mt-8">
                <div class="flex -space-x-3">
                    <div class="w-10 h-10 rounded-full bg-secondary/40 border-2 border-white/20 flex items-center justify-center text-white text-xs font-bold">JD</div>
                    <div class="w-10 h-10 rounded-full bg-accent/50 border-2 border-white/20 flex items-center justify-center text-white text-xs font-bold">AK</div>
                    <div class="w-10 h-10 rounded-full bg-primary border-2 border-white/20 flex items-center justify-center text-white text-xs font-bold">RM</div>
                </div>
                <p class="text-white/40 text-sm">Join 1,000+ happy readers</p>
            </div>
        </div>

        <div class="relative z-10">
            <p class="text-white/30 text-sm">&copy; 2026 BookLeaf. All rights reserved.</p>
        </div>
    </div>

    <div class="flex-1 flex items-center justify-center p-8">
        <div class="w-full max-w-md animate__animated animate__fadeIn">

            <div class="lg:hidden flex items-center gap-3 mb-10">
                <div class="w-12 h-12 bg-primary rounded-2xl flex items-center justify-center shadow-lg shadow-primary/30">
                    <i class="fas fa-leaf text-white text-xl"></i>
                </div>
                <div>
                    <span class="font-display text-2xl font-bold text-primary">BookLeaf</span>
                    <p class="text-secondary text-xs">Online Bookstore</p>
                </div>
            </div>

            <h1 class="font-display text-4xl font-bold text-primary mb-2">Sign In</h1>
            <p class="text-secondary mb-10">Enter your credentials to access your account</p>

            <form action="/login" method="POST" class="space-y-5" id="loginForm">
                <div>
                    <label class="block text-sm font-bold text-primary mb-2">Email Address</label>
                    <div class="relative">
                        <i class="fas fa-envelope absolute left-4 top-3.5 text-secondary/50"></i>
                        <input type="email" name="email" required
                               placeholder="your@email.com"
                               class="w-full pl-11 pr-4 py-3 bg-white border-2 border-accent/30 rounded-xl focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all text-primary placeholder-secondary/40">
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-bold text-primary mb-2">Password</label>
                    <div class="relative">
                        <i class="fas fa-lock absolute left-4 top-3.5 text-secondary/50"></i>
                        <input type="password" name="password" id="passwordInput" required
                               placeholder="Enter your password" minlength="3"
                               class="w-full pl-11 pr-12 py-3 bg-white border-2 border-accent/30 rounded-xl focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all text-primary placeholder-secondary/40">
                        <button type="button" onclick="togglePassword()" class="absolute right-4 top-3.5 text-secondary/50 hover:text-primary transition-colors">
                            <i class="fas fa-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                </div>

                <button type="submit"
                        class="w-full py-3.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg shadow-primary/20 flex items-center justify-center gap-2 text-sm hover:shadow-xl hover:scale-[1.02] active:scale-[0.98]">
                    <i class="fas fa-sign-in-alt"></i>
                    Sign In
                </button>
            </form>

            <div class="flex items-center gap-4 my-8">
                <div class="flex-1 h-px bg-accent/30"></div>
                <span class="text-secondary text-xs font-medium">or</span>
                <div class="flex-1 h-px bg-accent/30"></div>
            </div>

            <p class="text-center text-secondary text-sm">
                Don't have an account?
                <a href="/register" class="text-primary font-bold hover:underline transition-all">Create Account</a>
            </p>

            <div class="mt-8 p-4 bg-base rounded-xl border border-accent/20">
                <p class="text-xs text-secondary/70 text-center">
                    <i class="fas fa-info-circle mr-1"></i>

                </p>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const input = document.getElementById('passwordInput');
            const icon = document.getElementById('eyeIcon');
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }

        setTimeout(() => {
            document.querySelectorAll('[id^="toast"]').forEach(el => {
                el.classList.replace('toast-enter', 'toast-exit');
                setTimeout(() => el.remove(), 500);
            });
        }, 4000);
    </script>
</body>
</html>
