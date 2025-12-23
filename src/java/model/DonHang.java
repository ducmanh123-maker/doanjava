package model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Model class đại diện cho Order (Đơn hàng)
 */
public class DonHang {
    private int orderId;
    private int userId;
    private double totalAmount;
    private String status; // "pending", "processing", "shipped", "delivered", "cancelled"
    private String shippingAddress;
    private String phone;
    private String notes;
    private String paymentMethod; // "cod", "bank", "card"
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Thông tin user (join table)
    private String customerName;
    private String customerEmail;
    
    // Danh sách items trong đơn hàng
    private List<ChiTietDonHang> orderItems;
    
    // Constructor mặc định
    public DonHang() {
        this.orderItems = new ArrayList<>();
    }
    
    // Constructor đầy đủ
    public DonHang(int orderId, int userId, double totalAmount, String status,
                 String shippingAddress, String phone, String notes,
                 Timestamp createdAt, Timestamp updatedAt) {
        this.orderId = orderId;
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.shippingAddress = shippingAddress;
        this.phone = phone;
        this.notes = notes;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.orderItems = new ArrayList<>();
    }
    
    // Constructor cho tạo mới
    public DonHang(int userId, double totalAmount, String shippingAddress, String phone, String notes) {
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.phone = phone;
        this.notes = notes;
        this.status = "pending"; // Mặc định là pending
        this.orderItems = new ArrayList<>();
    }
    
    // Getters và Setters
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getShippingAddress() {
        return shippingAddress;
    }
    
    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
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
    
    public String getCustomerName() {
        return customerName;
    }
    
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    
    public String getCustomerEmail() {
        return customerEmail;
    }
    
    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
    
    public List<ChiTietDonHang> getOrderItems() {
        return orderItems;
    }
    
    public void setOrderItems(List<ChiTietDonHang> orderItems) {
        this.orderItems = orderItems;
    }
    
    public void addOrderItem(ChiTietDonHang item) {
        this.orderItems.add(item);
    }
    
    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    // Helper methods
    public String getStatusText() {
        switch (this.status) {
            case "pending": return "Chờ xử lý";
            case "processing": return "Đang xử lý";
            case "shipped": return "Đã gửi hàng";
            case "delivered": return "Đã giao hàng";
            case "cancelled": return "Đã hủy";
            default: return this.status;
        }
    }
    
    public String getFormattedTotal() {
        return String.format("%,.0f đ", this.totalAmount);
    }
    
    @Override
    public String toString() {
        return "DonHang{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                '}';
    }
}
