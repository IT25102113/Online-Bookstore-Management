<%@ include file="../common/header.jsp" %>
<div class="space-y-6 animate__animated animate__fadeIn">

    <!-- Pending Author Approvals Section -->
    <c:if test="${not empty pendingAuthorsList}">
    <div class="bg-amber-50 rounded-2xl shadow-lg border-2 border-amber-200 p-6">
        <div class="flex items-center gap-3 mb-4">
            <div class="w-10 h-10 bg-amber-100 rounded-xl flex items-center justify-center">
                <i class="fas fa-user-clock text-amber-500 text-lg"></i>
            </div>
            <div>
                <h3 class="font-bold text-amber-700">Pending Author Approvals</h3>
                <p class="text-amber-600 text-xs">${pendingAuthorsList.size()} author(s) waiting for approval</p>
            </div>
        </div>
        <div class="space-y-3">
            <c:forEach var="author" items="${pendingAuthorsList}">
                <div class="bg-white rounded-xl p-4 border border-amber-200 flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-sm">${author.fullName.substring(0,1)}</div>
                        <div>
                            <p class="font-bold text-primary text-sm">${author.fullName}</p>
                            <p class="text-xs text-secondary">${author.email}</p>
                            <c:if test="${author.authorProfile != null && author.authorProfile.bio != null}">
                                <p class="text-xs text-secondary/70 mt-1 italic">"${author.authorProfile.bio}"</p>
                            </c:if>
                        </div>
                    </div>
                    <div class="flex items-center gap-2">
                        <form action="/admin/users/approve/${author.id}" method="POST" class="inline">
                            <button type="submit" class="px-4 py-2 bg-green-500 text-white font-bold rounded-xl text-xs hover:bg-green-600 transition-all flex items-center gap-1 shadow-lg">
                                <i class="fas fa-check"></i> Approve
                            </button>
                        </form>
                        <form action="/admin/users/reject/${author.id}" method="POST" class="inline" onsubmit="return confirm('Reject and delete this author registration?')">
                            <button type="submit" class="px-4 py-2 bg-red-500 text-white font-bold rounded-xl text-xs hover:bg-red-600 transition-all flex items-center gap-1 shadow-lg">
                                <i class="fas fa-times"></i> Reject
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    </c:if>

    <!-- Users Table -->
    <div><h2 class="text-2xl font-display font-bold text-primary">Manage Users</h2><p class="text-secondary text-sm">${users.size()} registered users</p></div>
    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-base">
                    <tr>
                        <th class="p-4 text-left text-xs font-bold text-primary uppercase">User</th>
                        <th class="p-4 text-left text-xs font-bold text-primary uppercase">Email</th>
                        <th class="p-4 text-left text-xs font-bold text-primary uppercase">Role</th>
                        <th class="p-4 text-left text-xs font-bold text-primary uppercase">Status</th>
                        <th class="p-4 text-left text-xs font-bold text-primary uppercase">Phone</th>
                        <th class="p-4 text-left text-xs font-bold text-primary uppercase">Joined</th>
                        <th class="p-4 text-center text-xs font-bold text-primary uppercase">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-accent/10">
                    <c:forEach var="u" items="${users}">
                        <tr class="hover:bg-base/50 transition-all">
                            <td class="p-4">
                                <div class="flex items-center gap-3">
                                    <div class="w-9 h-9 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-sm">${u.fullName.substring(0,1)}</div>
                                    <span class="font-bold text-primary text-sm">${u.fullName}</span>
                                </div>
                            </td>
                            <td class="p-4 text-sm text-secondary">${u.email}</td>
                            <td class="p-4">
                                <c:choose>
                                    <c:when test="${u.role == 'ADMIN'}"><span class="text-xs font-bold px-2 py-1 rounded-full bg-red-100 text-red-700">ADMIN</span></c:when>
                                    <c:when test="${u.role == 'AUTHOR'}"><span class="text-xs font-bold px-2 py-1 rounded-full bg-purple-100 text-purple-700">AUTHOR</span></c:when>
                                    <c:otherwise><span class="text-xs font-bold px-2 py-1 rounded-full bg-green-100 text-green-700">CUSTOMER</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="p-4">
                                <c:choose>
                                    <c:when test="${u.approved}"><span class="text-xs font-bold px-2 py-1 rounded-full bg-green-50 text-green-600"><i class="fas fa-check-circle mr-1"></i>Active</span></c:when>
                                    <c:otherwise><span class="text-xs font-bold px-2 py-1 rounded-full bg-amber-50 text-amber-600"><i class="fas fa-clock mr-1"></i>Pending</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="p-4 text-sm text-secondary">${u.phone != null ? u.phone : 'N/A'}</td>
                            <td class="p-4 text-sm text-secondary">${u.createdAt != null ? u.createdAt.toLocalDate() : 'N/A'}</td>
                            <td class="p-4 text-center">
                                <div class="flex items-center justify-center gap-1">
                                    <button onclick="editUser('${u.id}','${u.fullName}','${u.email}','${u.phone}','${u.address}')"
                                            class="p-2 text-primary hover:bg-base rounded-lg transition-all" title="Edit User">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form action="/admin/users/delete/${u.id}" method="POST" class="inline" onsubmit="return confirm('Are you sure you want to delete user ${u.fullName}? This action cannot be undone.')">
                                        <button class="p-2 text-red-400 hover:bg-red-50 rounded-lg transition-all" title="Delete User">
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
        <c:if test="${empty users}">
            <div class="text-center py-16">
                <i class="fas fa-users text-5xl text-accent mb-4"></i>
                <p class="text-secondary text-sm">No registered users yet.</p>
            </div>
        </c:if>
    </div>
</div>

<div id="editUserModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center">
    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-md mx-4 p-8 animate__animated animate__zoomIn">
        <div class="flex justify-between items-center mb-6">
            <h3 class="text-xl font-bold text-primary"><i class="fas fa-user-edit mr-2 text-secondary"></i>Edit User</h3>
            <button onclick="toggleModal('editUserModal')" class="text-secondary hover:text-primary transition-colors">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>
        <form action="/admin/users/update" method="POST" class="space-y-4">
            <input type="hidden" name="id" id="euId">
            <div>
                <label class="block text-sm font-bold text-primary mb-1.5">
                    <i class="fas fa-user mr-1 text-secondary text-xs"></i> Full Name *
                </label>
                <input type="text" name="fullName" id="euName" required
                       class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm text-primary focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all">
            </div>
            <div>
                <label class="block text-sm font-bold text-primary mb-1.5">
                    <i class="fas fa-envelope mr-1 text-secondary text-xs"></i> Email *
                </label>
                <input type="email" name="email" id="euEmail" required
                       class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm text-primary focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all">
            </div>
            <div>
                <label class="block text-sm font-bold text-primary mb-1.5">
                    <i class="fas fa-phone mr-1 text-secondary text-xs"></i> Phone
                </label>
                <input type="text" name="phone" id="euPhone"
                       class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm text-primary focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all">
            </div>
            <div>
                <label class="block text-sm font-bold text-primary mb-1.5">
                    <i class="fas fa-map-marker-alt mr-1 text-secondary text-xs"></i> Address
                </label>
                <input type="text" name="address" id="euAddress"
                       class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm text-primary focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition-all">
            </div>
            <div class="flex gap-3 pt-2">
                <button type="button" onclick="toggleModal('editUserModal')"
                        class="flex-1 py-2.5 border-2 border-accent/30 text-secondary font-bold rounded-xl hover:bg-base transition-all text-sm">
                    Cancel
                </button>
                <button type="submit"
                        class="flex-1 py-2.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all text-sm shadow-lg shadow-primary/20">
                    <i class="fas fa-save mr-2"></i>Save Changes
                </button>
            </div>
        </form>
    </div>
</div>

<script>
function editUser(id, name, email, phone, address) {
    document.getElementById('euId').value = id;
    document.getElementById('euName').value = name || '';
    document.getElementById('euEmail').value = email || '';
    document.getElementById('euPhone').value = (phone && phone !== 'null') ? phone : '';
    document.getElementById('euAddress').value = (address && address !== 'null') ? address : '';
    toggleModal('editUserModal');
}
</script>
<%@ include file="../common/footer.jsp" %>
