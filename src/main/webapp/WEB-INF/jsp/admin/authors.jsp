<%@ include file="../common/header.jsp" %>
<div class="space-y-6 animate__animated animate__fadeIn">
    <div class="flex justify-between items-center">
        <div><h2 class="text-2xl font-display font-bold text-primary">Manage Authors</h2><p class="text-secondary text-sm">${authors.size()} authors</p></div>
        <button onclick="toggleModal('addAuthorModal')" class="px-5 py-2.5 bg-primary text-white font-bold rounded-xl text-sm hover:bg-dark transition-all shadow-lg"><i class="fas fa-plus mr-2"></i>Add Author</button>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
        <c:forEach var="author" items="${authors}">
            <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-5 card-hover">
                <div class="flex items-center gap-4 mb-3">
                    <div class="w-14 h-14 rounded-xl bg-primary/10 flex items-center justify-center text-primary font-bold text-xl">${author.name.substring(0,1)}</div>
                    <div><h4 class="font-bold text-primary">${author.name}</h4><p class="text-xs text-secondary">${author.bio != null ? author.bio : 'No bio'}</p></div>
                </div>
                <div class="flex gap-2 mt-4">
                    <button onclick="editAuthor(${author.id},'${author.name}','${author.bio}','${author.imageUrl}')" class="flex-1 py-2 text-sm font-bold text-primary border-2 border-primary rounded-lg hover:bg-primary hover:text-white transition-all"><i class="fas fa-edit mr-1"></i>Edit</button>
                    <form action="/admin/authors/delete/${author.id}" method="POST" class="flex-1" onsubmit="return confirm('Delete this author?')"><button class="w-full py-2 text-sm font-bold text-red-500 border-2 border-red-300 rounded-lg hover:bg-red-500 hover:text-white transition-all"><i class="fas fa-trash mr-1"></i>Delete</button></form>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<div id="addAuthorModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center">
    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-md mx-4 p-8 animate__animated animate__zoomIn">
        <div class="flex justify-between items-center mb-6"><h3 class="text-xl font-bold text-primary">Add New Author</h3><button onclick="toggleModal('addAuthorModal')" class="text-secondary hover:text-primary"><i class="fas fa-times text-xl"></i></button></div>
        <form action="/admin/authors/add" method="POST" class="space-y-4">
            <div><label class="block text-sm font-bold text-primary mb-1">Name *</label><input type="text" name="name" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <div><label class="block text-sm font-bold text-primary mb-1">Bio</label><textarea name="bio" rows="3" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary resize-none"></textarea></div>
            <div><label class="block text-sm font-bold text-primary mb-1">Image URL</label><input type="url" name="imageUrl" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <button type="submit" class="w-full py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all text-sm"><i class="fas fa-save mr-2"></i>Add Author</button>
        </form>
    </div>
</div>
<div id="editAuthorModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm z-50 items-center justify-center">
    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-md mx-4 p-8 animate__animated animate__zoomIn">
        <div class="flex justify-between items-center mb-6"><h3 class="text-xl font-bold text-primary">Edit Author</h3><button onclick="toggleModal('editAuthorModal')" class="text-secondary hover:text-primary"><i class="fas fa-times text-xl"></i></button></div>
        <form action="/admin/authors/update" method="POST" class="space-y-4">
            <input type="hidden" name="id" id="eaId">
            <div><label class="block text-sm font-bold text-primary mb-1">Name *</label><input type="text" name="name" id="eaName" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <div><label class="block text-sm font-bold text-primary mb-1">Bio</label><textarea name="bio" id="eaBio" rows="3" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary resize-none"></textarea></div>
            <div><label class="block text-sm font-bold text-primary mb-1">Image URL</label><input type="url" name="imageUrl" id="eaImg" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
            <button type="submit" class="w-full py-3 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all text-sm"><i class="fas fa-save mr-2"></i>Update Author</button>
        </form>
    </div>
</div>
<script>function editAuthor(id,n,b,i){document.getElementById('eaId').value=id;document.getElementById('eaName').value=n;document.getElementById('eaBio').value=b||'';document.getElementById('eaImg').value=i||'';toggleModal('editAuthorModal')}</script>
<%@ include file="../common/footer.jsp" %>
