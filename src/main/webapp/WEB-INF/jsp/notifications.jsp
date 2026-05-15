<%@ include file="common/header.jsp" %>
<div class="max-w-4xl mx-auto space-y-6 animate__animated animate__fadeIn">
    <div class="flex items-center justify-between">
        <div>
            <h2 class="text-2xl font-display font-bold text-primary">Notifications</h2>
            <p class="text-secondary text-sm">Stay updated on your orders and queries</p>
        </div>
        <c:if test="${not empty notifications}">
            <form action="/notifications/read-all" method="POST">
                <button type="submit" class="px-5 py-2.5 bg-white border-2 border-accent/30 text-secondary font-bold rounded-xl hover:bg-base transition-all text-sm flex items-center gap-2">
                    <i class="fas fa-check-double"></i> Mark all as read
                </button>
            </form>
        </c:if>
    </div>

    <c:choose>
        <c:when test="${not empty notifications}">
            <div class="space-y-4">
                <c:forEach var="n" items="${notifications}">
                    <div class="bg-white rounded-2xl shadow-sm border border-accent/20 p-6 transition-all relative overflow-hidden flex items-start gap-4 ${n.read ? 'opacity-70' : 'shadow-md border-primary/20'}">
                        
                        <div class="w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0 text-xl
                            ${n.type == 'ORDER_UPDATE' ? 'bg-amber-100 text-amber-600' : 
                              n.type == 'REVIEW_REPLY' ? 'bg-blue-100 text-blue-600' : 
                              n.type == 'QUERY_REPLY' ? 'bg-purple-100 text-purple-600' : 'bg-gray-100 text-gray-600'}">
                            <i class="fas 
                                ${n.type == 'ORDER_UPDATE' ? 'fa-box-open' : 
                                  n.type == 'REVIEW_REPLY' ? 'fa-star' : 
                                  n.type == 'QUERY_REPLY' ? 'fa-headset' : 'fa-bell'}"></i>
                        </div>

                        <div class="flex-1 min-w-0">
                            <div class="flex justify-between items-start mb-1">
                                <h3 class="font-bold text-primary text-base ${n.read ? '' : 'text-primary font-black'}">
                                    ${n.type == 'ORDER_UPDATE' ? 'Order Update' : 
                                      n.type == 'REVIEW_REPLY' ? 'Review Reply' : 
                                      n.type == 'QUERY_REPLY' ? 'Support Reply' : 'Notification'}
                                </h3>
                                <p class="text-xs text-secondary whitespace-nowrap ml-4"><i class="far fa-clock mr-1"></i>${n.createdAt != null ? n.createdAt.toLocalDate() : ''}</p>
                            </div>
                            <p class="text-sm text-secondary leading-relaxed">${n.message}</p>
                            
                            <div class="mt-4 flex justify-end">
                                <c:if test="${!n.read}">
                                    <form action="/notifications/read" method="POST" class="inline">
                                        <input type="hidden" name="notificationId" value="${n.id}">
                                        <button type="submit" class="text-xs font-bold text-primary bg-primary/5 hover:bg-primary/10 px-3 py-1.5 rounded-lg transition-colors">
                                            ${n.targetUrl != null ? 'View Details' : 'Mark as read'}
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${n.read && n.targetUrl != null}">
                                    <a href="${n.targetUrl}" class="text-xs font-bold text-primary bg-primary/5 hover:bg-primary/10 px-3 py-1.5 rounded-lg transition-colors">
                                        View Details
                                    </a>
                                </c:if>
                            </div>
                        </div>
                        
                        <c:if test="${!n.read}">
                            <div class="absolute top-1/2 -translate-y-1/2 right-4 w-3 h-3 bg-primary rounded-full shadow-lg shadow-primary/40"></div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-20 bg-white rounded-3xl shadow-lg border border-accent/20">
                <i class="far fa-bell-slash text-7xl text-accent mb-6"></i>
                <h3 class="text-2xl font-bold text-primary mb-2">No Notifications</h3>
                <p class="text-secondary">You're all caught up! There are no notifications to display.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="common/footer.jsp" %>
