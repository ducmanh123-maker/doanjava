<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng #${order.orderId}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid">
            <span class="navbar-brand">Chi tiết đơn hàng #${order.orderId}</span>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-light">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
        </div>
    </nav>  

    <div class="container py-4">
        <div class="row">
            <div class="col-md-8">
                <!-- Thông tin khách hàng -->
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Thông tin khách hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Tên:</strong> ${order.customerName}</p>
                                <p><strong>Email:</strong> ${order.customerEmail}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Điện thoại:</strong> ${order.phone}</p>
                                <p><strong>Địa chỉ:</strong> ${order.shippingAddress}</p>
                            </div>
                        </div>
                        <c:if test="${not empty order.notes}">
                            <p><strong>Ghi chú:</strong> ${order.notes}</p>
                        </c:if>
                    </div>
                </div>

                <!-- Chi tiết sản phẩm -->
                <div class="card mb-4">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="mb-0">Chi tiết sản phẩm</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Hình ảnh</th>
                                        <th>Sản phẩm</th>
                                        <th class="text-end">Giá</th>
                                        <th class="text-center">Số lượng</th>
                                        <th class="text-end">Cộng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${order.orderItems}">
                                        <tr>
                                            <td>
                                                <c:set var="imgSrc" value="${item.imageUrl}"/>
                                                <c:if test="${not fn:startsWith(imgSrc, 'http')}">
                                                    <c:set var="imgSrc" value="${pageContext.request.contextPath}/${item.imageUrl}"/>
                                                </c:if>
                                                <img src="${imgSrc}"
                                                     style="width: 50px; height: 50px; object-fit: cover;"
                                                     class="rounded"
                                                     onerror="this.src='${pageContext.request.contextPath}/images/products/default.jpg'">
                                            </td>
                                            <td>${item.productName}</td>
                                            <td class="text-end">
                                                <fmt:formatNumber value="${item.price}" pattern="#,###"/> đ
                                            </td>
                                            <td class="text-center">${item.quantity}</td>
                                            <td class="text-end">
                                                <fmt:formatNumber value="${item.subtotal}" pattern="#,###"/> đ
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cập nhật trạng thái -->
            <div class="col-md-4">
                <div class="card sticky-top" style="top: 20px;">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">Trạng thái đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                            <input type="hidden" name="action" value="updateStatus">
                            <input type="hidden" name="orderId" value="${order.orderId}">

                            <div class="mb-3">
                                <label class="form-label">Trạng thái <span class="text-danger">*</span></label>
                                <select class="form-select" name="status" required>
                                    <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="processing" ${order.status == 'processing' ? 'selected' : ''}>Đang xử lý</option>
                                    <option value="shipped" ${order.status == 'shipped' ? 'selected' : ''}>Đã gửi hàng</option>
                                    <option value="delivered" ${order.status == 'delivered' ? 'selected' : ''}>Đã giao hàng</option>
                                    <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary w-100">Cập nhật</button>
                        </form>

                        <hr>

                        <div class="mb-3">
                            <p class="mb-2"><strong>Tổng cộng:</strong></p>
                            <h4 class="text-primary">
                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> đ
                            </h4>
                        </div>

                        <div class="mb-3">
                            <p class="text-muted small">
                                <strong>Ngày tạo:</strong> 
                                <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </p>
                            <p class="text-muted small">
                                <strong>Cập nhật lần cuối:</strong> 
                                <fmt:formatDate value="${order.updatedAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </p>
                        </div>

                        <button type="button" class="btn btn-danger btn-sm w-100"
                                onclick="deleteOrder(${order.orderId})">Xóa đơn hàng</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteOrder(orderId) {
            if (confirm('Bạn chắc chắn muốn xóa đơn hàng này?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/orders';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';

                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = orderId;

                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
