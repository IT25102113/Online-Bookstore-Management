<%@ include file="../common/header.jsp" %>
<div class="space-y-8 animate__animated animate__fadeIn">
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-5">
        <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover"><div class="flex items-center gap-4"><div class="w-12 h-12 bg-primary/10 rounded-xl flex items-center justify-center"><i class="fas fa-book text-primary text-xl"></i></div><div><p class="text-2xl font-black text-primary">${totalBooks}</p><p class="text-xs text-secondary font-medium">Total Books</p></div></div></div>
        <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover"><div class="flex items-center gap-4"><div class="w-12 h-12 bg-secondary/10 rounded-xl flex items-center justify-center"><i class="fas fa-users text-secondary text-xl"></i></div><div><p class="text-2xl font-black text-primary">${totalUsers}</p><p class="text-xs text-secondary font-medium">Total Users</p></div></div></div>
        <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover"><div class="flex items-center gap-4"><div class="w-12 h-12 bg-accent/30 rounded-xl flex items-center justify-center"><i class="fas fa-shopping-bag text-primary text-xl"></i></div><div><p class="text-2xl font-black text-primary">${totalOrders}</p><p class="text-xs text-secondary font-medium">Total Orders</p></div></div></div>
        <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover relative group">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center"><i class="fas fa-dollar-sign text-green-600 text-xl"></i></div>
                <div><p class="text-2xl font-black text-primary">LKR ${totalRevenue}</p><p class="text-xs text-secondary font-medium">Revenue</p></div>
            </div>
            <form action="/admin/dashboard/reset-revenue" method="POST" class="absolute top-2 right-2 hidden group-hover:block">
                <button type="submit" class="bg-red-100 text-red-600 hover:bg-red-200 text-[10px] font-bold px-2 py-1 rounded transition-colors" title="Reset Revenue" onclick="return confirm('Are you sure you want to reset the revenue to $0? This will only reset the display on the dashboard.')">
                    <i class="fas fa-undo"></i> Reset
                </button>
            </form>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-5">
        <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover"><div class="flex items-center gap-4"><div class="w-12 h-12 bg-amber-100 rounded-xl flex items-center justify-center"><i class="fas fa-star text-amber-500 text-xl"></i></div><div><p class="text-2xl font-black text-primary">${totalReviews}</p><p class="text-xs text-secondary font-medium">Reviews</p></div></div></div>
        <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover ${pendingAuthors > 0 ? 'border-amber-300 bg-amber-50/30' : ''}"><div class="flex items-center gap-4"><div class="w-12 h-12 ${pendingAuthors > 0 ? 'bg-amber-100' : 'bg-primary/10'} rounded-xl flex items-center justify-center"><i class="fas fa-user-clock ${pendingAuthors > 0 ? 'text-amber-500' : 'text-primary'} text-xl"></i></div><div><p class="text-2xl font-black ${pendingAuthors > 0 ? 'text-amber-600' : 'text-primary'}">${pendingAuthors}</p><p class="text-xs ${pendingAuthors > 0 ? 'text-amber-600' : 'text-secondary'} font-medium">Pending Authors</p></div></div></div>
        <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover"><div class="flex items-center gap-4"><div class="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center"><i class="fas fa-tags text-purple-500 text-xl"></i></div><div><p class="text-2xl font-black text-primary">${activeDiscounts}</p><p class="text-xs text-secondary font-medium">Active Discounts</p></div></div></div>
    </div>

    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-6">
        <h3 class="font-bold text-primary mb-4">Quick Actions</h3>
        <div class="grid grid-cols-2 md:grid-cols-6 gap-4">
            <a href="/admin/books" class="p-4 bg-base rounded-xl text-center hover:shadow-lg transition-all hover:-translate-y-1"><i class="fas fa-plus-circle text-2xl text-primary mb-2"></i><p class="text-sm font-bold text-primary">Books</p></a>
            <a href="/admin/orders" class="p-4 bg-base rounded-xl text-center hover:shadow-lg transition-all hover:-translate-y-1"><i class="fas fa-box-open text-2xl text-orange-500 mb-2"></i><p class="text-sm font-bold text-primary">Orders</p></a>
            <a href="/admin/authors" class="p-4 bg-base rounded-xl text-center hover:shadow-lg transition-all hover:-translate-y-1"><i class="fas fa-pen-fancy text-2xl text-secondary mb-2"></i><p class="text-sm font-bold text-primary">Authors</p></a>
            <a href="/admin/users" class="p-4 bg-base rounded-xl text-center hover:shadow-lg transition-all hover:-translate-y-1 relative"><i class="fas fa-users-cog text-2xl text-primary mb-2"></i><p class="text-sm font-bold text-primary">Users</p><c:if test="${pendingAuthors > 0}"><span class="absolute top-2 right-2 bg-amber-400 text-primary text-[10px] font-bold w-5 h-5 rounded-full flex items-center justify-center badge-pulse">${pendingAuthors}</span></c:if></a>
            <a href="/admin/reviews" class="p-4 bg-base rounded-xl text-center hover:shadow-lg transition-all hover:-translate-y-1"><i class="fas fa-star-half-alt text-2xl text-amber-500 mb-2"></i><p class="text-sm font-bold text-primary">Reviews</p></a>
            <a href="/admin/discounts" class="p-4 bg-base rounded-xl text-center hover:shadow-lg transition-all hover:-translate-y-1"><i class="fas fa-tags text-2xl text-purple-500 mb-2"></i><p class="text-sm font-bold text-primary">Discounts</p></a>
        </div>
    </div>
    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-6 mt-8">
        <h3 class="font-bold text-primary mb-4">Data Management (Servlets)</h3>
        <p class="text-sm text-secondary mb-4">Download system database files generated by File Read/Write service.</p>
        <div class="grid grid-cols-2 md:grid-cols-6 gap-4">
            <a href="/api/data/download?type=users" class="p-3 bg-blue-50 border border-blue-100 rounded-xl text-center hover:bg-blue-100 transition-all"><i class="fas fa-file-download text-blue-500 mb-2"></i><p class="text-xs font-bold text-primary">users.txt</p></a>
            <a href="/api/data/download?type=books" class="p-3 bg-green-50 border border-green-100 rounded-xl text-center hover:bg-green-100 transition-all"><i class="fas fa-file-download text-green-500 mb-2"></i><p class="text-xs font-bold text-primary">books.txt</p></a>
            <a href="/api/data/download?type=authors" class="p-3 bg-purple-50 border border-purple-100 rounded-xl text-center hover:bg-purple-100 transition-all"><i class="fas fa-file-download text-purple-500 mb-2"></i><p class="text-xs font-bold text-primary">authors.txt</p></a>
            <a href="/api/data/download?type=orders" class="p-3 bg-amber-50 border border-amber-100 rounded-xl text-center hover:bg-amber-100 transition-all"><i class="fas fa-file-download text-amber-500 mb-2"></i><p class="text-xs font-bold text-primary">orders.txt</p></a>
            <a href="/api/data/download?type=reviews" class="p-3 bg-pink-50 border border-pink-100 rounded-xl text-center hover:bg-pink-100 transition-all"><i class="fas fa-file-download text-pink-500 mb-2"></i><p class="text-xs font-bold text-primary">reviews.txt</p></a>
            <a href="/api/data/download?type=discounts" class="p-3 bg-indigo-50 border border-indigo-100 rounded-xl text-center hover:bg-indigo-100 transition-all"><i class="fas fa-file-download text-indigo-500 mb-2"></i><p class="text-xs font-bold text-primary">discounts.txt</p></a>
        </div>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
