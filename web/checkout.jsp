<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Thanh toán" scope="request"/>
<jsp:include page="/includes/header.jsp"/>

<div class="container py-4">
    <h2 class="mb-4">Thanh toán đơn hàng</h2>
    
    <!-- Hiển thị lỗi nếu có -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <c:if test="${empty cart}">
        <div class="alert alert-warning">
            <p class="mb-0">Giỏ hàng trống. <a href="${pageContext.request.contextPath}/products">Quay lại mua sắm</a></p>
        </div>
    </c:if>
    
    <c:if test="${not empty cart}">
        <form id="checkoutForm" method="post" action="${pageContext.request.contextPath}/checkout">
            <div class="row">
                <!-- Phần bên trái: Thông tin và thanh toán -->
                <div class="col-lg-8">
                    <!-- Thẻ 2: Thông tin giao hàng -->
                    <div class="card mb-3">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Thông tin giao hàng</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label">Địa chỉ giao hàng <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="shippingAddress" name="shippingAddress" rows="3" placeholder="Nhập địa chỉ giao hàng"></textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại">

                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Ghi chú (tuỳ chọn)</label>
                                <textarea class="form-control" id="notes" name="notes" rows="2" placeholder="Nhập ghi chú thêm cho đơn hàng (nếu có)"></textarea>
                            </div>
                        </div>
                    </div>

            

                    <!-- Nút thanh toán -->
                    <button type="submit" class="btn btn-success btn-lg w-100" id="submitBtn">
                        Xác nhận thanh toán
                    </button>
                </div>

                <!-- Phần bên phải: Tóm tắt đơn hàng -->
                <div class="col-lg-4">
                    <div class="card sticky-top" style="top: 20px;">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0">Tóm tắt đơn hàng</h5>
                        </div>
                        <div class="card-body">
                            <!-- Danh sách sản phẩm -->
                            <div class="mb-3">
                                <c:forEach var="item" items="${cart}">
                                    <div class="d-flex justify-content-between align-items-start mb-2 pb-2 border-bottom">
                                        <div class="flex-grow-1 pe-2">
                                            <small class="fw-500">${item.productName}</small><br>
                                            <small class="text-muted">x${item.quantity}</small>
                                        </div>
                                        <small class="text-end"><fmt:formatNumber value="${item.subtotal}" pattern="#,###"/> đ</small>
                                    </div>
                                </c:forEach>
                            </div>



                            <!-- Thông tin cộng -->
                            <div class="mb-2">
                                <div class="d-flex justify-content-between">
                                    <span class="text-muted">Tổng tiền hàng:</span>
                                    <span><fmt:formatNumber value="${cartTotal}" pattern="#,###"/> đ</span>
                                </div>
                            </div>

                            <div class="mb-2">
                                <div class="d-flex justify-content-between">
                                    <span class="text-muted">Phí vận chuyển:</span>
                                    <span>30,000 đ</span>
                                </div>
                            </div>

                            <div class="mb-3 pb-3 border-bottom">
                                <div class="d-flex justify-content-between">
                                    <span class="text-muted">Thuế:</span>
                                    <span>0 đ</span>
                                </div>
                            </div>

                            <!-- Tổng cộng -->
                            <div>
                                <div class="d-flex justify-content-between">
                                    <strong>Tổng cộng:</strong>
                                    <h5 class="text-success mb-0">
                                        <fmt:formatNumber value="${cartTotal + 30000}" pattern="#,###"/> đ
                                    </h5>
                                </div>
                            </div>

                           
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </c:if>
</div>

<jsp:include page="/includes/footer.jsp"/>

<script>
    document.getElementById('checkoutForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const shippingAddress = document.getElementById('shippingAddress').value.trim();
        const phone = document.getElementById('phone').value.trim();
        
        // Kiểm tra địa chỉ
        if (!shippingAddress) {
            alert('Vui lòng nhập địa chỉ giao hàng!');
            document.getElementById('shippingAddress').focus();
            return false;
        }
        
        if (shippingAddress.length < 10) {
            alert('Địa chỉ phải có ít nhất 10 ký tự!');
            document.getElementById('shippingAddress').focus();
            return false;
        }
        
        // Kiểm tra số điện thoại
        if (!phone) {
            alert('Vui lòng nhập số điện thoại!');
            document.getElementById('phone').focus();
            return false;
        }
        
        if (!/^[0-9]{10,11}$/.test(phone.replace(/\D/g, ''))) {
            alert('Số điện thoại không hợp lệ (10-11 chữ số)!');
            document.getElementById('phone').focus();
            return false;
        }
        
        // Disable nút và submit form
        document.getElementById('submitBtn').disabled = true;
        document.getElementById('submitBtn').innerText = 'Đang xử lý...';
        
        this.submit();
    });
</script>
