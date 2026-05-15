<%@ include file="common/header.jsp" %>
<div class="max-w-3xl mx-auto space-y-8 animate__animated animate__fadeIn">
    <div class="text-center"><h2 class="text-3xl font-display font-bold text-primary">Complete Your Purchase</h2><p class="text-secondary mt-2">Choose your payment method</p></div>
    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-6">
        <h3 class="font-bold text-primary mb-4">Order Summary</h3>
        <div class="space-y-3">
            <c:forEach var="item" items="${cart}">
                <div class="flex justify-between items-center text-sm py-2 border-b border-accent/10">
                    <div><span class="font-bold text-primary">${item.bookTitle}</span><span class="text-xs text-secondary ml-2">(${item.format}) x${item.quantity}</span></div>
                    <span class="font-bold text-primary">LKR ${item.subtotal}</span>
                </div>
            </c:forEach>

            <div class="flex justify-between text-primary text-sm pt-2"><span>Subtotal</span><span class="font-bold">LKR ${cartTotal}</span></div>

            <!-- Discount Display -->
            <c:if test="${not empty discount}">
                <div class="flex justify-between items-center text-sm py-2 bg-green-50 px-3 rounded-xl border border-green-200">
                    <div class="flex items-center gap-2">
                        <i class="fas fa-tag text-green-500"></i>
                        <div>
                            <span class="font-bold text-green-700">${discount.name}</span>
                            <span class="text-xs text-green-600 ml-1">(-${discount.percentage}%)</span>
                        </div>
                    </div>
                    <span class="font-bold text-green-600">-LKR ${discountAmount}</span>
                </div>
            </c:if>

            <div class="flex justify-between text-primary font-bold text-lg pt-2 border-t-2 border-accent/20">
                <span>Total</span>
                <div class="text-right">
                    <c:if test="${not empty discount}">
                        <span class="text-sm text-secondary line-through mr-2">LKR ${cartTotal}</span>
                    </c:if>
                    <span class="text-primary">LKR ${discountedTotal}</span>
                </div>
            </div>
        </div>
    </div>
    <div class="bg-white rounded-2xl shadow-lg border border-accent/20 p-6">
        <h3 class="font-bold text-primary mb-6">Payment Method</h3>
        <div class="flex gap-3 mb-6">
            <button onclick="showTab('card')" id="tabCard" class="flex-1 py-3 rounded-xl font-bold text-sm transition-all bg-primary text-white"><i class="fas fa-credit-card mr-2"></i>Card Payment</button>
            <button onclick="showTab('slip')" id="tabSlip" class="flex-1 py-3 rounded-xl font-bold text-sm transition-all bg-base text-primary border-2 border-accent/30"><i class="fas fa-receipt mr-2"></i>Bank Slip</button>
        </div>
        <div id="panelCard">
            <form action="/checkout/process" method="POST">
                <input type="hidden" name="paymentMethod" value="CARD">
                <div class="space-y-4">
                    <div><label class="block text-sm font-bold text-primary mb-1.5">Card Number</label><input type="text" placeholder="4242 4242 4242 4242" maxlength="19" class="w-full px-4 py-3 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary" oninput="this.value=this.value.replace(/[^0-9]/g,'').replace(/(.{4})/g,'$1 ').trim()"></div>
                    <div class="grid grid-cols-2 gap-4">
                        <div><label class="block text-sm font-bold text-primary mb-1.5">Expiry</label><input type="text" placeholder="MM/YY" maxlength="5" class="w-full px-4 py-3 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
                        <div><label class="block text-sm font-bold text-primary mb-1.5">CVV</label><input type="text" placeholder="123" maxlength="3" class="w-full px-4 py-3 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
                    </div>
                    <div><label class="block text-sm font-bold text-primary mb-1.5">Cardholder Name</label><input type="text" placeholder="Kasun Perera" class="w-full px-4 py-3 bg-base border-2 border-accent/30 rounded-xl text-sm focus:outline-none focus:border-primary"></div>
                    <div class="bg-amber-50 border border-amber-200 rounded-xl p-4 flex items-center gap-3"><i class="fas fa-info-circle text-amber-500"></i><p class="text-xs text-amber-700">This is a simulated payment. No real charges will be made.</p></div>
                    <button type="submit" class="w-full py-3.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg text-sm flex items-center justify-center gap-2"><i class="fas fa-lock"></i> Pay LKR ${discountedTotal}</button>
                </div>
            </form>
        </div>
        <div id="panelSlip" class="hidden">
            <form action="/checkout/process" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="paymentMethod" value="BANK_SLIP">
                <div class="space-y-4">
                    <div class="bg-base rounded-2xl p-6 border-2 border-dashed border-accent text-center">
                        <i class="fas fa-cloud-upload-alt text-4xl text-secondary mb-3"></i>
                        <p class="text-primary font-bold text-sm mb-2">Upload Payment Slip</p>
                        <p class="text-xs text-secondary mb-4">Drag & drop or click to upload (JPG, PNG, PDF)</p>
                        <input type="file" name="slip" accept="image/*,.pdf" class="block w-full text-sm text-secondary file:mr-4 file:py-2 file:px-4 file:rounded-xl file:border-0 file:bg-primary file:text-white file:font-bold file:cursor-pointer">
                    </div>
                    <div class="bg-blue-50 border border-blue-200 rounded-xl p-4"><p class="text-xs text-blue-700"><i class="fas fa-info-circle mr-1"></i>Transfer to: BookLeaf Bank — Acc: 1234-5678-9012. Reference: Your email.</p></div>
                    <button type="submit" class="w-full py-3.5 bg-primary text-white font-bold rounded-xl hover:bg-dark transition-all shadow-lg text-sm flex items-center justify-center gap-2"><i class="fas fa-check-circle"></i> Confirm Payment</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
function showTab(tab){
    document.getElementById('panelCard').classList.toggle('hidden',tab!=='card');
    document.getElementById('panelSlip').classList.toggle('hidden',tab!=='slip');
    document.getElementById('tabCard').className=tab==='card'?'flex-1 py-3 rounded-xl font-bold text-sm transition-all bg-primary text-white':'flex-1 py-3 rounded-xl font-bold text-sm transition-all bg-base text-primary border-2 border-accent/30';
    document.getElementById('tabSlip').className=tab==='slip'?'flex-1 py-3 rounded-xl font-bold text-sm transition-all bg-primary text-white':'flex-1 py-3 rounded-xl font-bold text-sm transition-all bg-base text-primary border-2 border-accent/30';
}
</script>
<%@ include file="common/footer.jsp" %>
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
