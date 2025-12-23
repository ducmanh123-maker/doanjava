<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid">
            <span class="navbar-brand">Quản lý sản phẩm</span>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-light">Quay lại</a>
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
        
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-success">
                Thêm sản phẩm mới
            </a>
        </div>
        
        <div class="card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Danh mục</th>
                                        <th>Giá</th>
                                        <th>Tồn kho</th>
                                        <th>Ảnh</th>
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${products}">
                                        <tr>
                                            <td>${product.productId}</td>
                                            <td>${product.productName}</td>
                                            <td>${product.categoryId}</td>
                                            <td>${String.format("%,.0f", product.price)} đ</td>
                                            <td>${product.stockQuantity}</td>
                                            <td>
                                                <c:set var="imgSrc" value="${product.imageUrl}"/>
                                                <c:if test="${not fn:startsWith(imgSrc, 'http')}">
                                                    <c:set var="imgSrc" value="${pageContext.request.contextPath}/${product.imageUrl}"/>
                                                </c:if>
                                                <img src="${imgSrc}"
                                                     style="width: 50px; height: 50px; object-fit: cover;"
                                                     class="rounded"
                                                     onerror="this.src='${pageContext.request.contextPath}/images/products/default.jpg'">
                                            </td>
                                            <td>
                                                <span class="badge ${product.status == 'active' ? 'bg-success' : 'bg-secondary'}">
                                                    ${product.status}
                                                </span>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.productId}"
                                                   class="btn btn-sm btn-warning">Sửa</a>
                                                <button class="btn btn-sm btn-danger"
                                                        onclick="deleteProduct(${product.productId})">Xóa</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted text-center py-5">Không có sản phẩm nào. <a href="${pageContext.request.contextPath}/admin/products?action=add">Thêm sản phẩm mới</a></p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteProduct(productId) {
            if (confirm('Bạn chắc chắn muốn xóa sản phẩm này?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/products';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = productId;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
