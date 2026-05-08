<%@ include file="../common/header.jsp" %>
<div class="space-y-6 animate__animated animate__fadeIn">
    <div class="flex items-center justify-between">
        <div>
            <h2 class="text-2xl font-display font-bold text-primary">Manage Reviews</h2>
            <p class="text-secondary text-sm">${reviews.size()} reviews total</p>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty reviews}">
            <div class="bg-white rounded-2xl shadow-lg border border-accent/20 overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead class="bg-base">
                            <tr>
                                <th class="p-4 text-left text-xs font-bold text-primary uppercase">User</th>
                                <th class="p-4 text-left text-xs font-bold text-primary uppercase">Book</th>
                                <th class="p-4 text-left text-xs font-bold text-primary uppercase">Rating</th>
                                <th class="p-4 text-left text-xs font-bold text-primary uppercase">Comment</th>
                                <th class="p-4 text-left text-xs font-bold text-primary uppercase">Date</th>
                                <th class="p-4 text-center text-xs font-bold text-primary uppercase">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-accent/10">
                            <c:forEach var="r" items="${reviews}">
                                <tr class="hover:bg-base/50 transition-all">
                                    <td class="p-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-xs">${r.user.fullName.substring(0,1)}</div>
                                            <span class="text-sm font-bold text-primary">${r.user.fullName}</span>
                                        </div>
                                    </td>
                                    <td class="p-4">
                                        <a href="/book/${r.book.id}" class="text-sm text-secondary hover:text-primary hover:underline transition-all">${r.book.title}</a>
                                    </td>
                                    <td class="p-4">
                                        <div class="flex items-center gap-1">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="fas fa-star ${i <= r.rating ? 'text-amber-400' : 'text-accent/40'} text-xs"></i>
                                            </c:forEach>
                                            <span class="text-xs text-secondary ml-1 font-bold">${r.rating}/5</span>
                                        </div>
                                    </td>
                                    <td class="p-4">
                                        <p class="text-sm text-secondary max-w-xs">${r.comment != null && r.comment.length() > 80 ? r.comment.substring(0, 80).concat('...') : r.comment}</p>
                                    </td>
                                    <td class="p-4 text-xs text-secondary">${r.createdAt != null ? r.createdAt.toLocalDate() : 'N/A'}</td>
                                    <td class="p-4 text-center">
                                        <div class="flex items-center justify-center gap-1">
                                            <!-- View Full Review -->
                                            <button onclick="viewReview(this)"
                                                    data-user="${r.user.fullName}"
                                                    data-book="${r.book.title}"
                                                    data-rating="${r.rating}"
                                                    data-comment="${r.comment}"
                                                    data-date="${r.createdAt != null ? r.createdAt.toLocalDate() : 'N/A'}"
                                                    data-reply="${r.adminReply}"
                                                    class="p-2 text-secondary hover:bg-base rounded-lg transition-all" title="View Full Review">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <!-- Reply to Review -->
                                            <button onclick="openReplyModal(this)"
                                                    data-id="${r.id}"
                                                    data-user="${r.user.fullName}"
                                                    data-reply="${r.adminReply}"
                                                    class="p-2 text-blue-400 hover:bg-blue-50 rounded-lg transition-all" title="Reply to Review">
                                                <i class="fas fa-reply"></i>
                                            </button>
                                            <!-- Delete Review -->
                                            <form action="/admin/reviews/delete/${r.id}" method="POST" class="inline"
                                                  onsubmit="return confirm('Are you sure you want to delete this review by ${r.user.fullName}? This action cannot be undone.')">
                                                <button type="submit" class="p-2 text-red-400 hover:bg-red-50 rounded-lg transition-all" title="Delete Review">
                                                    <i class="fas fa-trash-alt"></i>
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
                <i class="fas fa-star-half-alt text-7xl text-accent mb-6"></i>
                <h3 class="text-2xl font-bold text-primary mb-2">No Reviews Yet</h3>
                <p class="text-secondary">Customer reviews will appear here once they start reviewing books.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>


<div id="viewReviewModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center">
    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-md mx-4 p-8 animate__animated animate__zoomIn">
        <div class="flex justify-between items-center mb-6">
            <h3 class="text-xl font-bold text-primary"><i class="fas fa-star mr-2 text-amber-400"></i>Review Details</h3>
            <button onclick="toggleModal('viewReviewModal')" class="text-secondary hover:text-primary transition-colors">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>
        <div class="space-y-4">
            <div class="bg-base rounded-xl p-4">
                <p class="text-xs text-secondary font-bold uppercase mb-1">Reviewer</p>
                <p class="text-primary font-bold" id="vrUser"></p>
            </div>
            <div class="bg-base rounded-xl p-4">
                <p class="text-xs text-secondary font-bold uppercase mb-1">Book</p>
                <p class="text-primary font-bold" id="vrBook"></p>
            </div>
            <div class="bg-base rounded-xl p-4">
                <p class="text-xs text-secondary font-bold uppercase mb-1">Rating</p>
                <div class="flex items-center gap-1 mt-1" id="vrStars"></div>
            </div>
            <div class="bg-base rounded-xl p-4">
                <p class="text-xs text-secondary font-bold uppercase mb-1">Comment</p>
                <p class="text-primary text-sm leading-relaxed" id="vrComment"></p>
            </div>
            <div class="bg-base rounded-xl p-4">
                <p class="text-xs text-secondary font-bold uppercase mb-1">Date</p>
                <p class="text-primary text-sm" id="vrDate"></p>
            </div>
            <div class="bg-blue-50 rounded-xl p-4 hidden" id="vrReplyContainer">
                <p class="text-xs text-blue-600 font-bold uppercase mb-1">Admin Reply</p>
                <p class="text-primary text-sm leading-relaxed" id="vrReply"></p>
            </div>
        </div>
        <button onclick="toggleModal('viewReviewModal')"
                class="mt-6 w-full py-2.5 border-2 border-accent/30 text-secondary font-bold rounded-xl hover:bg-base transition-all text-sm">
            Close
        </button>
    </div>
</div>

<div id="replyReviewModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center">
    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-md mx-4 p-8 animate__animated animate__zoomIn">
        <div class="flex justify-between items-center mb-6">
            <h3 class="text-xl font-bold text-primary"><i class="fas fa-reply mr-2 text-blue-400"></i>Reply to Review</h3>
            <button onclick="toggleModal('replyReviewModal')" class="text-secondary hover:text-primary transition-colors">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>
        <form action="/admin/reviews/reply" method="POST" class="space-y-4">
            <input type="hidden" name="reviewId" id="replyReviewId">
            <div>
                <label class="block text-sm font-bold text-primary mb-2">Reply to <span id="replyUserName"></span></label>
                <textarea name="reply" id="replyTextarea" rows="4" required placeholder="Type your response here..."
                          class="w-full bg-base border border-accent/30 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-primary"></textarea>
            </div>
            <div class="flex gap-3">
                <button type="button" onclick="toggleModal('replyReviewModal')"
                        class="flex-1 py-2.5 border-2 border-accent/30 text-secondary font-bold rounded-xl hover:bg-base transition-all text-sm">Cancel</button>
                <button type="submit"
                        class="flex-1 py-2.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg hover:shadow-primary/30 text-sm">Submit Reply</button>
            </div>
        </form>
    </div>
</div>

<script>
function viewReview(btn) {
    const user = btn.getAttribute('data-user');
    const book = btn.getAttribute('data-book');
    const rating = parseInt(btn.getAttribute('data-rating'));
    const comment = btn.getAttribute('data-comment');
    const date = btn.getAttribute('data-date');
    const reply = btn.getAttribute('data-reply');

    document.getElementById('vrUser').textContent = user;
    document.getElementById('vrBook').textContent = book;
    document.getElementById('vrComment').textContent = (comment && comment !== 'null') ? comment : 'No comment provided';
    document.getElementById('vrDate').textContent = date;

    let starsHtml = '';
    for (let i = 1; i <= 5; i++) {
        starsHtml += '<i class="fas fa-star ' + (i <= rating ? 'text-amber-400' : 'text-accent/40') + ' text-lg"></i>';
    }
    starsHtml += '<span class="text-sm text-primary font-bold ml-2">' + rating + '/5</span>';
    document.getElementById('vrStars').innerHTML = starsHtml;

    const replyContainer = document.getElementById('vrReplyContainer');
    if (reply && reply !== 'null' && reply !== '') {
        document.getElementById('vrReply').textContent = reply;
        replyContainer.classList.remove('hidden');
    } else {
        replyContainer.classList.add('hidden');
    }

    toggleModal('viewReviewModal');
}

function openReplyModal(btn) {
    const id = btn.getAttribute('data-id');
    const user = btn.getAttribute('data-user');
    const currentReply = btn.getAttribute('data-reply');

    document.getElementById('replyReviewId').value = id;
    document.getElementById('replyUserName').textContent = user;
    document.getElementById('replyTextarea').value = (currentReply && currentReply !== 'null') ? currentReply : '';
    toggleModal('replyReviewModal');
}
</script>
<%@ include file="../common/footer.jsp" %>
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
