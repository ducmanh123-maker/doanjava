package model;

/**
 * Model class đại diện cho CartItem (Sản phẩm trong giỏ hàng)
 * Lưu trong Session, không lưu database
 */
public class SanPhamGioHang {
    private SanPham product;
    private int quantity;
    
    // Constructor mặc định
    public SanPhamGioHang() {
    }
    
    // Constructor
    public SanPhamGioHang(SanPham product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }
    
    // Getters và Setters
    public SanPham getProduct() {
        return product;
    }
    
    public void setProduct(SanPham product) {
        this.product = product;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    // Helper methods
    public double getSubtotal() {
        return product.getPrice() * quantity;
    }
    
    public String getFormattedSubtotal() {
        return String.format("%,.0f đ", getSubtotal());
    }
    
    public void increaseQuantity(int amount) {
        this.quantity += amount;
    }
    
    public void decreaseQuantity(int amount) {
        this.quantity -= amount;
        if (this.quantity < 1) {
            this.quantity = 1;
        }
    }
    
    // Thêm các getter tiện lợi cho JSP
    public int getProductId() {
        return product.getProductId();
    }
    
    public String getProductName() {
        return product.getProductName();
    }
    
    public double getUnitPrice() {
        return product.getPrice();
    }
    
    public String getImageUrl() {
        return product.getImageUrl();
    }
    
    @Override
    public String toString() {
        return "SanPhamGioHang{" +
                "product=" + product.getProductName() +
                ", quantity=" + quantity +
                ", subtotal=" + getSubtotal() +
                '}';
    }
}
