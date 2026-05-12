<%@ include file="common/header.jsp" %>
<div class="max-w-5xl mx-auto space-y-8 animate__animated animate__fadeIn">
    <h2 class="text-3xl font-display font-bold text-primary">Shopping Cart</h2>
    <c:choose><c:when test="${not empty cart && cart.size() > 0}">
        <div class="grid lg:grid-cols-3 gap-8">
            <div class="lg:col-span-2 space-y-4">
                <c:forEach var="item" items="${cart}" varStatus="s">
                    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 flex items-center gap-5">
                        <div class="w-20 h-20 bg-base rounded-xl flex items-center justify-center flex-shrink-0">
                            <c:choose><c:when test="${not empty item.bookImage}"><img src="${item.bookImage}" class="max-h-full object-contain rounded"></c:when><c:otherwise><i class="fas fa-book text-2xl text-primary/20"></i></c:otherwise></c:choose>
                        </div>
                        <div class="flex-1 min-w-0">
                            <h4 class="font-bold text-primary truncate">${item.bookTitle}</h4>
                            <p class="text-xs text-secondary">${item.authorName}</p>
                            <span class="inline-block mt-1 text-[10px] font-bold ${item.format == 'EBOOK' ? 'bg-secondary/10 text-secondary' : 'bg-primary/10 text-primary'} px-2 py-0.5 rounded-full">${item.format}</span>
                        </div>
                        <div class="text-center">
                            <form action="/cart/update" method="POST" class="flex items-center gap-2">
                                <input type="hidden" name="index" value="${s.index}">
                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="99" class="w-16 px-2 py-1.5 border-2 border-accent/30 rounded-lg text-center text-sm" onchange="this.form.submit()">
                            </form>
                        </div>
                        <div class="text-right w-24"><p class="font-bold text-primary">LKR ${item.subtotal}</p><p class="text-[10px] text-secondary">LKR ${item.unitPrice} each</p></div>
                        <form action="/cart/remove" method="POST"><input type="hidden" name="index" value="${s.index}"><button type="submit" class="p-2 text-red-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-all"><i class="fas fa-trash-alt"></i></button></form>
                    </div>
                </c:forEach>
                <form action="/cart/clear" method="POST" class="text-right"><button type="submit" class="text-sm text-red-500 hover:underline"><i class="fas fa-trash mr-1"></i>Clear Cart</button></form>
            </div>
            <!-- Order Summary -->
            <div class="bg-white rounded-2xl shadow-xl border border-accent/20 p-6 h-fit sticky top-28">
                <h3 class="font-bold text-primary text-lg mb-4">Order Summary</h3>
                <div class="space-y-3 text-sm">
                    <div class="flex justify-between text-secondary"><span>Items (${cart.size()})</span><span>LKR ${cartTotal}</span></div>
                    <div class="flex justify-between text-secondary"><span>Shipping</span><span class="text-secondary font-bold">Free</span></div>
                    <hr class="border-accent/20">
                    <div class="flex justify-between text-primary font-bold text-lg"><span>Total</span><span>LKR ${cartTotal}</span></div>
                </div>
                <a href="/checkout" class="mt-6 w-full py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all text-sm flex items-center justify-center gap-2 block text-center"><i class="fas fa-lock"></i> Proceed to Checkout</a>
                <a href="/" class="mt-3 w-full py-2.5 border-2 border-primary text-primary font-bold rounded-xl hover:bg-primary hover:text-white transition-all text-sm flex items-center justify-center gap-2 block text-center"><i class="fas fa-arrow-left"></i> Continue Shopping</a>
            </div>
        </div>
    </c:when><c:otherwise>
        <div class="text-center py-20 bg-white rounded-3xl shadow-lg border border-accent/20">
            <i class="fas fa-shopping-cart text-7xl text-accent mb-6"></i>
            <h3 class="text-2xl font-bold text-primary mb-2">Your cart is empty</h3>
            <p class="text-secondary mb-8">Looks like you haven't added any books yet.</p>
            <a href="/" class="px-8 py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all text-sm"><i class="fas fa-book-open mr-2"></i>Browse Books</a>
        </div>
    </c:otherwise></c:choose>
</div>
<%@ include file="common/footer.jsp" %>
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
