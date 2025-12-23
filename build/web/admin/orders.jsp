<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid">
            <span class="navbar-brand">Quản lý đơn hàng</span>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-light">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
        </div>
    </nav>

    <div class="container-fluid p-4">
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <div class="card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty orders}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Khách hàng</th>
                                        <th>Email</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày tạo</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td>${order.orderId}</td>
                                            <td>${order.customerName}</td>
                                            <td>${order.customerEmail}</td>
                                            <td>${String.format("%,.0f", order.totalAmount)} đ</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.status == 'pending'}">
                                                        <span class="badge bg-warning">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'processing'}">
                                                        <span class="badge bg-info">Đang xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'shipped'}">
                                                        <span class="badge bg-primary">Đã gửi hàng</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'delivered'}">
                                                        <span class="badge bg-success">Đã giao hàng</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'cancelled'}">
                                                        <span class="badge bg-danger">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${order.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.orderId}"
                                                   class="btn btn-sm btn-info">Chi tiết</a>
                                                <button class="btn btn-sm btn-danger"
                                                        onclick="deleteOrder(${order.orderId})">Xóa</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted text-center py-5">Không có đơn hàng nào</p>
                    </c:otherwise>
                </c:choose>
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
