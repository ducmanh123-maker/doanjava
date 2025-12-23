<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Đăng ký" scope="request"/>
<jsp:include page="/includes/header.jsp"/>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-body p-5">
                    <h2 class="text-center mb-4">Đăng ký tài khoản</h2>
                    
                    <!-- Error Message -->
                    <c:if test="${error != null}">
                        <div class="alert alert-danger alert-dismissible fade show">
                            ⚠️ ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <form method="post" action="${pageContext.request.contextPath}/register">
                        <div class="mb-3">
                            <label class="form-label">Username <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="username" 
                                   value="${username}" required>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Xác nhận Password <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" name="confirmPassword" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Họ tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="fullName" 
                                   value="${fullName}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" 
                                   value="${email}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" name="phone" 
                                   value="${phone}">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ</label>
                            <textarea class="form-control" name="address" rows="2">${address}</textarea>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100">Đăng ký</button>
                    </form>
                    
                    <hr class="my-4">
                    
                    <p class="text-center mb-0">
                        Đã có tài khoản? 
                        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp"/>
