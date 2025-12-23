package model;

/**
 * Model class đại diện cho OrderItem (Chi tiết đơn hàng)
 */
public class ChiTietDonHang {
    private int orderItemId;
    private int orderId;
    private int productId;
    private int quantity;
    private double price; // Giá tại thời điểm mua
    private double subtotal; // quantity * price
    
    // Thông tin product (join table)
    private String productName;
    private String imageUrl;
    
    // Constructor mặc định
    public ChiTietDonHang() {
    }
    
    // Constructor đầy đủ
    public ChiTietDonHang(int orderItemId, int orderId, int productId, 
                     int quantity, double price, double subtotal) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.subtotal = subtotal;
    }
    
    // Constructor cho tạo mới
    public ChiTietDonHang(int orderId, int productId, int quantity, double price) {
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.subtotal = quantity * price;
    }
    
    // Getters và Setters
    public int getOrderItemId() {
        return orderItemId;
    }
    
    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.subtotal = this.quantity * this.price; // Tự động tính lại subtotal
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
        this.subtotal = this.quantity * this.price; // Tự động tính lại subtotal
    }
    
    public double getSubtotal() {
        return subtotal;
    }
    
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    // Helper methods
    public String getFormattedPrice() {
        return String.format("%,.0f đ", this.price);
    }
    
    public String getFormattedSubtotal() {
        return String.format("%,.0f đ", this.subtotal);
    }
    
    @Override
    public String toString() {
        return "ChiTietDonHang{" +
                "orderItemId=" + orderItemId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", price=" + price +
                ", subtotal=" + subtotal +
                '}';
    }
}
