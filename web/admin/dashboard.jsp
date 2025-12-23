<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid">
            <span class="navbar-brand"><i class="fas fa-tachometer-alt"></i> Admin Panel</span>
            <div class="d-flex">
                <span class="text-white me-3">Xin chào, ${sessionScope.user.fullName}</span>
                <a href="${pageContext.request.contextPath}/" class="btn btn-sm btn-outline-light me-2">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-outline-danger">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>
    
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 bg-light min-vh-100 p-3">
                <div class="list-group">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action active">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="list-group-item list-group-item-action">
                        <i class="fas fa-tags"></i> Danh mục
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/products" class="list-group-item list-group-item-action">
                        <i class="fas fa-box"></i> Sản phẩm
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/orders" class="list-group-item list-group-item-action">
                        <i class="fas fa-shopping-cart"></i> Đơn hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action">
                        <i class="fas fa-users"></i> Người dùng
                    </a>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-10 p-4">
                <h2>Dashboard - Tổng quan</h2>
                <hr>
                
                <!-- Statistics Cards -->
                <div class="row">
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-primary">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Sản phẩm</h5>
                                        <h2>${totalProducts}</h2>
                                    </div>
                                    <div>
                                        <i class="fas fa-box fa-3x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-success">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Đơn hàng</h5>
                                        <h2>${totalOrders}</h2>
                                    </div>
                                    <div>
                                        <i class="fas fa-shopping-cart fa-3x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-info">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Người dùng</h5>
                                        <h2>${totalUsers}</h2>
                                    </div>
                                    <div>
                                        <i class="fas fa-users fa-3x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-warning">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Doanh thu</h5>
                                        <h4><fmt:formatNumber value="${totalRevenue}" pattern="#,###"/>đ</h4>
                                    </div>
                                    <div>
                                        <i class="fas fa-dollar-sign fa-3x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> Chào mừng bạn đến với trang quản trị!
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
