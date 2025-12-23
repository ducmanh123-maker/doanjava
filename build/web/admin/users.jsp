<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid">
            <span class="navbar-brand"><i class="fas fa-users"></i> Quản lý người dùng</span>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-light">
                Quay lại
            </a>
        </div>
    </nav>
    
    <div class="container-fluid p-4">
        <h3>Danh sách người dùng</h3>
        
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
                    <th>Username</th>
                    <th>Họ tên</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Role</th>
                    <th>Ngày tạo</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.userId}</td>
                        <td>${user.username}</td>
                        <td>${user.fullName}</td>
                        <td>${user.email}</td>
                        <td>${user.phone}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.role == 'admin'}">
                                    <span class="badge bg-danger">Admin</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-primary">Customer</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy"/></td>
                        <td>
                            <c:if test="${user.role != 'admin'}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/users" 
                                      style="display:inline;" onsubmit="return confirm('Xóa người dùng này?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${user.userId}">
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
