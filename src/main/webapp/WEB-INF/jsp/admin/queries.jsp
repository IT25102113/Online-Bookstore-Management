<%@ include file="../common/header.jsp" %>
<div class="space-y-6 animate__animated animate__fadeIn">
    <div class="flex items-center justify-between">
        <div>
            <h2 class="text-2xl font-display font-bold text-primary">Customer Queries</h2>
            <p class="text-secondary text-sm">Manage and respond to customer support queries</p>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty queries}">
            <div class="bg-white rounded-2xl shadow-lg border border-accent/20 overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead class="bg-base">
                            <tr>
                                <th class="p-4 text-left text-xs font-bold text-primary uppercase">Customer</th>
                                <th class="p-4 text-left text-xs font-bold text-primary uppercase">Subject & Message</th>
                                <th class="p-4 text-left text-xs font-bold text-primary uppercase">Date</th>
                                <th class="p-4 text-left text-xs font-bold text-primary uppercase">Status</th>
                                <th class="p-4 text-center text-xs font-bold text-primary uppercase">Action</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-accent/10">
                            <c:forEach var="q" items="${queries}">
                                <tr class="hover:bg-base/50 transition-all ${q.status == 'PENDING' ? 'bg-amber-50/30' : ''}">
                                    <td class="p-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-xs">${q.user.fullName.substring(0,1)}</div>
                                            <div>
                                                <span class="block text-sm font-bold text-primary">${q.user.fullName}</span>
                                                <span class="block text-xs text-secondary">${q.user.email}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="p-4 max-w-md">
                                        <p class="text-sm font-bold text-primary truncate">${q.subject}</p>
                                        <p class="text-xs text-secondary truncate mt-0.5">${q.message}</p>
                                    </td>
                                    <td class="p-4 text-xs text-secondary">${q.createdAt != null ? q.createdAt.toLocalDate() : 'N/A'}</td>
                                    <td class="p-4">
                                        <span class="px-2.5 py-1 rounded-full text-[10px] font-bold ${q.status == 'ANSWERED' ? 'bg-green-100 text-green-700' : 'bg-amber-100 text-amber-700'}">
                                            ${q.status}
                                        </span>
                                    </td>
                                    <td class="p-4 text-center">
                                        <div class="flex items-center justify-center gap-2">
                                            <button onclick="toggleModal('adminReplyModal_${q.id}')"
                                                    class="px-3 py-1.5 ${q.status == 'PENDING' ? 'bg-blue-500 hover:bg-blue-600 text-white' : 'bg-base text-secondary hover:bg-accent/20'} rounded-lg transition-all text-xs font-bold flex items-center gap-1.5">
                                                <i class="fas ${q.status == 'PENDING' ? 'fa-reply' : 'fa-eye'}"></i>
                                                ${q.status == 'PENDING' ? 'Reply' : 'View Thread'}
                                            </button>
                                            
                                            <form action="/admin/queries/delete/${q.id}" method="POST" class="inline" onsubmit="return confirm('Are you sure you want to delete this query?');">
                                                <button type="submit" class="px-3 py-1.5 bg-red-100 text-red-600 hover:bg-red-200 rounded-lg transition-all text-xs font-bold flex items-center gap-1.5">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-20 bg-white rounded-3xl shadow-lg border border-accent/20">
                <i class="fas fa-check-circle text-7xl text-accent mb-6"></i>
                <h3 class="text-2xl font-bold text-primary mb-2">All Caught Up!</h3>
                <p class="text-secondary">There are no customer queries at the moment.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Admin Reply Modals -->
<c:forEach var="q" items="${queries}">
<div id="adminReplyModal_${q.id}" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center">
    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-lg mx-4 p-8 animate__animated animate__zoomIn max-h-[90vh] flex flex-col">
        <div class="flex justify-between items-center mb-6">
            <h3 class="text-xl font-bold text-primary"><i class="fas fa-comments mr-2 text-blue-400"></i>Query Thread</h3>
            <button onclick="toggleModal('adminReplyModal_${q.id}')" class="text-secondary hover:text-primary transition-colors">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>
        
        <div class="flex-1 overflow-y-auto pr-2 space-y-4 mb-6">
            <!-- Original Message -->
            <div class="bg-base rounded-xl p-4 border border-accent/20">
                <p class="text-xs text-secondary font-bold uppercase mb-1">Original Query &bull; ${q.createdAt != null ? q.createdAt.toLocalDate() : ''}</p>
                <p class="text-sm font-bold text-primary mt-1">${q.subject}</p>
                <p class="text-sm text-secondary mt-2">${q.message}</p>
            </div>

            <!-- Replies Loop -->
            <c:forEach var="reply" items="${q.replies}">
                <div class="${reply.sender.role == 'ADMIN' ? 'bg-blue-50 border-blue-100 ml-8' : 'bg-white border-accent/30 mr-8'} rounded-xl p-4 border relative">
                    <p class="text-xs font-bold ${reply.sender.role == 'ADMIN' ? 'text-blue-600' : 'text-primary'} mb-1 flex items-center gap-1">
                        <i class="fas ${reply.sender.role == 'ADMIN' ? 'fa-headset' : 'fa-user'}"></i> ${reply.sender.role == 'ADMIN' ? 'BookLeaf Support' : reply.sender.fullName}
                        <span class="text-[10px] text-secondary font-normal ml-auto">${reply.createdAt != null ? reply.createdAt.toLocalDate() : ''}</span>
                    </p>
                    <p class="text-sm text-primary leading-relaxed">${reply.message}</p>
                </div>
            </c:forEach>
        </div>

        <form action="/admin/queries/reply" method="POST" class="space-y-4 mt-auto">
            <input type="hidden" name="queryId" value="${q.id}">
            <div>
                <textarea name="reply" rows="3" required placeholder="Type your response here..."
                          class="w-full bg-base border border-accent/30 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-primary resize-none"></textarea>
            </div>
            <div class="flex gap-3">
                <button type="submit"
                        class="flex-1 py-2.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg hover:shadow-primary/30 text-sm">Send Reply</button>
            </div>
        </form>
    </div>
</div>
</c:forEach>

<script>

function toggleModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal.classList.contains('hidden')) {
        modal.classList.remove('hidden');
        modal.classList.add('flex');
    } else {
        modal.classList.add('hidden');
        modal.classList.remove('flex');
    }
}
</script>
<%@ include file="../common/footer.jsp" %>
