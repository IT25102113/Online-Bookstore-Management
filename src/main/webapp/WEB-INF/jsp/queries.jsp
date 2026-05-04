<%@ include file="common/header.jsp" %>
<div class="max-w-4xl mx-auto space-y-6 animate__animated animate__fadeIn">
    <div class="flex items-center justify-between">
        <div>
            <h2 class="text-2xl font-display font-bold text-primary">Support Queries</h2>
            <p class="text-secondary text-sm">Need help? Send us a message.</p>
        </div>
        <button onclick="toggleModal('newQueryModal')" class="px-5 py-2.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg text-sm flex items-center gap-2">
            <i class="fas fa-plus"></i> New Query
        </button>
    </div>

    <c:choose>
        <c:when test="${not empty queries}">
            <div class="space-y-4">
                <c:forEach var="q" items="${queries}">
                    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-6 hover:shadow-xl transition-shadow relative overflow-hidden">
                        <div class="absolute top-0 right-0 w-32 h-32 bg-gradient-to-bl from-primary/5 to-transparent rounded-bl-full pointer-events-none"></div>
                        
                        <div class="flex justify-between items-start mb-4">
                            <div>
                                <h3 class="font-bold text-primary text-lg">${q.subject}</h3>
                                <p class="text-xs text-secondary mt-1"><i class="far fa-clock mr-1"></i>${q.createdAt != null ? q.createdAt.toLocalDate() : 'N/A'}</p>
                            </div>
                            <span class="px-3 py-1 rounded-full text-xs font-bold ${q.status == 'ANSWERED' ? 'bg-green-100 text-green-700' : 'bg-amber-100 text-amber-700'}">
                                ${q.status}
                            </span>
                        </div>
                        
                        <div class="bg-base rounded-xl p-4 mb-4">
                            <p class="text-primary text-sm">${q.message}</p>
                        </div>

                        <!-- Replies Loop -->
                        <c:forEach var="reply" items="${q.replies}">
                            <div class="${reply.sender.role == 'ADMIN' ? 'bg-blue-50 border-blue-100 ml-8' : 'bg-white border-accent/30 mr-8'} rounded-xl p-4 border relative mb-4">
                                <p class="text-xs font-bold ${reply.sender.role == 'ADMIN' ? 'text-blue-600' : 'text-primary'} mb-1 flex items-center gap-1">
                                    <i class="fas ${reply.sender.role == 'ADMIN' ? 'fa-headset' : 'fa-user'}"></i> ${reply.sender.role == 'ADMIN' ? 'BookLeaf Support' : 'You'}
                                    <span class="text-[10px] text-secondary font-normal ml-auto">${reply.createdAt != null ? reply.createdAt.toLocalDate() : ''}</span>
                                </p>
                                <p class="text-sm text-primary leading-relaxed">${reply.message}</p>
                            </div>
                        </c:forEach>

                        <!-- Reply Form for Customer -->
                        <form action="/queries/reply" method="POST" class="mt-4 pt-4 border-t border-accent/20">
                            <input type="hidden" name="queryId" value="${q.id}">
                            <div class="flex gap-2">
                                <input type="text" name="reply" required placeholder="Type your reply here..."
                                       class="flex-1 bg-base border border-accent/30 rounded-xl px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary">
                                <button type="submit" class="px-6 py-2 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-md text-sm">Reply</button>
                            </div>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-20 bg-white rounded-3xl shadow-lg border border-accent/20">
                <i class="fas fa-envelope-open-text text-7xl text-accent mb-6"></i>
                <h3 class="text-2xl font-bold text-primary mb-2">No Queries Yet</h3>
                <p class="text-secondary">If you have any questions or issues, feel free to ask!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- New Query Modal -->
<div id="newQueryModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center">
    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-lg mx-4 p-8 animate__animated animate__zoomIn">
        <div class="flex justify-between items-center mb-6">
            <h3 class="text-xl font-bold text-primary"><i class="fas fa-paper-plane mr-2 text-secondary"></i>Submit a Query</h3>
            <button onclick="toggleModal('newQueryModal')" class="text-secondary hover:text-primary transition-colors">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>
        <form action="/queries/submit" method="POST" class="space-y-5">
            <div>
                <label class="block text-sm font-bold text-primary mb-2">Subject</label>
                <input type="text" name="subject" required placeholder="What is this regarding?"
                       class="w-full bg-base border border-accent/30 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-primary">
            </div>
            <div>
                <label class="block text-sm font-bold text-primary mb-2">Message</label>
                <textarea name="message" rows="5" required placeholder="Describe your question or issue in detail..."
                          class="w-full bg-base border border-accent/30 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-primary resize-none"></textarea>
            </div>
            <div class="flex gap-3 pt-2">
                <button type="button" onclick="toggleModal('newQueryModal')"
                        class="flex-1 py-3 border-2 border-accent/30 text-secondary font-bold rounded-xl hover:bg-base transition-all text-sm">Cancel</button>
                <button type="submit"
                        class="flex-1 py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg hover:shadow-primary/30 text-sm">Submit Query</button>
            </div>
        </form>
    </div>
</div>

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
<%@ include file="common/footer.jsp" %>
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
