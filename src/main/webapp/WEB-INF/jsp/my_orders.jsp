<%@ include file="common/header.jsp" %>
<div class="space-y-8 animate__animated animate__fadeIn">
    <div><h2 class="text-3xl font-display font-bold text-primary">My Orders</h2><p class="text-secondary">Track your purchase history</p></div>
    <c:choose><c:when test="${not empty orders}">
        <div class="space-y-4">
            <c:forEach var="order" items="${orders}">
                <div class="bg-white rounded-2xl shadow-lg border border-accent/20 overflow-hidden">
                    <div class="p-5 flex items-center justify-between bg-base border-b border-accent/20">
                        <div class="flex items-center gap-6">
                            <div><p class="text-[10px] text-secondary font-bold uppercase">Order ID</p><p class="text-primary font-bold">#${order.id}</p></div>
                            <div><p class="text-[10px] text-secondary font-bold uppercase">Date</p><p class="text-primary text-sm">${order.createdAt != null ? order.createdAt.toLocalDate() : 'N/A'}</p></div>
                            <div><p class="text-[10px] text-secondary font-bold uppercase">Payment</p><p class="text-primary text-sm">${order.paymentMethod}</p></div>
                        </div>
                        <div class="text-right">
                            <span class="px-3 py-1 rounded-full text-xs font-bold ${order.orderStatus == 'DELIVERED' || order.orderStatus == 'EMAIL_SENT' ? 'bg-green-100 text-green-700' : order.orderStatus == 'SHIPPED' || order.orderStatus == 'OUT_FOR_DELIVERY' ? 'bg-blue-100 text-blue-700' : 'bg-amber-100 text-amber-700'}">${order.orderStatus}</span>
                            <p class="text-primary font-bold text-lg mt-1">LKR ${order.totalAmount}</p>
                        </div>
                    </div>
                    
                    <div class="px-5 py-4 bg-gray-50 border-b border-accent/20">
                        <c:set var="isEbookOnly" value="true" />
                        <c:forEach var="item" items="${order.items}">
                            <c:if test="${item.format != 'EBOOK'}">
                                <c:set var="isEbookOnly" value="false" />
                            </c:if>
                        </c:forEach>
                        
                        <c:choose>
                            <c:when test="${isEbookOnly}">
                                <div class="flex items-center justify-between text-xs font-bold text-secondary max-w-md mx-auto relative">
                                    <div class="absolute left-0 top-3 w-full h-1 bg-gray-200 rounded-full z-0"></div>
                                    <div class="absolute left-0 top-3 h-1 bg-primary rounded-full z-0 transition-all duration-1000" 
                                         style="width: ${order.orderStatus == 'EMAIL_SENT' ? '100%' : '0%'}"></div>
                                    
                                    <div class="relative z-10 flex flex-col items-center gap-2">
                                        <div class="w-6 h-6 rounded-full flex items-center justify-center ${order.orderStatus == 'CONFIRMED' || order.orderStatus == 'EMAIL_SENT' ? 'bg-primary text-white shadow-md' : 'bg-gray-200 text-gray-400'}"><i class="fas fa-check text-[10px]"></i></div>
                                        <span>Confirmed</span>
                                    </div>
                                    <div class="relative z-10 flex flex-col items-center gap-2">
                                        <div class="w-6 h-6 rounded-full flex items-center justify-center ${order.orderStatus == 'EMAIL_SENT' ? 'bg-primary text-white shadow-md' : 'bg-gray-200 text-gray-400'}"><i class="fas fa-envelope text-[10px]"></i></div>
                                        <span>Email Sent</span>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="flex items-center justify-between text-xs font-bold text-secondary max-w-2xl mx-auto relative">
                                    <c:set var="progress" value="0%" />
                                    <c:choose>
                                        <c:when test="${order.orderStatus == 'CONFIRMED'}"><c:set var="progress" value="0%" /></c:when>
                                        <c:when test="${order.orderStatus == 'PROCESSING'}"><c:set var="progress" value="25%" /></c:when>
                                        <c:when test="${order.orderStatus == 'READY_FOR_SHIPPING'}"><c:set var="progress" value="50%" /></c:when>
                                        <c:when test="${order.orderStatus == 'SHIPPED'}"><c:set var="progress" value="75%" /></c:when>
                                        <c:when test="${order.orderStatus == 'OUT_FOR_DELIVERY'}"><c:set var="progress" value="90%" /></c:when>
                                        <c:when test="${order.orderStatus == 'DELIVERED'}"><c:set var="progress" value="100%" /></c:when>
                                    </c:choose>
                                    
                                    <div class="absolute left-0 top-3 w-full h-1 bg-gray-200 rounded-full z-0"></div>
                                    <div class="absolute left-0 top-3 h-1 bg-primary rounded-full z-0 transition-all duration-1000" 
                                         style="width: ${progress}"></div>
                                    
                                    <div class="relative z-10 flex flex-col items-center gap-2">
                                        <div class="w-6 h-6 rounded-full flex items-center justify-center ${order.orderStatus == 'CONFIRMED' || progress != '0%' ? 'bg-primary text-white shadow-md' : 'bg-gray-200 text-gray-400'}"><i class="fas fa-check text-[10px]"></i></div>
                                        <span class="hidden sm:inline">Confirmed</span>
                                    </div>
                                    <div class="relative z-10 flex flex-col items-center gap-2">
                                        <div class="w-6 h-6 rounded-full flex items-center justify-center ${progress == '25%' || progress == '50%' || progress == '75%' || progress == '90%' || progress == '100%' ? 'bg-primary text-white shadow-md' : 'bg-gray-200 text-gray-400'}"><i class="fas fa-box text-[10px]"></i></div>
                                        <span class="hidden sm:inline">Processing</span>
                                    </div>
                                    <div class="relative z-10 flex flex-col items-center gap-2">
                                        <div class="w-6 h-6 rounded-full flex items-center justify-center ${progress == '50%' || progress == '75%' || progress == '90%' || progress == '100%' ? 'bg-primary text-white shadow-md' : 'bg-gray-200 text-gray-400'}"><i class="fas fa-clipboard-check text-[10px]"></i></div>
                                        <span class="hidden sm:inline">Ready</span>
                                    </div>
                                    <div class="relative z-10 flex flex-col items-center gap-2">
                                        <div class="w-6 h-6 rounded-full flex items-center justify-center ${progress == '75%' || progress == '90%' || progress == '100%' ? 'bg-primary text-white shadow-md' : 'bg-gray-200 text-gray-400'}"><i class="fas fa-truck text-[10px]"></i></div>
                                        <span class="hidden sm:inline">Shipped</span>
                                    </div>
                                    <div class="relative z-10 flex flex-col items-center gap-2">
                                        <div class="w-6 h-6 rounded-full flex items-center justify-center ${progress == '100%' ? 'bg-primary text-white shadow-md' : 'bg-gray-200 text-gray-400'}"><i class="fas fa-home text-[10px]"></i></div>
                                        <span class="hidden sm:inline">Delivered</span>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="p-5">
                        <c:forEach var="item" items="${order.items}">
                            <div class="flex items-center gap-4 py-2 ${not s.last ? 'border-b border-accent/10' : ''}">
                                <div class="w-12 h-12 bg-base rounded-lg flex items-center justify-center flex-shrink-0"><i class="fas fa-book text-primary/30"></i></div>
                                <div class="flex-1"><p class="font-bold text-primary text-sm">${item.book.title}</p><p class="text-xs text-secondary">${item.format} &bull; Qty: ${item.quantity}</p></div>
                                <p class="font-bold text-primary text-sm">LKR ${item.subtotal}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when><c:otherwise>
        <div class="text-center py-20 bg-white rounded-3xl shadow-lg border border-accent/20">
            <i class="fas fa-receipt text-7xl text-accent mb-6"></i>
            <h3 class="text-2xl font-bold text-primary mb-2">No orders yet</h3>
            <p class="text-secondary mb-8">Start shopping to see your orders here.</p>
            <a href="/" class="px-8 py-3 bg-primary text-white font-bold rounded-xl text-sm"><i class="fas fa-book-open mr-2"></i>Browse Books</a>
        </div>
    </c:otherwise></c:choose>
</div>
<%@ include file="common/footer.jsp" %>
