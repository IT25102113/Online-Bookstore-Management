<%@ include file="common/header.jsp" %>
<div class="max-w-6xl mx-auto space-y-10 animate__animated animate__fadeIn">
    <div class="bg-white rounded-3xl shadow-2xl overflow-hidden border border-accent/20 flex flex-col md:flex-row">
        <div class="md:w-1/3 bg-gradient-to-br from-primary/5 to-secondary/5 p-12 flex items-center justify-center">
            <c:choose><c:when test="${not empty book.imageUrl}"><img src="${book.imageUrl}" alt="${book.title}" class="max-h-80 object-contain rounded-xl shadow-lg"></c:when><c:otherwise><i class="fas fa-book text-9xl text-primary/15"></i></c:otherwise></c:choose>
        </div>
        <div class="md:w-2/3 p-10 flex flex-col">
            <div class="flex items-start justify-between mb-4">
                <div><p class="text-xs text-secondary font-bold uppercase tracking-widest">${book.category}</p><h1 class="font-display text-4xl font-bold text-primary mt-2">${book.title}</h1><p class="text-secondary mt-2">by ${book.author != null ? book.author.name : 'Unknown Author'}</p></div>
                <div class="text-right">
                    <p class="text-3xl font-black text-primary">LKR ${book.price}</p>
                    <c:if test="${book.hasEbook}"><p class="text-sm text-secondary mt-1">E-Book: <span class="text-primary font-bold">LKR ${book.price * 0.8}</span> <span class="text-xs bg-secondary/10 text-secondary px-2 py-0.5 rounded-full">20% OFF</span></p></c:if>
                </div>
            </div>
            <div class="flex items-center gap-2 mb-4">
                <div class="flex"><c:forEach begin="1" end="5" var="i"><i class="fas fa-star ${i <= avgRating ? 'text-amber-400' : 'text-accent'} text-sm"></i></c:forEach></div>
                <span class="text-sm text-secondary">${avgRating} (${reviewCount} reviews)</span>
            </div>
            <p class="text-secondary leading-relaxed mb-6 flex-1">${book.description}</p>
            <div class="flex items-center gap-3 mb-6"><span class="text-sm font-bold text-primary">ISBN:</span><span class="text-sm text-secondary">${book.isbn != null ? book.isbn : 'N/A'}</span><span class="mx-3 text-accent">|</span><span class="text-sm font-bold text-primary">Stock:</span><span class="text-sm ${book.quantity > 0 ? 'text-secondary' : 'text-red-500'}">${book.quantity > 0 ? book.quantity : 'Out of Stock'}</span></div>

            <!-- Add to Cart & Wishlist -->
            <div class="flex items-center gap-4">
                <c:if test="${sessionScope.user.role == 'CUSTOMER' && book.quantity > 0}">
                <form action="/cart/add" method="POST" class="flex flex-wrap items-end gap-4 p-6 bg-base rounded-2xl border border-accent/20 flex-1">
                    <input type="hidden" name="bookId" value="${book.id}">
                    <div><label class="block text-xs font-bold text-primary mb-1.5">Format</label><select name="format" class="px-4 py-2.5 bg-white border-2 border-accent/30 rounded-xl text-sm text-primary focus:outline-none focus:border-primary" onchange="updatePrice(this)"><option value="HARDCOPY" data-price="${book.price}">Hardcopy - LKR ${book.price}</option><c:if test="${book.hasEbook}"><option value="EBOOK" data-price="${book.price * 0.8}">E-Book - LKR ${book.price * 0.8} (20% off)</option></c:if></select></div>
                    <div><label class="block text-xs font-bold text-primary mb-1.5">Quantity</label><input type="number" name="quantity" value="1" min="1" max="${book.quantity}" class="w-20 px-4 py-2.5 bg-white border-2 border-accent/30 rounded-xl text-sm text-primary focus:outline-none focus:border-primary"></div>
                    <button type="submit" class="px-8 py-2.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg text-sm flex items-center gap-2"><i class="fas fa-cart-plus"></i> Add to Cart</button>
                </form>
                </c:if>

                <!-- Wishlist Button -->
                <c:if test="${sessionScope.user.role == 'CUSTOMER'}">
                <form action="/wishlist/toggle" method="POST">
                    <input type="hidden" name="bookId" value="${book.id}">
                    <input type="hidden" name="redirectUrl" value="/book/${book.id}">
                    <button type="submit" class="w-12 h-12 rounded-2xl flex items-center justify-center transition-all shadow-lg ${isInWishlist ? 'bg-red-500 text-white hover:bg-red-600' : 'bg-white text-red-400 border-2 border-accent/30 hover:bg-red-50'}" title="${isInWishlist ? 'Remove from Wishlist' : 'Add to Wishlist'}">
                        <i class="fas fa-heart text-lg"></i>
                    </button>
                </form>
                </c:if>
            </div>
        </div>
    </div>
    <div class="bg-white rounded-3xl shadow-xl border border-accent/20 p-8">
        <h3 class="font-display text-2xl font-bold text-primary mb-6">Customer Reviews</h3>
        <c:if test="${sessionScope.user.role == 'CUSTOMER'}">
        <form action="/review/submit" method="POST" class="bg-base rounded-2xl p-6 mb-8 border border-accent/20">
            <input type="hidden" name="bookId" value="${book.id}">
            <h4 class="font-bold text-primary mb-4">Write a Review</h4>
            <div class="mb-4"><p class="text-sm font-bold text-primary mb-2">Your Rating</p>
                <div class="flex gap-1" id="starRating">
                    <c:forEach begin="1" end="5" var="i"><button type="button" onclick="setRating(${i})" class="text-2xl text-accent hover:text-amber-400 transition-colors star-btn" data-star="${i}"><i class="fas fa-star"></i></button></c:forEach>
                </div>
                <input type="hidden" name="rating" id="ratingInput" value="5" required>
            </div>
            <div class="mb-4"><textarea name="comment" rows="3" placeholder="Share your thoughts about this book..." class="w-full px-4 py-3 bg-white border-2 border-accent/30 rounded-xl text-sm text-primary focus:outline-none focus:border-primary resize-none"></textarea></div>
            <button type="submit" class="px-6 py-2.5 bg-primary text-white font-bold rounded-xl text-sm hover:bg-dark transition-all"><i class="fas fa-paper-plane mr-2"></i>Submit Review</button>
        </form>
        </c:if>
        <c:choose><c:when test="${not empty reviews}">
            <div class="space-y-4">
                <c:forEach var="review" items="${reviews}">
                    <div class="flex gap-4 p-4 rounded-2xl hover:bg-base transition-all">
                        <div class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-sm flex-shrink-0">${review.user.fullName.substring(0,1)}</div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between"><p class="font-bold text-primary text-sm">${review.user.fullName}</p><p class="text-xs text-secondary">${review.createdAt != null ? review.createdAt.toLocalDate() : 'N/A'}</p></div>
                            <div class="flex mt-1"><c:forEach begin="1" end="5" var="i"><i class="fas fa-star ${i <= review.rating ? 'text-amber-400' : 'text-accent'} text-xs"></i></c:forEach></div>
                            <p class="text-secondary text-sm mt-2">${review.comment}</p>
                            <c:if test="${not empty review.adminReply}">
                                <div class="mt-3 bg-blue-50 p-3 rounded-xl border border-blue-100 relative">
                                    <div class="absolute -top-2 left-4 w-4 h-4 bg-blue-50 rotate-45 border-l border-t border-blue-100"></div>
                                    <p class="text-xs font-bold text-blue-600 mb-1 flex items-center gap-1"><i class="fas fa-headset"></i> BookLeaf Support</p>
                                    <p class="text-sm text-primary leading-relaxed">${review.adminReply}</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when><c:otherwise>
            <div class="text-center py-10"><i class="fas fa-comments text-5xl text-accent mb-4"></i><p class="text-secondary">No reviews yet. Be the first to review this book!</p></div>
        </c:otherwise></c:choose>
    </div>
</div>
<script>
function setRating(n){document.getElementById('ratingInput').value=n;document.querySelectorAll('.star-btn').forEach((btn,i)=>{btn.querySelector('i').style.color=i<n?'#f59e0b':'#DCCCAC';})}
setRating(5);
</script>
<%@ include file="common/footer.jsp" %>
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
