<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid">
            <span class="navbar-brand"><i class="fas fa-tags"></i> Quản lý danh mục</span>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-light">
                Quay lại
            </a>
        </div>
    </nav>
    
    <div class="container-fluid p-4">
        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-plus"></i> Thêm danh mục mới</h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/admin/categories">
                            <input type="hidden" name="action" value="add">
                            <div class="mb-3">
                                <label class="form-label">Tên danh mục</label>
                                <input type="text" class="form-control" name="categoryName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea class="form-control" name="description" rows="3"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-plus"></i> Thêm
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-md-8">
                <c:if test="${sessionScope.success != null}">
                    <div class="alert alert-success alert-dismissible">
                        ${sessionScope.success}
                        <c:remove var="success" scope="session"/>
                    </div>
                </c:if>
                
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tên danh mục</th>
                            <th>Mô tả</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td>${category.categoryId}</td>
                                <td>${category.categoryName}</td>
                                <td>${category.description}</td>
                                <td>
                                    <button class="btn btn-sm btn-warning" data-bs-toggle="modal" 
                                            data-bs-target="#editModal${category.categoryId}">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/categories" 
                                          style="display:inline;" onsubmit="return confirm('Xóa danh mục này?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${category.categoryId}">
                                        <button type="submit" class="btn btn-sm btn-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                    
                                    <!-- Edit Modal -->
                                    <div class="modal fade" id="editModal${category.categoryId}">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/categories">
                                                    <input type="hidden" name="action" value="edit">
                                                    <input type="hidden" name="categoryId" value="${category.categoryId}">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Sửa danh mục</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="mb-3">
                                                            <label class="form-label">Tên danh mục</label>
                                                            <input type="text" class="form-control" name="categoryName" 
                                                                   value="${category.categoryName}" required>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label class="form-label">Mô tả</label>
                                                            <textarea class="form-control" name="description" rows="3">${category.description}</textarea>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="submit" class="btn btn-primary">Lưu</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
