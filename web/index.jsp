<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="pageTitle" value="Trang chủ" scope="request"/>
<jsp:include page="/includes/header.jsp"/>

<!-- Popup thông báo thanh toán thành công -->
<c:if test="${not empty param.success && param.success == '1'}">
    <div id="successOverlay" class="success-overlay" onclick="if(event.target === this) closeSuccessModal()">
        <div class="success-popup">
            <!-- Icon thành công -->
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            
            <!-- Tiêu đề -->
            <h3 class="success-title">Thanh toán thành công!</h3>
            
            <!-- Thông báo -->
            <p class="success-message">
                Đơn hàng của bạn đã được tạo thành công.<br>
                Chúng tôi sẽ liên hệ với bạn sớm.
            </p>
            
            <!-- Mã đơn hàng -->
            <c:if test="${not empty param.orderId}">
                <div class="order-id-box">
                    <span class="order-id-label">Mã đơn hàng:</span>
                    <span class="order-id-value">#${param.orderId}</span>
                </div>
            </c:if>
            
            <!-- Nút đóng -->
            <button type="button" class="success-btn" onclick="closeSuccessModal()">
                OK
            </button>
            
            <!-- Nút close (X) góc trên phải -->
            <button type="button" class="success-close" onclick="closeSuccessModal()" aria-label="Close">
                ×
            </button>
        </div>
    </div>
    
    <style>
        .success-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }
        
        .success-popup {
            background-color: #fffaf0;
            border: 1px solid #ffe6e6;
            width: 90%;
            max-width: 450px;
            padding: 2rem 2rem;
            text-align: center;
            position: relative;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .success-icon {
            width: 70px;
            height: 70px;
            background-color: #06d6a0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 35px;
            color: white;
            font-weight: bold;
        }
        
        .success-title {
            font-size: 1.5rem;
            font-weight: 500;
            color: #2b2b2b;
            margin-bottom: 1rem;
            letter-spacing: -0.5px;
        }
        
        .success-message {
            font-size: 0.95rem;
            color: #6b6b6b;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        
        .order-id-box {
            background-color: #ffffff;
            border: 1px solid #ffe6e6;
            padding: 1rem;
            margin-bottom: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .order-id-label {
            font-size: 0.85rem;
            color: #6b6b6b;
            font-weight: 400;
        }
        
        .order-id-value {
            font-size: 1.3rem;
            font-weight: 600;
            color: #ff6b6b;
            font-family: 'Courier New', monospace;
            letter-spacing: 1px;
        }
        
        .success-btn {
            width: 100%;
            padding: 0.75rem 1.5rem;
            background-color: #06d6a0;
            border: 2px solid #06d6a0;
            color: white;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            letter-spacing: 0.3px;
            transition: all 0.2s ease;
        }
        
        .success-btn:hover {
            background-color: #229954;
            border-color: #229954;
        }
        
        .success-close {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: none;
            border: none;
            font-size: 2rem;
            color: #6b6b6b;
            cursor: pointer;
            padding: 0;
            width: 2rem;
            height: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }
        
        .success-close:hover {
            color: #ff6b6b;
            transform: rotate(90deg);
        }
        
        @media (max-width: 480px) {
            .success-popup {
                width: 95%;
                padding: 1.5rem 1.5rem;
            }
            
            .success-title {
                font-size: 1.3rem;
            }
            
            .success-message {
                font-size: 0.9rem;
            }
        }
    </style>
    
    <script>
        function closeSuccessModal() {
            var overlay = document.getElementById('successOverlay');
            if (overlay) {
                overlay.style.opacity = '0';
                overlay.style.transition = 'opacity 0.3s ease';
                setTimeout(function() {
                    overlay.remove();
                }, 300);
            }
            window.history.replaceState({}, document.title, window.location.pathname);
        }
        
        // Tự động đóng sau 5 giây
        setTimeout(function() {
            closeSuccessModal();
        }, 5000);
    </script>
</c:if>

<!-- Banner Slider -->
<section class="banner-slider">
    <div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="2"></button>
        </div>
        
        <div class="carousel-inner">
            <!-- Slide 1 -->
            <div class="carousel-item active">
                <img src="https://images.unsplash.com/photo-1593640408182-31c70c8268f5?w=1200&h=400&fit=crop" 
                     class="d-block w-100 banner-image" alt="Gaming Setup">
                <div class="carousel-caption-custom">
                     <div class="container">
                         <h1 class="display-4 text-white mb-3">Linh kiện gaming cao cấp</h1>
                         <p class="lead text-white mb-4">CPU, VGA, RAM - Hiệu năng đỉnh cao</p>
                     </div>
                 </div>
            </div>
            
            <!-- Slide 2 -->
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1587202372634-32705e3bf49c?w=1200&h=400&fit=crop" 
                     class="d-block w-100 banner-image" alt="Graphics Card">
                <div class="carousel-caption-custom">
                     <div class="container">
                         <h1 class="display-4 text-white mb-3">Card đồ họa RTX Series</h1>
                         <p class="lead text-white mb-4">NVIDIA & AMD - Trải nghiệm gaming đỉnh cao</p>
                     </div>
                 </div>
            </div>
            
            <!-- Slide 3 -->
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=1200&h=400&fit=crop" 
                     class="d-block w-100 banner-image" alt="Storage">
                <div class="carousel-caption-custom">
                     <div class="container">
                         <h1 class="display-4 text-white mb-3">SSD & HDD chính hãng</h1>
                         <p class="lead text-white mb-4">Tốc độ cao, dung lượng lớn</p>
                     </div>
                 </div>
            </div>
        </div>
        
        <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</section>

<!-- Categories Section -->
<section class="categories-section">
    <div class="container">
        <div class="section-header mb-4">
             <h2 class="section-title">Danh mục sản phẩm</h2>
         </div>
        <div class="row">
            <c:forEach var="category" items="${categories}" varStatus="status">
                <div class="col-md-3 col-sm-6 mb-4">
                    <a href="${pageContext.request.contextPath}/products?category=${category.categoryId}" 
                       class="text-decoration-none">
                       <c:choose>
                           <c:when test="${category.categoryId == 1}">
                               <c:set var="bgImage" value="https://images.unsplash.com/photo-1555617981-dac3880eac6e?w=600&h=300&fit=crop"/>
                           </c:when>
                           <c:when test="${category.categoryId == 2}">
                               <c:set var="bgImage" value="https://images.unsplash.com/photo-1591488320449-011701bb6704?w=600&h=300&fit=crop"/>
                           </c:when>
                           <c:when test="${category.categoryId == 3}">
                               <c:set var="bgImage" value="https://images.unsplash.com/photo-1562976540-1502c2145186?w=600&h=300&fit=crop"/>
                           </c:when>
                           <c:when test="${category.categoryId == 4}">
                               <c:set var="bgImage" value="https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=600&h=300&fit=crop"/>
                           </c:when>
                           <c:when test="${category.categoryId == 5}">
                               <c:set var="bgImage" value="https://images.unsplash.com/photo-1587202372634-32705e3bf49c?w=600&h=300&fit=crop"/>
                           </c:when>
                           <c:when test="${category.categoryId == 6}">
                               <c:set var="bgImage" value="https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=600&h=300&fit=crop"/>
                           </c:when>
                           <c:when test="${category.categoryId == 7}">
                               <c:set var="bgImage" value="https://images.unsplash.com/photo-1587202372583-49330a15584d?w=600&h=300&fit=crop"/>
                           </c:when>
                           <c:otherwise>
                               <c:set var="bgImage" value="https://images.unsplash.com/photo-1518770660439-4636190af475?w=600&h=300&fit=crop"/>
                           </c:otherwise>
                       </c:choose>
                       <div class="category-card" style="background-image: url('${bgImage}');">
                           <div class="category-overlay">
                               <h5 class="category-name">${category.categoryName}</h5>
                               <p class="category-desc">${category.description}</p>
                           </div>
                       </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- Latest Products Section -->
<section class="products-section bg-light">
    <div class="container">
        <div class="section-header mb-4">
             <h2 class="section-title">Sản phẩm mới nhất</h2>
         </div>
        <div class="row">
            <c:forEach var="product" items="${latestProducts}">
                 <div class="col-md-3 col-sm-6 mb-4">
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
                            <p class="text-primary fw-bold">
                                <fmt:formatNumber value="${product.price}" pattern="#,###"/> đ
                            </p>
                            <p class="text-muted small">
                                <c:choose>
                                    <c:when test="${product.stockQuantity > 0}">
                                        <i class="fas fa-check-circle text-success"></i> Còn hàng
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-times-circle text-danger"></i> Hết hàng
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <div class="mt-auto">
                                <a href="${pageContext.request.contextPath}/product-detail?id=${product.productId}" 
                                   class="btn btn-outline-dark btn-sm w-100">
                                    Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        

    </div>
</section>
<jsp:include page="/includes/footer.jsp"/>
