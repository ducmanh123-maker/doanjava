/**
 * Electronics Shop - Main JavaScript File
 */

// Auto-dismiss alerts after 5 seconds
document.addEventListener('DOMContentLoaded', function() {
    const alerts = document.querySelectorAll('.alert-dismissible');
    
    alerts.forEach(function(alert) {
        setTimeout(function() {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 5000);
    });
    
    // Initialize carousel with custom settings
    const carousel = document.querySelector('#mainCarousel');
    if (carousel) {
        const bsCarousel = new bootstrap.Carousel(carousel, {
            interval: 4000,  // 4 giây mỗi slide (auto-run)
            wrap: true,      // Lặp lại từ đầu
            pause: false     // Không dừng khi hover — chạy tự động
        });
    }
});

// Confirm delete actions
function confirmDelete(message) {
    return confirm(message || 'Bạn có chắc chắn muốn xóa?');
}

// Format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}

// Add to cart with animation
function addToCartWithAnimation(button) {
    const originalText = button.innerHTML;
    button.innerText = 'Đang thêm...';
    button.disabled = true;

    setTimeout(function() {
        button.innerText = 'Đã thêm!';
        setTimeout(function() {
            button.innerHTML = originalText;
            button.disabled = false;
        }, 800);
    }, 500);
}

// Image preview for file upload
function previewImage(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const preview = document.getElementById('imagePreview');
            if (preview) {
                preview.src = e.target.result;
                preview.style.display = 'block';
            }
        }
        reader.readAsDataURL(input.files[0]);
    }
}
