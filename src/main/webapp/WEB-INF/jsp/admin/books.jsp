<%@ include file="../common/header.jsp" %>
<div class="space-y-6 animate__animated animate__fadeIn">
    <div class="flex justify-between items-center">
        <div><h2 class="text-2xl font-display font-bold text-primary">Manage Books</h2><p class="text-secondary text-sm">${books.size()} books in catalog</p></div>
        <button onclick="toggleModal('addBookModal')" class="px-5 py-2.5 bg-primary text-white font-bold rounded-xl text-sm hover:bg-dark transition-all shadow-lg"><i class="fas fa-plus mr-2"></i>Add Book</button>
    </div>
    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-base"><tr><th class="p-4 text-left text-xs font-bold text-primary uppercase">Book</th><th class="p-4 text-left text-xs font-bold text-primary uppercase">Category</th><th class="p-4 text-left text-xs font-bold text-primary uppercase">Price</th><th class="p-4 text-left text-xs font-bold text-primary uppercase">Stock</th><th class="p-4 text-left text-xs font-bold text-primary uppercase">E-Book</th><th class="p-4 text-center text-xs font-bold text-primary uppercase">Actions</th></tr></thead>
                <tbody class="divide-y divide-accent/10">
                    <c:forEach var="book" items="${books}">
                        <tr class="hover:bg-base/50 transition-all">
                            <td class="p-4"><div><p class="font-bold text-primary text-sm">${book.title}</p><p class="text-xs text-secondary">by ${book.author != null ? book.author.name : 'No Author'}</p></div></td>
                            <td class="p-4"><span class="text-xs bg-primary/10 text-primary px-2 py-1 rounded-full font-bold">${book.category}</span></td>
                            <td class="p-4 font-bold text-primary">LKR ${book.price}</td>
                            <td class="p-4"><span class="${book.quantity > 0 ? 'text-green-600' : 'text-red-500'} font-bold text-sm">${book.quantity}</span></td>
                            <td class="p-4"><span class="text-xs ${book.hasEbook ? 'text-green-600' : 'text-secondary'}">${book.hasEbook ? 'Yes' : 'No'}</span></td>
                            <td class="p-4 text-center">
                                <button onclick="editBook(${book.id},'${book.title}','${book.isbn}','${book.category}',${book.price},${book.quantity},'${book.imageUrl}',${book.author != null ? book.author.id : 'null'},${book.hasEbook},'${book.description}')" class="p-2 text-primary hover:bg-base rounded-lg"><i class="fas fa-edit"></i></button>
                                <form action="/admin/books/delete/${book.id}" method="POST" class="inline" onsubmit="return confirm('Delete this book?')"><button class="p-2 text-red-400 hover:bg-red-50 rounded-lg"><i class="fas fa-trash-alt"></i></button></form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div id="addBookModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center">
    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-lg mx-4 p-8 max-h-[90vh] overflow-y-auto animate__animated animate__zoomIn">
        <div class="flex justify-between items-center mb-6"><h3 class="text-xl font-bold text-primary">Add New Book</h3><button onclick="toggleModal('addBookModal')" class="text-secondary hover:text-primary"><i class="fas fa-times text-xl"></i></button></div>
        <form action="/admin/books/add" method="POST" class="space-y-4">
            <div><label class="block text-sm font-bold text-primary mb-1">Title *</label><input type="text" name="title" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <div class="grid grid-cols-2 gap-4">
                <div><label class="block text-sm font-bold text-primary mb-1">ISBN</label><input type="text" name="isbn" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
                <div><label class="block text-sm font-bold text-primary mb-1">Category</label><input type="text" name="category" placeholder="e.g. Fiction" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            </div>
            <div class="grid grid-cols-2 gap-4">
                <div><label class="block text-sm font-bold text-primary mb-1">Price (LKR) *</label><input type="number" name="price" step="0.01" min="0" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
                <div><label class="block text-sm font-bold text-primary mb-1">Quantity *</label><input type="number" name="quantity" min="0" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            </div>
            <div><label class="block text-sm font-bold text-primary mb-1">Author (Optional)</label><select name="authorId" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"><option value="">-- No Author --</option><c:forEach var="a" items="${authors}"><option value="${a.id}">${a.name}</option></c:forEach></select></div>
            <div><label class="block text-sm font-bold text-primary mb-1">Image URL</label><input type="url" name="imageUrl" placeholder="https://..." class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <div><label class="block text-sm font-bold text-primary mb-1">Description</label><textarea name="description" rows="3" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary resize-none"></textarea></div>
            <label class="flex items-center gap-2 cursor-pointer"><input type="checkbox" name="hasEbook" value="true" class="w-4 h-4 accent-primary"><span class="text-sm font-bold text-primary">E-Book version available</span></label>
            <button type="submit" class="w-full py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all text-sm"><i class="fas fa-save mr-2"></i>Add Book</button>
        </form>
    </div>
</div>
<div id="editBookModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center">
    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-lg mx-4 p-8 max-h-[90vh] overflow-y-auto animate__animated animate__zoomIn">
        <div class="flex justify-between items-center mb-6"><h3 class="text-xl font-bold text-primary">Edit Book</h3><button onclick="toggleModal('editBookModal')" class="text-secondary hover:text-primary"><i class="fas fa-times text-xl"></i></button></div>
        <form action="/admin/books/update" method="POST" class="space-y-4" id="editBookForm">
            <input type="hidden" name="id" id="editId">
            <div><label class="block text-sm font-bold text-primary mb-1">Title *</label><input type="text" name="title" id="editTitle" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <div class="grid grid-cols-2 gap-4">
                <div><label class="block text-sm font-bold text-primary mb-1">ISBN</label><input type="text" name="isbn" id="editIsbn" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
                <div><label class="block text-sm font-bold text-primary mb-1">Category</label><input type="text" name="category" id="editCategory" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            </div>
            <div class="grid grid-cols-2 gap-4">
                <div><label class="block text-sm font-bold text-primary mb-1">Price (LKR)</label><input type="number" name="price" id="editPrice" step="0.01" min="0" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
                <div><label class="block text-sm font-bold text-primary mb-1">Quantity</label><input type="number" name="quantity" id="editQuantity" min="0" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            </div>
            <div><label class="block text-sm font-bold text-primary mb-1">Author</label><select name="authorId" id="editAuthor" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"><option value="">-- No Author --</option><c:forEach var="a" items="${authors}"><option value="${a.id}">${a.name}</option></c:forEach></select></div>
            <div><label class="block text-sm font-bold text-primary mb-1">Image URL</label><input type="url" name="imageUrl" id="editImage" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <div><label class="block text-sm font-bold text-primary mb-1">Description</label><textarea name="description" id="editDesc" rows="3" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary resize-none"></textarea></div>
            <label class="flex items-center gap-2 cursor-pointer"><input type="checkbox" name="hasEbook" id="editEbook" value="true" class="w-4 h-4 accent-primary"><span class="text-sm font-bold text-primary">E-Book available</span></label>
            <button type="submit" class="w-full py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all text-sm"><i class="fas fa-save mr-2"></i>Update Book</button>
        </form>
    </div>
</div>
<script>
function editBook(id,title,isbn,cat,price,qty,img,authId,ebook,desc){
    document.getElementById('editId').value=id;
    document.getElementById('editTitle').value=title;
    document.getElementById('editIsbn').value=isbn||'';
    document.getElementById('editCategory').value=cat||'';
    document.getElementById('editPrice').value=price;
    document.getElementById('editQuantity').value=qty;
    document.getElementById('editImage').value=img||'';
    document.getElementById('editAuthor').value=authId||'';
    document.getElementById('editEbook').checked=ebook;
    document.getElementById('editDesc').value=desc||'';
    toggleModal('editBookModal');
}
</script>
<%@ include file="../common/footer.jsp" %>
