<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="pageTitle" value="Giỏ hàng" scope="request"/>
<jsp:include page="/includes/header.jsp"/>

<div class="container py-4">
    <h2>Giỏ hàng của bạn</h2>
    <hr>
    
    <c:choose>
        <c:when test="${empty cart}">
            <div class="alert alert-info text-center py-5">
                <h4>Giỏ hàng trống</h4>
                <p>Hãy thêm sản phẩm vào giỏ hàng</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Mua sắm ngay</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <div class="col-md-8">
                    <div class="table-responsive">
                        <table class="table">
                            <thead class="table-dark">
                                <tr>
                                    <th class="text-white fw-bold">Hình ảnh</th>
                                    <th class="text-white fw-bold">Sản phẩm</th>
                                    <th class="text-end text-white fw-bold">Giá</th>
                                    <th class="text-center text-white fw-bold">Số lượng</th>
                                    <th class="text-end text-white fw-bold">Cộng</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cart}">
                                    <tr>
                                        <td>
                                            <c:set var="imgSrc" value="${item.imageUrl}"/>
                                            <c:if test="${not fn:startsWith(imgSrc, 'http')}">
                                                <c:set var="imgSrc" value="${pageContext.request.contextPath}/${item.imageUrl}"/>
                                            </c:if>
                                            <img src="${imgSrc}" 
                                                 style="width: 60px; height: 60px; object-fit: cover;"
                                                 class="rounded"
                                                 onerror="this.src='${pageContext.request.contextPath}/images/products/default.jpg'">
                                        </td>
                                        <td>
                                            <strong>${item.productName}</strong>
                                        </td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${item.unitPrice}" pattern="#,###"/> đ
                                        </td>
                                        <td>
                                            <form method="post" action="${pageContext.request.contextPath}/cart" class="d-inline">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="productId" value="${item.productId}">
                                                <div class="input-group" style="width: 120px;">
                                                    <input type="number" class="form-control form-control-sm" name="quantity" 
                                                           value="${item.quantity}" min="1" onchange="this.form.submit()">
                                                </div>
                                            </form>
                                        </td>
                                        <td class="text-end">
                                            <strong><fmt:formatNumber value="${item.subtotal}" pattern="#,###"/> đ</strong>
                                        </td>
                                        <td>
                                            <form method="post" action="${pageContext.request.contextPath}/cart" class="d-inline">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="productId" value="${item.productId}">
                                                <button type="submit" class="btn btn-outline-danger btn-sm">
                                                    Xóa
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-between mt-3">
                        <form method="post" action="${pageContext.request.contextPath}/cart" class="d-inline">
                            <input type="hidden" name="action" value="clear">
                            <button type="submit" class="btn btn-outline-danger">
                                Xóa hết giỏ hàng
                            </button>
                        </form>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary">
                            Tiếp tục mua sắm
                        </a>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card sticky-top" style="top: 20px;">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Tổng kết đơn hàng</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-3">
                                <span>Tổng tiền:</span>
                                <strong>
                                    <fmt:formatNumber value="${cartTotal}" pattern="#,###"/> đ
                                </strong>
                            </div>
                            
                            <hr>
                            
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success btn-lg w-100 mb-2">
                                        Thanh toán
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/login" class="btn btn-success btn-lg w-100 mb-2">
                                        Đăng nhập để thanh toán
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            
                            <small class="text-muted d-block text-center">
                                Chưa tính phí vận chuyển
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/includes/footer.jsp"/>
