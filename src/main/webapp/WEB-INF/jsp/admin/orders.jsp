<%@ include file="../common/header.jsp" %>
<div class="space-y-8 animate__animated animate__fadeIn">
    <div class="flex items-center justify-between">
        <div>
            <h2 class="text-3xl font-display font-bold text-primary">Manage Orders</h2>
            <p class="text-secondary">Update order tracking statuses</p>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
            <span class="block sm:inline">${success}</span>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
            <span class="block sm:inline">${error}</span>
        </div>
    </c:if>

    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-base border-b border-accent/20">
                <tr>
                    <th class="px-6 py-4 text-left text-xs font-bold text-secondary uppercase tracking-wider">Order ID</th>
                    <th class="px-6 py-4 text-left text-xs font-bold text-secondary uppercase tracking-wider">Customer</th>
                    <th class="px-6 py-4 text-left text-xs font-bold text-secondary uppercase tracking-wider">Amount</th>
                    <th class="px-6 py-4 text-left text-xs font-bold text-secondary uppercase tracking-wider">Date</th>
                    <th class="px-6 py-4 text-left text-xs font-bold text-secondary uppercase tracking-wider">Items</th>
                    <th class="px-6 py-4 text-left text-xs font-bold text-secondary uppercase tracking-wider">Status</th>
                    <th class="px-6 py-4 text-left text-xs font-bold text-secondary uppercase tracking-wider">Update Status</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-accent/10">
                <c:forEach var="order" items="${orders}">
                    <tr class="hover:bg-base/50 transition-colors">
                        <td class="px-6 py-4 whitespace-nowrap"><div class="text-sm font-bold text-primary">#${order.id}</div></td>
                        <td class="px-6 py-4 whitespace-nowrap"><div class="text-sm text-primary">${order.user.fullName}</div></td>
                        <td class="px-6 py-4 whitespace-nowrap"><div class="text-sm font-bold text-primary">LKR ${order.totalAmount}</div></td>
                        <td class="px-6 py-4 whitespace-nowrap"><div class="text-sm text-secondary">${order.createdAt != null ? order.createdAt.toLocalDate() : 'N/A'}</div></td>
                        <td class="px-6 py-4"><div class="text-sm text-secondary">
                            <c:forEach var="item" items="${order.items}">
                                ${item.book.title} (${item.format}) x${item.quantity}<br/>
                            </c:forEach>
                        </div></td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-3 py-1 rounded-full text-xs font-bold 
                            ${order.orderStatus == 'CONFIRMED' ? 'bg-blue-100 text-blue-700' : 
                              order.orderStatus == 'PROCESSING' ? 'bg-purple-100 text-purple-700' : 
                              order.orderStatus == 'READY_FOR_SHIPPING' ? 'bg-orange-100 text-orange-700' : 
                              order.orderStatus == 'SHIPPED' ? 'bg-indigo-100 text-indigo-700' : 
                              order.orderStatus == 'OUT_FOR_DELIVERY' ? 'bg-amber-100 text-amber-700' : 
                              order.orderStatus == 'DELIVERED' || order.orderStatus == 'EMAIL_SENT' ? 'bg-green-100 text-green-700' : 
                              'bg-gray-100 text-gray-700'}">
                                ${order.orderStatus}
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <form action="/admin/orders/update-status" method="POST" class="flex items-center gap-2">
                                <input type="hidden" name="orderId" value="${order.id}" />
                                <select name="status" class="text-sm rounded border-accent/30 bg-base px-2 py-1 focus:ring-primary focus:border-primary">
                                    <c:forEach var="status" items="${statuses}">
                                        <option value="${status}" ${status == order.orderStatus ? 'selected' : ''}>${status}</option>
                                    </c:forEach>
                                </select>
                                <button type="submit" class="bg-primary hover:bg-primary-dark text-white px-3 py-1 rounded text-xs font-bold transition-colors">
                                    Update
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orders}">
                    <tr>
                        <td colspan="7" class="px-6 py-10 text-center text-secondary">No orders found.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>
