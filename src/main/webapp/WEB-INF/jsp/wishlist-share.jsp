<%@ include file="common/header.jsp" %>
<div class="space-y-8 animate__animated animate__fadeIn">

    <!-- Shared Wishlist Header -->
    <div class="relative overflow-hidden rounded-3xl bg-gradient-to-br from-indigo-500 to-purple-600 p-8 text-white shadow-2xl">
        <div class="absolute inset-0 opacity-10">
            <div class="absolute top-0 right-0 w-64 h-64 bg-white rounded-full -translate-y-1/2 translate-x-1/2"></div>
        </div>
        <div class="relative z-10 flex items-center justify-between gap-4 flex-wrap">
            <div class="flex items-center gap-4">
                <div class="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center">
                    <i class="fas fa-share-alt text-3xl"></i>
                </div>
                <div>
                    <h2 class="font-display text-3xl font-bold">${not empty ownerName ? ownerName : 'Someone'}'s Wishlist</h2>
                    <p class="text-white/80">Explore their favorite books on BookLeaf</p>
                </div>
            </div>
            <a href="/" class="px-5 py-2.5 bg-white/10 hover:bg-white/20 rounded-xl font-bold border border-white/20 transition-all text-sm flex items-center gap-2">
                <i class="fas fa-shopping-bag"></i> Visit Shop
            </a>
        </div>
    </div>

    <!-- Error or Wishlist Items -->
    <c:choose>
        <c:when test="${not empty error}">
            <div class="bg-white rounded-3xl shadow-lg border border-accent/20 p-16 text-center">
                <i class="fas fa-exclamation-circle text-7xl text-red-400 mb-6"></i>
                <h3 class="text-2xl font-bold text-primary mb-2">Wishlist Not Found</h3>
                <p class="text-secondary mb-6">${error}</p>
                <a href="/" class="inline-flex items-center gap-2 px-8 py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg text-sm">
                    <i class="fas fa-home"></i> Back to Home
                </a>
            </div>
        </c:when>
        <c:when test="${not empty wishlistItems}">
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-6">
                <c:forEach var="item" items="${wishlistItems}">
                    <div class="group bg-white rounded-2xl shadow-lg border border-accent/20 overflow-hidden card-hover flex flex-col relative">
                        <!-- Book Image -->
                        <a href="/book/${item.book.id}" class="block">
                            <div class="h-52 bg-gradient-to-br from-primary/5 to-secondary/5 flex items-center justify-center p-6 relative overflow-hidden">
                                <c:choose>
                                    <c:when test="${not empty item.book.imageUrl}">
                                        <img src="${item.book.imageUrl}" alt="${item.book.title}" class="max-h-full object-contain rounded-lg group-hover:scale-110 transition-transform duration-500">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-book text-6xl text-primary/15 group-hover:scale-110 transition-transform duration-500"></i>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${item.book.hasEbook}">
                                    <span class="absolute top-3 left-3 bg-secondary text-white text-[10px] font-bold px-2 py-1 rounded-full">E-Book</span>
                                </c:if>
                            </div>
                        </a>

                        <!-- Book Info -->
                        <div class="p-4 flex-1 flex flex-col">
                            <p class="text-[10px] text-secondary font-bold uppercase tracking-wider">${item.book.category}</p>
                            <h4 class="font-bold text-sm text-primary mt-1 truncate">${item.book.title}</h4>
                            <p class="text-xs text-secondary/70 mt-1">${item.book.author != null ? item.book.author.name : 'Unknown Author'}</p>
                            <div class="mt-auto pt-3 flex items-center justify-between">
                                <span class="text-primary font-bold text-lg">LKR ${item.book.price}</span>
                                <c:if test="${item.book.quantity > 0}">
                                    <a href="/book/${item.book.id}" class="text-[10px] text-white bg-primary px-3 py-1.5 rounded-full font-bold hover:bg-dark transition-all">
                                        <i class="fas fa-eye mr-1"></i>View
                                    </a>
                                </c:if>
                                <c:if test="${item.book.quantity <= 0}">
                                    <span class="text-[10px] text-red-500 bg-red-50 px-2 py-1 rounded-full">Out of Stock</span>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="bg-white rounded-3xl shadow-lg border border-accent/20 p-16 text-center">
                <i class="fas fa-heart-broken text-7xl text-accent mb-6"></i>
                <h3 class="text-2xl font-bold text-primary mb-2">This Wishlist is Empty</h3>
                <p class="text-secondary mb-6">This user hasn't added any books to their wishlist yet.</p>
                <a href="/" class="inline-flex items-center gap-2 px-8 py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg text-sm">
                    <i class="fas fa-book-open"></i> Browse Books
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="common/footer.jsp" %>
