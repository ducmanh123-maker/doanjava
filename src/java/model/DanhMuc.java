package model;

import java.sql.Timestamp;

/**
 * Model class đại diện cho Category (Danh mục sản phẩm)
 */
public class DanhMuc {
    private int categoryId;
    private String categoryName;
    private String description;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructor mặc định
    public DanhMuc() {
    }
    
    // Constructor đầy đủ
    public DanhMuc(int categoryId, String categoryName, String description, 
                    Timestamp createdAt, Timestamp updatedAt) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Constructor cho tạo mới
    public DanhMuc(String categoryName, String description) {
        this.categoryName = categoryName;
        this.description = description;
    }
    
    // Getters và Setters
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
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
    
    @Override
    public String toString() {
        return "DanhMuc{" +
                "categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
