package model;

import java.sql.Timestamp;

/**
 * Model class đại diện cho Product (Sản phẩm)
 */
public class SanPham {
    private int productId;
    private int categoryId;
    private String productName;
    private String description;
    private double price;
    private int stockQuantity;
    private String imageUrl;
    private String status; // "active" hoặc "inactive"
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Thông tin category (join table)
    private String categoryName;
    
    // Constructor mặc định
    public SanPham() {
    }
    
    // Constructor đầy đủ
    public SanPham(int productId, int categoryId, String productName, String description,
                   double price, int stockQuantity, String imageUrl, String status,
                   Timestamp createdAt, Timestamp updatedAt) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.imageUrl = imageUrl;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Constructor cho tạo mới
    public SanPham(int categoryId, String productName, String description,
                   double price, int stockQuantity, String imageUrl) {
        this.categoryId = categoryId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.imageUrl = imageUrl;
        this.status = "active"; // Mặc định là active
    }
    
    // Getters và Setters
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public int getStockQuantity() {
        return stockQuantity;
    }
    
    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    // Helper methods
    public boolean isActive() {
        return "active".equals(this.status);
    }
    
    public boolean isInStock() {
        return this.stockQuantity > 0;
    }
    
    public String getFormattedPrice() {
        return String.format("%,.0f đ", this.price);
    }
    
    @Override
    public String toString() {
        return "SanPham{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", price=" + price +
                ", stockQuantity=" + stockQuantity +
                ", status='" + status + '\'' +
                '}';
    }
}
