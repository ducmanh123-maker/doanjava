<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="pageTitle" value="Sản phẩm" scope="request"/>
<jsp:include page="/includes/header.jsp"/>

<div class="container py-4">
    <div class="row">
        <!-- Sidebar - Categories -->
        <div class="col-md-3">
            <div class="card">
                <div class="list-group list-group-flush">
                    <c:url var="allProductsUrl" value="/products">
                        <c:if test="${not empty currentSort}">
                            <c:param name="sort" value="${currentSort}"/>
                        </c:if>
                    </c:url>
                    <a href="${allProductsUrl}" 
                       class="list-group-item list-group-item-action ${currentCategory == null ? 'active' : ''}">
                        Tất cả sản phẩm
                    </a>
                    <c:forEach var="category" items="${categories}">
                        <c:url var="categoryUrl" value="/products">
                            <c:param name="category" value="${category.categoryId}"/>
                            <c:if test="${not empty currentSort}">
                                <c:param name="sort" value="${currentSort}"/>
                            </c:if>
                        </c:url>
                        <a href="${categoryUrl}" 
                           class="list-group-item list-group-item-action ${currentCategory.categoryId == category.categoryId ? 'active' : ''}">
                            ${category.categoryName}
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
        
        <!-- Products List -->
        <div class="col-md-9">
            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>
                    <c:choose>
                        <c:when test="${currentCategory != null}">
                            ${currentCategory.categoryName}
                        </c:when>
                        <c:when test="${searchKeyword != null}">
                            Kết quả tìm kiếm: "${searchKeyword}"
                        </c:when>
                        <c:otherwise>
                            Tất cả sản phẩm
                        </c:otherwise>
                    </c:choose>
                </h2>
                <div class="d-flex align-items-center gap-2">
                    <span class="text-muted">${products.size()} sản phẩm</span>

                    <form method="get" action="${pageContext.request.contextPath}/products" class="d-flex align-items-center gap-2">
                        <c:if test="${not empty param.category}">
                            <input type="hidden" name="category" value="${param.category}">
                        </c:if>
                        <c:if test="${not empty param.search}">
                            <input type="hidden" name="search" value="${param.search}">
                        </c:if>
                        <select class="form-select form-select-sm" name="sort" onchange="this.form.submit()" style="width: 180px;">
                            <option value="" ${empty currentSort ? 'selected' : ''}>Mặc định</option>
                            <option value="price_asc" ${currentSort == 'price_asc' ? 'selected' : ''}>Giá tăng dần</option>
                            <option value="price_desc" ${currentSort == 'price_desc' ? 'selected' : ''}>Giá giảm dần</option>
                            <option value="name_asc" ${currentSort == 'name_asc' ? 'selected' : ''}>Tên A → Z</option>
                            <option value="name_desc" ${currentSort == 'name_desc' ? 'selected' : ''}>Tên Z → A</option>
                        </select>
                        <noscript>
                            <button class="btn btn-secondary btn-sm" type="submit">Sắp xếp</button>
                        </noscript>
                    </form>
                </div>
            </div>
            
            <!-- Products Grid -->
            <div class="row">
                <c:choose>
                    <c:when test="${products.isEmpty()}">
                        <div class="col-12">
                            <div class="alert alert-info text-center">
                                <i class="fas fa-info-circle"></i> Không tìm thấy sản phẩm nào
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="product" items="${products}">
                             <div class="col-md-4 col-sm-6 mb-4">
                                 <div class="card h-100">
                                     <c:set var="imgSrc" value="${product.imageUrl}"/>
                                     <c:if test="${not fn:startsWith(imgSrc, 'http')}">
                                         <c:set var="imgSrc" value="${pageContext.request.contextPath}/${product.imageUrl}"/>
                                     </c:if>
                                     <img src="${imgSrc}" 
                                          class="card-img-top" alt="${product.productName}"
                                          onerror="this.src='${pageContext.request.contextPath}/images/products/default.jpg'"
                                          style="height: 200px; object-fit: cover;">
                                    <div class="card-body d-flex flex-column">
                                        <h6 class="card-title">${product.productName}</h6>
                                        <p class="text-muted small mb-1">${product.categoryName}</p>
                                        <p class="text-primary fw-bold fs-5">
                                            <fmt:formatNumber value="${product.price}" pattern="#,###"/> đ
                                        </p>
                                        <p class="text-muted small">
                                            <c:choose>
                                                <c:when test="${product.stockQuantity > 0}">
                                                    <i class="fas fa-check-circle text-success"></i> Còn ${product.stockQuantity} sản phẩm
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-times-circle text-danger"></i> Hết hàng
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <div class="mt-auto">
                                            <a href="${pageContext.request.contextPath}/product-detail?id=${product.productId}" 
                                               class="btn btn-primary btn-sm w-100">
                                                <i class="fas fa-eye"></i> Xem chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp"/>
