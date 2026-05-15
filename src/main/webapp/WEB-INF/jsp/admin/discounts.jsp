<%@ include file="../common/header.jsp" %>
<div class="space-y-8 animate__animated animate__fadeIn">

    <!-- Add Discount Form -->
    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-6">
        <h3 class="font-bold text-primary mb-4 flex items-center gap-2"><i class="fas fa-plus-circle text-secondary"></i> Create New Discount</h3>
        <form action="/admin/discounts/add" method="POST" class="space-y-4" id="addDiscountForm">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                    <label class="block text-xs font-bold text-primary mb-1">Discount Name *</label>
                    <input type="text" name="name" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary" placeholder="e.g. Summer Sale 2026">
                </div>
                <div>
                    <label class="block text-xs font-bold text-primary mb-1">Discount Type *</label>
                    <select name="discountType" required id="discountTypeSelect" onchange="toggleDiscountFields()" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary">
                        <option value="SEASONAL">Seasonal Discount</option>
                        <option value="NEW_USER_BONUS">New User Bonus</option>
                        <option value="PRICE_CAP">Price Cap Discount</option>
                    </select>
                </div>
                <div>
                    <label class="block text-xs font-bold text-primary mb-1">Percentage (%) *</label>
                    <input type="number" name="percentage" step="0.1" min="0.1" max="100" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary" placeholder="10">
                </div>
            </div>

            <!-- Seasonal Date Fields -->
            <div id="dateFields" class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-xs font-bold text-primary mb-1">Start Date</label>
                    <input type="date" name="startDate" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary">
                </div>
                <div>
                    <label class="block text-xs font-bold text-primary mb-1">End Date</label>
                    <input type="date" name="endDate" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary">
                </div>
            </div>

            <!-- Price Cap Field -->
            <div id="priceCapField" class="hidden">
                <label class="block text-xs font-bold text-primary mb-1">Price Cap (LKR) — Discount applies when cart total exceeds this amount</label>
                <input type="number" name="priceCap" step="0.01" min="0" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary" placeholder="100.00">
            </div>

            <!-- New User Info -->
            <div id="newUserInfo" class="hidden p-3 bg-blue-50 border border-blue-200 rounded-xl">
                <div class="flex items-start gap-2">
                    <i class="fas fa-info-circle text-blue-500 mt-0.5"></i>
                    <p class="text-xs text-blue-700">New User Bonus applies to customers who registered within the last 30 days.</p>
                </div>
            </div>

            <div>
                <label class="block text-xs font-bold text-primary mb-1">Description</label>
                <textarea name="description" rows="2" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary resize-none" placeholder="Optional description..."></textarea>
            </div>

            <div class="flex justify-end">
                <button type="submit" class="px-6 py-2.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg text-sm flex items-center gap-2"><i class="fas fa-plus"></i> Create Discount</button>
            </div>
        </form>
    </div>

    <!-- Discounts List -->
    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-6">
        <h3 class="font-bold text-primary mb-4 flex items-center gap-2"><i class="fas fa-tags text-secondary"></i> All Discounts</h3>
        <c:choose>
            <c:when test="${not empty discounts}">
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                            <tr class="border-b-2 border-accent/20">
                                <th class="text-left py-3 px-4 text-xs font-bold text-secondary uppercase">Name</th>
                                <th class="text-left py-3 px-4 text-xs font-bold text-secondary uppercase">Type</th>
                                <th class="text-left py-3 px-4 text-xs font-bold text-secondary uppercase">Discount</th>
                                <th class="text-left py-3 px-4 text-xs font-bold text-secondary uppercase">Details</th>
                                <th class="text-left py-3 px-4 text-xs font-bold text-secondary uppercase">Status</th>
                                <th class="text-right py-3 px-4 text-xs font-bold text-secondary uppercase">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="discount" items="${discounts}">
                                <tr class="border-b border-accent/10 hover:bg-base/50 transition-colors">
                                    <td class="py-3 px-4">
                                        <p class="font-bold text-sm text-primary">${discount.name}</p>
                                        <p class="text-[10px] text-secondary">${discount.description != null ? discount.description : ''}</p>
                                    </td>
                                    <td class="py-3 px-4">
                                        <c:choose>
                                            <c:when test="${discount.discountType == 'SEASONAL'}"><span class="text-xs bg-orange-100 text-orange-600 px-2 py-1 rounded-full font-bold"><i class="fas fa-sun mr-1"></i>Seasonal</span></c:when>
                                            <c:when test="${discount.discountType == 'NEW_USER_BONUS'}"><span class="text-xs bg-blue-100 text-blue-600 px-2 py-1 rounded-full font-bold"><i class="fas fa-user-plus mr-1"></i>New User</span></c:when>
                                            <c:when test="${discount.discountType == 'PRICE_CAP'}"><span class="text-xs bg-purple-100 text-purple-600 px-2 py-1 rounded-full font-bold"><i class="fas fa-money-bill mr-1"></i>Price Cap</span></c:when>
                                        </c:choose>
                                    </td>
                                    <td class="py-3 px-4"><span class="text-lg font-black text-primary">${discount.percentage}%</span></td>
                                    <td class="py-3 px-4 text-xs text-secondary">
                                        <c:if test="${discount.discountType == 'SEASONAL' && discount.startDate != null}">
                                            <i class="fas fa-calendar mr-1"></i>${discount.startDate} — ${discount.endDate}
                                        </c:if>
                                        <c:if test="${discount.discountType == 'PRICE_CAP' && discount.priceCap != null}">
                                            <i class="fas fa-money-bill mr-1"></i>Cart > LKR ${discount.priceCap}
                                        </c:if>
                                        <c:if test="${discount.discountType == 'NEW_USER_BONUS'}">
                                            <i class="fas fa-clock mr-1"></i>Within 30 days of registration
                                        </c:if>
                                    </td>
                                    <td class="py-3 px-4">
                                        <c:choose>
                                            <c:when test="${discount.active}">
                                                <span class="text-xs bg-green-100 text-green-600 px-2 py-1 rounded-full font-bold"><i class="fas fa-check-circle mr-1"></i>Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-xs bg-gray-100 text-gray-500 px-2 py-1 rounded-full font-bold"><i class="fas fa-pause-circle mr-1"></i>Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="py-3 px-4 text-right">
                                        <form action="/admin/discounts/toggle/${discount.id}" method="POST" class="inline">
                                            <button type="submit" class="px-3 py-1.5 ${discount.active ? 'bg-amber-50 text-amber-500' : 'bg-green-50 text-green-500'} rounded-lg text-xs font-bold hover:opacity-80 transition-all mr-1" title="${discount.active ? 'Deactivate' : 'Activate'}">
                                                <i class="fas ${discount.active ? 'fa-pause' : 'fa-play'}"></i>
                                            </button>
                                        </form>
                                        <button onclick="toggleModal('editDiscountModal${discount.id}')" class="px-3 py-1.5 bg-secondary/10 text-primary rounded-lg text-xs font-bold hover:bg-secondary/20 transition-all mr-1"><i class="fas fa-edit"></i></button>
                                        <form action="/admin/discounts/delete/${discount.id}" method="POST" class="inline" onsubmit="return confirm('Delete this discount?')">
                                            <button type="submit" class="px-3 py-1.5 bg-red-50 text-red-500 rounded-lg text-xs font-bold hover:bg-red-100 transition-all"><i class="fas fa-trash"></i></button>
                                        </form>
                                    </td>
                                </tr>

                                <!-- Edit Modal -->
                                <div id="editDiscountModal${discount.id}" class="hidden fixed inset-0 bg-black/50 z-50 items-center justify-center p-4">
                                    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto p-8 animate__animated animate__fadeIn">
                                        <div class="flex items-center justify-between mb-6">
                                            <h3 class="font-bold text-primary text-lg">Edit Discount</h3>
                                            <button onclick="toggleModal('editDiscountModal${discount.id}')" class="text-secondary hover:text-primary"><i class="fas fa-times text-xl"></i></button>
                                        </div>
                                        <form action="/admin/discounts/update" method="POST" class="space-y-4">
                                            <input type="hidden" name="id" value="${discount.id}">
                                            <div><label class="block text-xs font-bold text-primary mb-1">Name</label><input type="text" name="name" value="${discount.name}" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                            <div><label class="block text-xs font-bold text-primary mb-1">Type</label>
                                                <select name="discountType" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary">
                                                    <option value="SEASONAL" ${discount.discountType == 'SEASONAL' ? 'selected' : ''}>Seasonal</option>
                                                    <option value="NEW_USER_BONUS" ${discount.discountType == 'NEW_USER_BONUS' ? 'selected' : ''}>New User Bonus</option>
                                                    <option value="PRICE_CAP" ${discount.discountType == 'PRICE_CAP' ? 'selected' : ''}>Price Cap</option>
                                                </select>
                                            </div>
                                            <div><label class="block text-xs font-bold text-primary mb-1">Percentage (%)</label><input type="number" name="percentage" step="0.1" value="${discount.percentage}" required class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                            <div class="grid grid-cols-2 gap-3">
                                                <div><label class="block text-xs font-bold text-primary mb-1">Start Date</label><input type="date" name="startDate" value="${discount.startDate}" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                                <div><label class="block text-xs font-bold text-primary mb-1">End Date</label><input type="date" name="endDate" value="${discount.endDate}" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                            </div>
                                            <div><label class="block text-xs font-bold text-primary mb-1">Price Cap (LKR)</label><input type="number" name="priceCap" step="0.01" value="${discount.priceCap}" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary"></div>
                                            <div><label class="block text-xs font-bold text-primary mb-1">Description</label><textarea name="description" rows="2" class="w-full px-4 py-2.5 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary text-primary resize-none">${discount.description}</textarea></div>
                                            <div class="flex justify-end gap-3">
                                                <button type="button" onclick="toggleModal('editDiscountModal${discount.id}')" class="px-4 py-2 text-secondary text-sm font-medium">Cancel</button>
                                                <button type="submit" class="px-6 py-2.5 bg-primary text-white font-bold rounded-xl text-sm hover:bg-dark transition-all"><i class="fas fa-save mr-1"></i>Save</button>
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
                    <i class="fas fa-tags text-5xl text-accent mb-4"></i>
                    <h4 class="text-lg font-bold text-primary mb-2">No Discounts</h4>
                    <p class="text-secondary text-sm">Create your first discount using the form above.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
function toggleDiscountFields() {
    const type = document.getElementById('discountTypeSelect').value;
    document.getElementById('dateFields').classList.toggle('hidden', type !== 'SEASONAL');
    document.getElementById('priceCapField').classList.toggle('hidden', type !== 'PRICE_CAP');
    document.getElementById('newUserInfo').classList.toggle('hidden', type !== 'NEW_USER_BONUS');
}
toggleDiscountFields();
</script>
<%@ include file="../common/footer.jsp" %>
