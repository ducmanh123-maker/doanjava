<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Hồ sơ người dùng" scope="request"/>
<jsp:include page="/includes/header.jsp"/>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <!-- Alert Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Profile Card -->
            <div class="card">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="fas fa-user-circle"></i> Thông tin cá nhân
                    </h5>
                </div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/user-profile" id="profileForm">
                        <input type="hidden" name="action" value="updateInfo">

                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" value="${sessionScope.user.username}" disabled>
                            <small class="text-muted">Tên đăng nhập không thể thay đổi</small>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="fullName" 
                                       value="${not empty userInfo ? userInfo.fullName : ''}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" name="email" 
                                       value="${not empty userInfo ? userInfo.email : ''}" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại</label>
                                <input type="tel" class="form-control" name="phone" 
                                       value="${not empty userInfo ? userInfo.phone : ''}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Địa chỉ</label>
                                <input type="text" class="form-control" name="address" 
                                       value="${not empty userInfo ? userInfo.address : ''}">
                            </div>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Lưu thay đổi
                            </button>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                                <i class="fas fa-times"></i> Hủy
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp"/>

<style>
    .form-label {
        font-weight: 500;
        color: #2b2b2b;
    }

    .form-control {
        border: 1px solid #ff9999;
    }

    .form-control:focus {
        border-color: #252525;
        box-shadow: 0 0 0 0.2rem rgba(255, 107, 107, 0.25);
    }

    .btn-primary {
        background-color: #ff6363;
        border-color: #ffe7e7;
    }

    .btn-primary:hover {
        background-color: #ff5252;
        border-color: #ff5252;
    }

    .alert {
        border-left: 4px solid;
        border-radius: 0.5rem;
    }

    .alert-success {
        background-color: #d4edda;
        border-color: #06d6a0;
        color: #155724;
    }

    .alert-danger {
        background-color: #f8d7da;
        border-color: #ff6b6b;
        color: #721c24;
    }
</style>

<script>
    // Validate form before submit
    document.getElementById('profileForm')?.addEventListener('submit', function(e) {
        const fullName = this.fullName.value.trim();
        const email = this.email.value.trim();

        if (!fullName) {
            alert('Vui lòng nhập họ và tên!');
            e.preventDefault();
            return false;
        }

        if (!email) {
            alert('Vui lòng nhập email!');
            e.preventDefault();
            return false;
        }

        if (!email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
            alert('Email không hợp lệ!');
            e.preventDefault();
            return false;
        }

        return true;
    });
</script>
