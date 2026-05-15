<%@ include file="common/header.jsp" %>
<div class="max-w-3xl mx-auto animate__animated animate__fadeIn">
    <div class="bg-white rounded-3xl shadow-2xl border border-accent/20 overflow-hidden">
        <div class="h-40 bg-gradient-to-br from-primary to-dark relative">
            <div class="absolute bottom-0 left-8 translate-y-1/2"><div class="w-24 h-24 rounded-2xl bg-secondary/30 border-4 border-white shadow-xl flex items-center justify-center text-white text-3xl font-bold">${sessionScope.user.fullName.substring(0,1)}</div></div>
        </div>
        <div class="pt-16 pb-8 px-8">
            <div class="flex justify-between items-start mb-8">
                <div><h2 class="text-2xl font-bold text-primary">${sessionScope.user.fullName}</h2><p class="text-secondary text-sm">${sessionScope.user.email}</p><span class="inline-block mt-2 text-xs font-bold px-3 py-1 rounded-full bg-secondary/10 text-secondary uppercase">${sessionScope.user.role}</span></div>
                <c:if test="${sessionScope.user.role == 'CUSTOMER'}"><button onclick="toggleModal('editModal')" class="px-5 py-2 border-2 border-primary text-primary font-bold rounded-xl hover:bg-primary hover:text-white transition-all text-sm"><i class="fas fa-edit mr-1"></i>Edit</button></c:if>
            </div>
            <div class="grid md:grid-cols-2 gap-4">
                <div class="bg-base rounded-2xl p-4"><p class="text-xs text-secondary font-bold uppercase mb-1">Phone</p><p class="text-primary font-medium">${sessionScope.user.phone != null ? sessionScope.user.phone : 'Not set'}</p></div>
                <div class="bg-base rounded-2xl p-4"><p class="text-xs text-secondary font-bold uppercase mb-1">Address</p><p class="text-primary font-medium">${sessionScope.user.address != null ? sessionScope.user.address : 'Not set'}</p></div>
                <div class="bg-base rounded-2xl p-4"><p class="text-xs text-secondary font-bold uppercase mb-1">Member Since</p><p class="text-primary font-medium">${sessionScope.user.createdAt != null ? sessionScope.user.createdAt.toLocalDate() : 'N/A'}</p></div>
            </div>
            <c:if test="${sessionScope.user.role == 'CUSTOMER'}">
                <div class="mt-6 flex gap-3">
                    <a href="/my-orders" class="px-5 py-2.5 bg-primary text-white font-bold rounded-xl text-sm hover:bg-dark transition-all"><i class="fas fa-receipt mr-2"></i>View Orders</a>
                    <a href="/cart" class="px-5 py-2.5 border-2 border-primary text-primary font-bold rounded-xl text-sm hover:bg-primary hover:text-white transition-all"><i class="fas fa-shopping-cart mr-2"></i>My Cart</a>
                </div>
            </c:if>
        </div>
    </div>
</div>
<div id="editModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center">
    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-md mx-4 p-8 animate__animated animate__zoomIn">
        <div class="flex justify-between items-center mb-6"><h3 class="text-xl font-bold text-primary">Edit Profile</h3><button onclick="toggleModal('editModal')" class="text-secondary hover:text-primary"><i class="fas fa-times text-xl"></i></button></div>
        <form action="/profile/update" method="POST" class="space-y-4">
            <div><label class="block text-sm font-bold text-primary mb-1.5">Full Name</label><input type="text" name="fullName" value="${sessionScope.user.fullName}" required class="w-full px-4 py-3 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <div><label class="block text-sm font-bold text-primary mb-1.5">Email</label><input type="email" name="email" value="${sessionScope.user.email}" required class="w-full px-4 py-3 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <div><label class="block text-sm font-bold text-primary mb-1.5">Phone</label><input type="text" name="phone" value="${sessionScope.user.phone}" class="w-full px-4 py-3 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <div><label class="block text-sm font-bold text-primary mb-1.5">Address</label><input type="text" name="address" value="${sessionScope.user.address}" class="w-full px-4 py-3 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <button type="submit" class="w-full py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all text-sm"><i class="fas fa-save mr-2"></i>Save Changes</button>
        </form>
    </div>
</div>
<%@ include file="common/footer.jsp" %>
