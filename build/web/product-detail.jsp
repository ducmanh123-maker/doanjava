<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="pageTitle" value="${product.productName}" scope="request"/>
<jsp:include page="/includes/header.jsp"/>

<div class="container py-5">
    <div class="row">
         <div class="col-md-5">
             <c:set var="mainImgSrc" value="${product.imageUrl}"/>
             <c:if test="${not fn:startsWith(mainImgSrc, 'http')}">
                 <c:set var="mainImgSrc" value="${pageContext.request.contextPath}/${product.imageUrl}"/>
             </c:if>
             <img id="mainProductImage" src="${mainImgSrc}" 
                  class="img-fluid rounded shadow"
                  onerror="this.src='${pageContext.request.contextPath}/images/products/default.jpg'"
                  alt="${product.productName}">

             <c:if test="${not empty productImages}">
                 <div class="mt-3 d-flex flex-wrap gap-2">
                     <c:forEach var="img" items="${productImages}">
                         <c:set var="thumbSrc" value="${img}"/>
                         <c:if test="${not fn:startsWith(thumbSrc, 'http')}">
                             <c:set var="thumbSrc" value="${pageContext.request.contextPath}/${img}"/>
                         </c:if>
                         <img src="${thumbSrc}"
                              style="width: 70px; height: 70px; object-fit: cover; cursor: pointer;"
                              class="rounded border"
                              onclick="setMainProductImage(this.src)"
                              onerror="this.src='${pageContext.request.contextPath}/images/products/default.jpg'"
                              alt="${product.productName}">
                     </c:forEach>
                 </div>
             </c:if>
         </div>
        
        <div class="col-md-7">
            <h2>${product.productName}</h2>
            <p class="text-muted">
                <i class="fas fa-tags"></i> ${product.categoryName}
            </p>
            
            <hr>
            
            <h3 class="text-primary">
                <fmt:formatNumber value="${product.price}" pattern="#,###"/> đ
            </h3>
            
            <p class="mt-3">
                <c:choose>
                    <c:when test="${product.stockQuantity > 0}">
                        <span class="badge bg-success">
                            <i class="fas fa-check-circle"></i> Còn ${product.stockQuantity} sản phẩm
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-danger">
                            <i class="fas fa-times-circle"></i> Hết hàng
                        </span>
                    </c:otherwise>
                </c:choose>
            </p>
            
            <hr>
            
            <h5>Mô tả sản phẩm:</h5>
            <p>${product.description != null ? product.description : 'Chưa có mô tả'}</p>
            
            <hr>
            
            <c:if test="${product.stockQuantity > 0}">
                <form method="post" action="${pageContext.request.contextPath}/cart">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productId" value="${product.productId}">
                    
                    <div class="row align-items-end">
                        <div class="col-md-3">
                            <label class="form-label">Số lượng:</label>
                            <input type="number" class="form-control" name="quantity" 
                                   value="1" min="1" max="${product.stockQuantity}">
                        </div>
                        <div class="col-md-6">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                            </button>
                        </div>
                    </div>
                </form>
            </c:if>
            
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    function setMainProductImage(src) {
        var img = document.getElementById('mainProductImage');
        if (img) img.src = src;
    }
</script>

<jsp:include page="/includes/footer.jsp"/>
