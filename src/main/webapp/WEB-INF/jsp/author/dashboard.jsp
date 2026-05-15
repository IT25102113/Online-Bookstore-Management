<%@ include file="../common/header.jsp" %>
<div class="space-y-8 animate__animated animate__fadeIn">

    <!-- Author Stats -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-5">
        <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 bg-primary/10 rounded-xl flex items-center justify-center"><i class="fas fa-book text-primary text-xl"></i></div>
                <div><p class="text-2xl font-black text-primary">${totalBooks}</p><p class="text-xs text-secondary font-medium">My Books</p></div>
            </div>
        </div>
        <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 bg-secondary/10 rounded-xl flex items-center justify-center"><i class="fas fa-pen-fancy text-secondary text-xl"></i></div>
                <div><p class="text-2xl font-black text-primary">${author.name}</p><p class="text-xs text-secondary font-medium">Author Name</p></div>
            </div>
        </div>
        <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center"><i class="fas fa-check-circle text-green-600 text-xl"></i></div>
                <div><p class="text-2xl font-black text-primary">Active</p><p class="text-xs text-secondary font-medium">Account Status</p></div>
            </div>
        </div>
    </div>

    <!-- Author Profile Details -->
    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-6">
        <div class="flex items-center justify-between mb-4">
            <h3 class="font-bold text-primary flex items-center gap-2"><i class="fas fa-user-circle text-secondary"></i> My Profile</h3>
            <button onclick="toggleModal('editProfileModal')" class="px-4 py-2 bg-secondary/10 text-primary rounded-xl text-xs font-bold hover:bg-secondary/20 transition-all flex items-center gap-1"><i class="fas fa-edit"></i> Edit Profile</button>
        </div>
        <div class="flex items-start gap-6">
            <div class="w-20 h-20 rounded-2xl bg-gradient-to-br from-primary/10 to-secondary/10 flex items-center justify-center overflow-hidden flex-shrink-0">
                <c:choose>
                    <c:when test="${not empty author.imageUrl}"><img src="${author.imageUrl}" class="w-full h-full object-cover"></c:when>
                    <c:otherwise><i class="fas fa-pen-fancy text-3xl text-primary/30"></i></c:otherwise>
                </c:choose>
            </div>
            <div class="flex-1">
                <h4 class="text-lg font-bold text-primary">${author.name}</h4>
                <p class="text-xs text-secondary mt-1">${sessionScope.user.email}</p>
                <c:if test="${not empty author.bio}">
                    <p class="text-sm text-secondary/80 mt-3 bg-base rounded-xl p-3 italic">"${author.bio}"</p>
                </c:if>
                <c:if test="${empty author.bio}">
                    <p class="text-sm text-secondary/50 mt-3 italic">No bio added yet. Click "Edit Profile" to add one.</p>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Edit Profile Modal -->
    <div id="editProfileModal" class="hidden fixed inset-0 bg-black/50 z-50 items-center justify-center p-4">
        <div class="bg-white rounded-3xl shadow-2xl w-full max-w-md max-h-[90vh] overflow-y-auto p-8 animate__animated animate__fadeIn">
            <div class="flex items-center justify-between mb-6">
                <h3 class="font-bold text-primary text-lg"><i class="fas fa-user-edit mr-2 text-secondary"></i>Edit Profile</h3>
                <button onclick="toggleModal('editProfileModal')" class="text-secondary hover:text-primary"><i class="fas fa-times text-xl"></i></button>
            </div>
            <form action="/author/profile/update" method="POST" class="space-y-4">
                <div>
                    <label class="block text-xs font-bold text-primary mb-1">Author Name *</label>
                    <input type="text" name="name" value="${author.name}" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary">
                </div>
                <div>
                    <label class="block text-xs font-bold text-primary mb-1">Bio</label>
                    <textarea name="bio" rows="4" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary resize-none" placeholder="Tell readers about yourself...">${author.bio}</textarea>
                </div>
                <div>
                    <label class="block text-xs font-bold text-primary mb-1">Profile Image URL</label>
                    <input type="text" name="imageUrl" value="${author.imageUrl}" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary" placeholder="https://...">
                </div>
                <div class="flex justify-end gap-3 pt-2">
                    <button type="button" onclick="toggleModal('editProfileModal')" class="px-4 py-2.5 border-2 border-accent/30 text-secondary font-bold rounded-xl hover:bg-base transition-all text-sm">Cancel</button>
                    <button type="submit" class="px-6 py-2.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all text-sm shadow-lg"><i class="fas fa-save mr-1"></i>Save Profile</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Add New Book -->
    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-6">
        <h3 class="font-bold text-primary mb-4 flex items-center gap-2"><i class="fas fa-plus-circle text-secondary"></i> Add New Book</h3>
        <form action="/author/books/add" method="POST" class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div><label class="block text-xs font-bold text-primary mb-1">Title *</label><input type="text" name="title" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary" placeholder="Book title"></div>
            <div><label class="block text-xs font-bold text-primary mb-1">ISBN</label><input type="text" name="isbn" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary" placeholder="978-0000000000"></div>
            <div><label class="block text-xs font-bold text-primary mb-1">Category</label><input type="text" name="category" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary" placeholder="e.g. Fiction, Non-Fiction"></div>
            <div><label class="block text-xs font-bold text-primary mb-1">Price (LKR) *</label><input type="number" name="price" step="0.01" min="0" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary" placeholder="29.99"></div>
            <div><label class="block text-xs font-bold text-primary mb-1">Quantity *</label><input type="number" name="quantity" min="0" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary" placeholder="50"></div>
            <div><label class="block text-xs font-bold text-primary mb-1">Image URL</label><input type="text" name="imageUrl" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary" placeholder="https://..."></div>
            <div class="md:col-span-2"><label class="block text-xs font-bold text-primary mb-1">Description</label><textarea name="description" rows="3" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary resize-none" placeholder="Book description..."></textarea></div>
            <div class="flex items-center gap-2">
                <input type="checkbox" name="hasEbook" value="true" id="hasEbookAdd" class="w-4 h-4 accent-primary">
                <label for="hasEbookAdd" class="text-sm text-primary font-medium">E-Book Available</label>
            </div>
            <div class="md:col-span-2 flex justify-end">
                <button type="submit" class="px-6 py-2.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg text-sm flex items-center gap-2"><i class="fas fa-plus"></i> Add Book</button>
            </div>
        </form>
    </div>

    <!-- My Books List -->
    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-6">
        <h3 class="font-bold text-primary mb-4 flex items-center gap-2"><i class="fas fa-book text-secondary"></i> My Books</h3>
        <c:choose>
            <c:when test="${not empty books}">
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                            <tr class="border-b-2 border-accent/20">
                                <th class="text-left py-3 px-4 text-xs font-bold text-secondary uppercase">Book</th>
                                <th class="text-left py-3 px-4 text-xs font-bold text-secondary uppercase">Category</th>
                                <th class="text-left py-3 px-4 text-xs font-bold text-secondary uppercase">Price</th>
                                <th class="text-left py-3 px-4 text-xs font-bold text-secondary uppercase">Stock</th>
                                <th class="text-left py-3 px-4 text-xs font-bold text-secondary uppercase">E-Book</th>
                                <th class="text-right py-3 px-4 text-xs font-bold text-secondary uppercase">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${books}">
                                <tr class="border-b border-accent/10 hover:bg-base/50 transition-colors">
                                    <td class="py-3 px-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-10 h-14 bg-gradient-to-br from-primary/5 to-secondary/5 rounded-lg flex items-center justify-center overflow-hidden flex-shrink-0">
                                                <c:choose>
                                                    <c:when test="${not empty book.imageUrl}"><img src="${book.imageUrl}" class="w-full h-full object-cover"></c:when>
                                                    <c:otherwise><i class="fas fa-book text-primary/20"></i></c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <p class="font-bold text-sm text-primary">${book.title}</p>
                                                <p class="text-[10px] text-secondary">${book.isbn != null ? book.isbn : 'No ISBN'}</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-3 px-4"><span class="text-xs bg-primary/10 text-primary px-2 py-1 rounded-full font-medium">${book.category != null ? book.category : 'N/A'}</span></td>
                                    <td class="py-3 px-4 font-bold text-primary">LKR ${book.price}</td>
                                    <td class="py-3 px-4"><span class="text-sm ${book.quantity > 0 ? 'text-green-600' : 'text-red-500'} font-bold">${book.quantity}</span></td>
                                    <td class="py-3 px-4"><span class="text-xs ${book.hasEbook ? 'text-green-600 bg-green-50' : 'text-secondary bg-accent/20'} px-2 py-1 rounded-full font-medium">${book.hasEbook ? 'Yes' : 'No'}</span></td>
                                    <td class="py-3 px-4 text-right">
                                        <button onclick="toggleModal('editBookModal${book.id}')" class="px-3 py-1.5 bg-secondary/10 text-primary rounded-lg text-xs font-bold hover:bg-secondary/20 transition-all mr-1"><i class="fas fa-edit"></i></button>
                                        <form action="/author/books/delete/${book.id}" method="POST" class="inline" onsubmit="return confirm('Delete this book?')">
                                            <button type="submit" class="px-3 py-1.5 bg-red-50 text-red-500 rounded-lg text-xs font-bold hover:bg-red-100 transition-all"><i class="fas fa-trash"></i></button>
                                        </form>
                                    </td>
                                </tr>

                                <!-- Edit Modal -->
                                <div id="editBookModal${book.id}" class="hidden fixed inset-0 bg-black/50 z-50 items-center justify-center p-4">
                                    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto p-8 animate__animated animate__fadeIn">
                                        <div class="flex items-center justify-between mb-6">
                                            <h3 class="font-bold text-primary text-lg">Edit Book</h3>
                                            <button onclick="toggleModal('editBookModal${book.id}')" class="text-secondary hover:text-primary"><i class="fas fa-times text-xl"></i></button>
                                        </div>
                                        <form action="/author/books/update" method="POST" class="space-y-4">
                                            <input type="hidden" name="id" value="${book.id}">
                                            <div><label class="block text-xs font-bold text-primary mb-1">Title</label><input type="text" name="title" value="${book.title}" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                            <div class="grid grid-cols-2 gap-3">
                                                <div><label class="block text-xs font-bold text-primary mb-1">ISBN</label><input type="text" name="isbn" value="${book.isbn}" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                                <div><label class="block text-xs font-bold text-primary mb-1">Category</label><input type="text" name="category" value="${book.category}" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                            </div>
                                            <div class="grid grid-cols-2 gap-3">
                                                <div><label class="block text-xs font-bold text-primary mb-1">Price (LKR)</label><input type="number" name="price" step="0.01" value="${book.price}" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                                <div><label class="block text-xs font-bold text-primary mb-1">Quantity</label><input type="number" name="quantity" value="${book.quantity}" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                            </div>
                                            <div><label class="block text-xs font-bold text-primary mb-1">Image URL</label><input type="text" name="imageUrl" value="${book.imageUrl}" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                            <div><label class="block text-xs font-bold text-primary mb-1">Description</label><textarea name="description" rows="3" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary resize-none">${book.description}</textarea></div>
                                            <div class="flex items-center gap-2"><input type="checkbox" name="hasEbook" value="true" ${book.hasEbook ? 'checked' : ''} id="editEbook${book.id}" class="w-4 h-4 accent-primary"><label for="editEbook${book.id}" class="text-sm text-primary">E-Book Available</label></div>
                                            <div class="flex justify-end gap-3">
                                                <button type="button" onclick="toggleModal('editBookModal${book.id}')" class="px-4 py-2 text-secondary text-sm font-medium">Cancel</button>
                                                <button type="submit" class="px-6 py-2.5 bg-primary text-white font-bold rounded-xl text-sm hover:bg-dark transition-all"><i class="fas fa-save mr-1"></i>Save Changes</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-12">
                    <i class="fas fa-book-open text-5xl text-accent mb-4"></i>
                    <h4 class="text-lg font-bold text-primary mb-2">No Books Yet</h4>
                    <p class="text-secondary text-sm">Start adding your books using the form above!</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>
