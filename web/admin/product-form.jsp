<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product != null ? 'Sửa' : 'Thêm'} sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid">
            <span class="navbar-brand">
                ${product != null ? 'Sửa' : 'Thêm'} sản phẩm
            </span>
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-sm btn-outline-light">Quay lại</a>
        </div>
    </nav>
    
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
    
    <div class="container p-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/admin/products">
                            <input type="hidden" name="action" value="${product != null ? 'edit' : 'add'}">
                            <c:if test="${product != null}">
                                <input type="hidden" name="productId" value="${product.productId}">
                            </c:if>
                            
                            <div class="mb-3">
                                 <label class="form-label">Danh mục <span class="text-danger">*</span></label>
                                 <select class="form-select" name="categoryId" required>
                                     <option value="">Chọn danh mục</option>
                                     <c:forEach var="category" items="${categories}">
                                         <option value="${category.categoryId}" 
                                                 ${product != null && product.categoryId == category.categoryId ? 'selected' : ''}>
                                             ${category.categoryName}
                                         </option>
                                     </c:forEach>
                                 </select>
                             </div>
                            
                            <div class="mb-3">
                                 <label class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                                 <input type="text" class="form-control" name="productName" 
                                        value="${product != null ? product.productName : ''}" required>
                             </div>
                             
                             <div class="mb-3">
                                 <label class="form-label">Mô tả</label>
                                 <textarea class="form-control" name="description" rows="3">${product != null ? product.description : ''}</textarea>
                             </div>
                             
                             <div class="row">
                                 <div class="col-md-6 mb-3">
                                     <label class="form-label">Giá <span class="text-danger">*</span></label>
                                     <input type="number" class="form-control" name="price" 
                                            value="${product != null ? product.price : ''}" step="1000" min="0" required>
                                 </div>
                                 
                                 <div class="col-md-6 mb-3">
                                     <label class="form-label">Tồn kho <span class="text-danger">*</span></label>
                                     <input type="number" class="form-control" name="stockQuantity" 
                                            value="${product != null ? product.stockQuantity : ''}" min="0" required>
                                 </div>
                             </div>
                            
                            <div class="mb-3">
                                 <label class="form-label">Đường dẫn ảnh</label>
                                 <input type="text" class="form-control" name="imageUrl" 
                                        value="${product != null ? product.imageUrl : ''}" 
                                        placeholder="Nhập đường dẫn ảnh từ internet hoặc thư mục (vd: images/products/anh1.jpg hoặc https://example.com/image.jpg)">
                                 <small class="text-muted">Để trống để sử dụng ảnh mặc định</small>
                                 
                                 <c:if test="${product != null && not empty product.imageUrl}">
                                     <div class="mt-3">
                                         <label class="form-label">Xem trước ảnh hiện tại:</label>
                                         <div>
                                             <img id="currentImage" 
                                                  style="max-width: 200px; max-height: 200px; object-fit: contain;"
                                                  class="rounded border p-2"
                                                  onerror="this.src='${pageContext.request.contextPath}/images/products/default.jpg'">
                                         </div>
                                     </div>
                                 </c:if>
                             </div>
                            
                            <div class="mb-3">
                                 <label class="form-label">Trạng thái</label>
                                 <select class="form-select" name="status">
                                     <option value="active" ${product != null && product.status == 'active' ? 'selected' : ''}>Active</option>
                                     <option value="inactive" ${product != null && product.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                                 </select>
                             </div>
                             
                             <div class="d-flex gap-2">
                                 <button type="submit" class="btn btn-primary">Lưu</button>
                                 <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Hủy</a>
                             </div>
                            </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const contextPath = '${pageContext.request.contextPath}';
        const imageUrlInput = document.querySelector('input[name="imageUrl"]');
        
        // Hiển thị ảnh hiện tại nếu có
        const currentImage = document.getElementById('currentImage');
        if (currentImage && imageUrlInput.value) {
            currentImage.src = getImageUrl(imageUrlInput.value);
        }
        
        // Xem trước ảnh khi nhập link
        if (imageUrlInput) {
            imageUrlInput.addEventListener('change', function() {
                updateImagePreview(this.value);
            });
        }
        
        function getImageUrl(url) {
            // Nếu là URL từ internet (bắt đầu bằng http:// hoặc https://)
            if (url.startsWith('http://') || url.startsWith('https://')) {
                return url;
            }
            // Nếu là đường dẫn tương đối, thêm contextPath
            return contextPath + '/' + url;
        }
        
        function updateImagePreview(url) {
            if (!url) return;
            let previewDiv = document.getElementById('imagePreview');
            if (!previewDiv) {
                previewDiv = document.createElement('div');
                previewDiv.id = 'imagePreview';
                previewDiv.className = 'mt-3';
                imageUrlInput.parentElement.appendChild(previewDiv);
            }
            previewDiv.innerHTML = `
                <label class="form-label">Xem trước ảnh:</label>
                <div>
                    <img src="\${getImageUrl(url)}"
                         style="max-width: 200px; max-height: 200px; object-fit: contain;"
                         class="rounded border p-2"
                         onerror="this.src='\${contextPath}/images/products/default.jpg'">
                </div>
            `;
        }
    </script>
</body>
</html>
