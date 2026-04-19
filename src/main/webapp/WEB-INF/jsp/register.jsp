<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - BookLeaf</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>tailwind.config={theme:{extend:{colors:{primary:'#546b41',secondary:'#99ad7a',accent:'#dcccac',base:'#fff8ec'},fontFamily:{sans:['Inter'],display:['Playfair Display']}}}}</script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Playfair+Display:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>*{font-family:'Inter',sans-serif;}@keyframes slideIn{from{transform:translateX(100%);opacity:0}to{transform:translateX(0);opacity:1}}.toast-in{animation:slideIn .5s ease forwards}</style>
</head>
<body class="bg-base min-h-screen flex">
    <c:if test="${not empty error}">
        <div class="fixed top-6 right-6 z-50 px-6 py-4 rounded-2xl shadow-2xl text-white font-bold flex items-center gap-3 toast-in bg-gradient-to-r from-red-500 to-red-700 max-w-md">
            <i class="fas fa-exclamation-triangle text-xl"></i><span class="text-sm">${error}</span>
        </div>
    </c:if>
    <div class="hidden lg:flex w-1/2 bg-gradient-to-br from-primary to-[#3A4D2E] p-16 flex-col justify-between relative overflow-hidden">
        <div class="absolute inset-0 opacity-5"><div class="absolute top-20 right-20 w-96 h-96 bg-white rounded-full"></div></div>
        <div class="relative z-10"><a href="/" class="flex items-center gap-3"><div class="w-12 h-12 bg-white/10 rounded-2xl flex items-center justify-center"><i class="fas fa-leaf text-2xl text-white"></i></div><span class="font-display text-3xl font-bold text-white">BookLeaf</span></a></div>
        <div class="relative z-10"><h2 class="font-display text-5xl font-bold text-white leading-tight mb-4">Join Our<br>Community!</h2><p class="text-white/70 text-lg max-w-sm">Create your account and start exploring thousands of amazing books.</p></div>
        <div class="relative z-10"><p class="text-white/40 text-sm">&copy; 2026 BookLeaf</p></div>
    </div>
    <div class="flex-1 flex items-center justify-center p-8">
        <div class="w-full max-w-md animate__animated animate__fadeIn">
            <div class="lg:hidden flex items-center gap-3 mb-8"><div class="w-10 h-10 bg-primary rounded-xl flex items-center justify-center"><i class="fas fa-leaf text-white"></i></div><span class="font-display text-2xl font-bold text-primary">BookLeaf</span></div>
            <h1 class="font-display text-4xl font-bold text-primary mb-2">Create Account</h1>
            <p class="text-secondary mb-8">Fill in the details to join BookLeaf</p>
            <form action="/register" method="POST" class="space-y-4" id="registerForm">

                <!-- Register As Toggle -->
                <div>
                    <label class="block text-sm font-bold text-primary mb-2">Register As</label>
                    <div class="grid grid-cols-2 gap-3">
                        <label class="relative cursor-pointer">
                            <input type="radio" name="registerAs" value="CUSTOMER" checked class="peer sr-only" onchange="toggleAuthorFields()">
                            <div class="p-3 bg-white border-2 border-accent/30 rounded-xl text-center peer-checked:border-primary peer-checked:bg-primary/5 transition-all">
                                <i class="fas fa-user text-primary text-lg mb-1"></i>
                                <p class="text-sm font-bold text-primary">Customer</p>
                                <p class="text-[10px] text-secondary">Buy & read books</p>
                            </div>
                        </label>
                        <label class="relative cursor-pointer">
                            <input type="radio" name="registerAs" value="AUTHOR" class="peer sr-only" onchange="toggleAuthorFields()">
                            <div class="p-3 bg-white border-2 border-accent/30 rounded-xl text-center peer-checked:border-primary peer-checked:bg-primary/5 transition-all">
                                <i class="fas fa-pen-fancy text-primary text-lg mb-1"></i>
                                <p class="text-sm font-bold text-primary">Author</p>
                                <p class="text-[10px] text-secondary">Publish & sell books</p>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Author Notice -->
                <div id="authorNotice" class="hidden p-3 bg-amber-50 border border-amber-200 rounded-xl">
                    <div class="flex items-start gap-2">
                        <i class="fas fa-info-circle text-amber-500 mt-0.5"></i>
                        <p class="text-xs text-amber-700">Author accounts require admin approval before you can login. You'll be notified once approved.</p>
                    </div>
                </div>

                <div><label class="block text-sm font-bold text-primary mb-1.5">Full Name *</label><div class="relative"><i class="fas fa-user absolute left-4 top-3.5 text-secondary/50"></i><input type="text" name="fullName" required minlength="2" maxlength="100" placeholder="Your name" class="w-full pl-11 pr-4 py-3 bg-white border-2 border-accent/30 rounded-xl focus:outline-none focus:border-primary transition-all text-primary"></div></div>
                <div><label class="block text-sm font-bold text-primary mb-1.5">Email Address *</label><div class="relative"><i class="fas fa-envelope absolute left-4 top-3.5 text-secondary/50"></i><input type="email" name="email" required placeholder="your@email.com" class="w-full pl-11 pr-4 py-3 bg-white border-2 border-accent/30 rounded-xl focus:outline-none focus:border-primary transition-all text-primary"></div></div>
                <div><label class="block text-sm font-bold text-primary mb-1.5">Password * <span class="text-xs text-secondary font-normal">(min 6 chars)</span></label><div class="relative"><i class="fas fa-lock absolute left-4 top-3.5 text-secondary/50"></i><input type="password" name="password" id="passwordInput" required minlength="6" placeholder="Create a password" class="w-full pl-11 pr-12 py-3 bg-white border-2 border-accent/30 rounded-xl focus:outline-none focus:border-primary transition-all text-primary"><button type="button" onclick="togglePassword()" class="absolute right-4 top-3.5 text-secondary/50 hover:text-primary transition-colors"><i class="fas fa-eye" id="eyeIcon"></i></button></div></div>
                <div><label class="block text-sm font-bold text-primary mb-1.5">Phone <span class="text-xs text-secondary font-normal">(optional)</span></label><div class="relative"><i class="fas fa-phone absolute left-4 top-3.5 text-secondary/50"></i><input type="text" name="phone" placeholder="+94 7X XXX XXXX" class="w-full pl-11 pr-4 py-3 bg-white border-2 border-accent/30 rounded-xl focus:outline-none focus:border-primary transition-all text-primary"></div></div>
                <div><label class="block text-sm font-bold text-primary mb-1.5">Address <span class="text-xs text-secondary font-normal">(optional)</span></label><div class="relative"><i class="fas fa-map-marker-alt absolute left-4 top-3.5 text-secondary/50"></i><input type="text" name="address" placeholder="Your address" class="w-full pl-11 pr-4 py-3 bg-white border-2 border-accent/30 rounded-xl focus:outline-none focus:border-primary transition-all text-primary"></div></div>

                <!-- Author Bio Field (hidden by default) -->
                <div id="bioField" class="hidden">
                    <label class="block text-sm font-bold text-primary mb-1.5">Author Bio <span class="text-xs text-secondary font-normal">(tell us about yourself)</span></label>
                    <div class="relative">
                        <i class="fas fa-pen absolute left-4 top-3.5 text-secondary/50"></i>
                        <textarea name="bio" placeholder="Brief description about you as an author..." rows="3" class="w-full pl-11 pr-4 py-3 bg-white border-2 border-accent/30 rounded-xl focus:outline-none focus:border-primary transition-all text-primary resize-none"></textarea>
                    </div>
                </div>

                <button type="submit" class="w-full py-3.5 bg-primary text-white font-bold rounded-xl hover:bg-[#3A4D2E] transition-all shadow-lg shadow-primary/20 flex items-center justify-center gap-2 text-sm mt-2"><i class="fas fa-user-plus"></i> Create Account</button>
            </form>
            <p class="text-center text-secondary text-sm mt-6">Already have an account? <a href="/login" class="text-primary font-bold hover:underline">Sign In</a></p>
        </div>
    </div>
    <script>
        setTimeout(()=>document.querySelectorAll('.toast-in').forEach(el=>el.style.display='none'),4000);

        function toggleAuthorFields() {
            const isAuthor = document.querySelector('input[name="registerAs"]:checked').value === 'AUTHOR';
            document.getElementById('bioField').classList.toggle('hidden', !isAuthor);
            document.getElementById('authorNotice').classList.toggle('hidden', !isAuthor);
        }

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
    </script>
</body>
</html>
