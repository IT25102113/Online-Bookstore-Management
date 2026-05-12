<%@ include file="common/header.jsp" %>
<div class="space-y-8 animate__animated animate__fadeIn">

    <!-- Wishlist Header -->
    <div class="relative overflow-hidden rounded-3xl bg-gradient-to-br from-red-400 to-pink-500 p-8 text-white shadow-2xl">
        <div class="absolute inset-0 opacity-10">
            <div class="absolute top-0 right-0 w-64 h-64 bg-white rounded-full -translate-y-1/2 translate-x-1/2"></div>
        </div>
        <div class="relative z-10 flex items-center justify-between gap-4 flex-wrap">
            <div class="flex items-center gap-4">
                <div class="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center">
                    <i class="fas fa-heart text-3xl"></i>
                </div>
                <div>
                    <h2 class="font-display text-3xl font-bold">My Wishlist</h2>
                    <p class="text-white/80">Your favorite books saved for later</p>
                </div>
            </div>
            <div>
                <button onclick="shareWishlist(${sessionScope.user.id})" class="px-5 py-3 bg-white/10 hover:bg-white/20 text-white rounded-xl font-bold border border-white/20 transition-all text-sm flex items-center gap-2">
                    <i class="fas fa-share-alt"></i> Share Wishlist
                </button>
            </div>
        </div>
    </div>

    <!-- Wishlist Items -->
    <c:choose>
        <c:when test="${not empty wishlistItems}">
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-6">
                <c:forEach var="item" items="${wishlistItems}">
                    <div class="group bg-white rounded-2xl shadow-lg border border-accent/20 overflow-hidden card-hover flex flex-col relative">
                        <!-- Remove Button -->
                        <form action="/wishlist/remove" method="POST" class="absolute top-3 right-3 z-10">
                            <input type="hidden" name="bookId" value="${item.book.id}">
                            <button type="submit" class="w-8 h-8 bg-white/90 backdrop-blur rounded-full flex items-center justify-center text-red-400 hover:text-red-600 hover:bg-white shadow-lg transition-all" title="Remove from wishlist">
                                <i class="fas fa-heart text-sm"></i>
                            </button>
                        </form>

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
                                        <i class="fas fa-cart-plus mr-1"></i>Buy
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
                <i class="fas fa-heart text-7xl text-accent mb-6"></i>
                <h3 class="text-2xl font-bold text-primary mb-2">Your Wishlist is Empty</h3>
                <p class="text-secondary mb-6">Browse our collection and add books you love!</p>
                <a href="/" class="inline-flex items-center gap-2 px-8 py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg text-sm">
                    <i class="fas fa-book-open"></i> Browse Books
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function shareWishlist(userId) {
    if (!userId) {
        alert("Please log in first to share your wishlist!");
        return;
    }
    var shareUrl = window.location.origin + "/wishlist/share/" + userId;
    navigator.clipboard.writeText(shareUrl).then(function() {
        alert("Wishlist share link copied to clipboard!\nShare it with your friends: " + shareUrl);
    }, function() {
        alert("Failed to copy link automatically. Here is your link:\n" + shareUrl);
    });
}
</script>
<%@ include file="common/footer.jsp" %>
