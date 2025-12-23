package dao;

import model.DonHang;
import model.ChiTietDonHang;
import util.KetNoiCSDL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class quản lý đơn hàng
 */
public class DonHangDAO {
    
    private static final String DEFAULT_PRODUCT_IMAGE = "/images/default-product.png";

    /**
     * Tạo đơn hàng mới
     */
    public int createOrder(DonHang order, List<ChiTietDonHang> items) {
        String orderSql = "INSERT INTO don_hang (nguoi_dung_id, tong_tien, trang_thai, dia_chi_giao_hang, so_dien_thoai, ghi_chu) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
        String itemSql = "INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, gia, thanh_tien) " +
                        "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = KetNoiCSDL.getConnection()) {
            conn.setAutoCommit(false);
            
            System.out.println("=== Bắt đầu tạo đơn hàng ===");
            System.out.println("UserID: " + order.getUserId());
            System.out.println("Tổng tiền: " + order.getTotalAmount());
            System.out.println("Số items: " + items.size());
            
            // Insert order
            try (PreparedStatement stmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, order.getUserId());
                stmt.setDouble(2, order.getTotalAmount());
                stmt.setString(3, order.getStatus());
                stmt.setString(4, order.getShippingAddress());
                stmt.setString(5, order.getPhone());
                stmt.setString(6, order.getNotes());
                
                stmt.executeUpdate();
                
                ResultSet rs = stmt.getGeneratedKeys();
                int orderId = 0;
                if (rs.next()) {
                    orderId = rs.getInt(1);
                    System.out.println("Tạo đơn hàng thành công, OrderID: " + orderId);
                }
                
                // Insert items
                if (orderId > 0) {
                    try (PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {
                        for (ChiTietDonHang item : items) {
                            itemStmt.setInt(1, orderId);
                            itemStmt.setInt(2, item.getProductId());
                            itemStmt.setInt(3, item.getQuantity());
                            itemStmt.setDouble(4, item.getPrice());
                            // Tính thanh_tien = quantity * price
                            itemStmt.setDouble(5, item.getQuantity() * item.getPrice());
                            itemStmt.addBatch();
                        }
                        itemStmt.executeBatch();
                        System.out.println("Thêm " + items.size() + " items thành công");
                    }
                    
                    conn.commit();
                    System.out.println("=== Commit thành công ===");
                    return orderId;
                } else {
                    System.err.println("Lỗi: Không lấy được OrderID");
                    conn.rollback();
                }
            }
            
            conn.rollback();
            return 0;
        } catch (SQLException e) {
            System.err.println("Lỗi createOrder: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy đơn hàng theo ID
     */
    public DonHang getOrderById(int orderId) {
        String sql = "SELECT dh.*, nd.ho_ten, nd.email FROM don_hang dh " +
                    "JOIN nguoi_dung nd ON dh.nguoi_dung_id = nd.nguoi_dung_id " +
                    "WHERE dh.don_hang_id = ?";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                DonHang order = extractOrderFromResultSet(rs);
                // Tải danh sách items cho đơn hàng
                order.setOrderItems(getOrderItems(orderId));
                return order;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getOrderById: " + e.getMessage());
        }
        return null;
    }

    /**
     * Lấy tất cả đơn hàng của user
     */
    public List<DonHang> getOrdersByUserId(int userId) {
        List<DonHang> orders = new ArrayList<>();
        String sql = "SELECT dh.*, nd.ho_ten, nd.email FROM don_hang dh " +
                    "JOIN nguoi_dung nd ON dh.nguoi_dung_id = nd.nguoi_dung_id " +
                    "WHERE dh.nguoi_dung_id = ? ORDER BY dh.ngay_tao DESC";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getOrdersByUserId: " + e.getMessage());
        }
        return orders;
    }

    /**
     * Lấy tất cả đơn hàng
     */
    public List<DonHang> getAllOrders() {
        List<DonHang> orders = new ArrayList<>();
        String sql = "SELECT dh.*, nd.ho_ten, nd.email FROM don_hang dh " +
                    "JOIN nguoi_dung nd ON dh.nguoi_dung_id = nd.nguoi_dung_id " +
                    "ORDER BY dh.ngay_tao DESC";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getAllOrders: " + e.getMessage());
        }
        return orders;
    }

    /**
     * Cập nhật trạng thái đơn hàng
     */
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE don_hang SET trang_thai = ? WHERE don_hang_id = ?";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi updateOrderStatus: " + e.getMessage());
        }
        return false;
    }

    /**
     * Xóa đơn hàng
     */
    public boolean deleteOrder(int orderId) {
        String itemSql = "DELETE FROM chi_tiet_don_hang WHERE don_hang_id = ?";
        String orderSql = "DELETE FROM don_hang WHERE don_hang_id = ?";
        
        try (Connection conn = KetNoiCSDL.getConnection()) {
            conn.setAutoCommit(false);
            
            try (PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {
                itemStmt.setInt(1, orderId);
                itemStmt.executeUpdate();
            }
            
            try (PreparedStatement orderStmt = conn.prepareStatement(orderSql)) {
                orderStmt.setInt(1, orderId);
                orderStmt.executeUpdate();
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            System.err.println("Lỗi deleteOrder: " + e.getMessage());
        }
        return false;
    }

    /**
     * Lấy chi tiết đơn hàng
     */
    public List<ChiTietDonHang> getOrderItems(int orderId) {
        List<ChiTietDonHang> items = new ArrayList<>();
        String sql = "SELECT ct.*, sp.ten_san_pham, sp.duong_dan_anh FROM chi_tiet_don_hang ct " +
                    "JOIN san_pham sp ON ct.san_pham_id = sp.san_pham_id " +
                    "WHERE ct.don_hang_id = ?";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                ChiTietDonHang item = new ChiTietDonHang();
                item.setOrderItemId(rs.getInt("chi_tiet_id"));
                item.setOrderId(rs.getInt("don_hang_id"));
                item.setProductId(rs.getInt("san_pham_id"));
                item.setQuantity(rs.getInt("so_luong"));
                item.setPrice(rs.getDouble("gia"));
                item.setSubtotal(rs.getDouble("thanh_tien"));
                item.setProductName(rs.getString("ten_san_pham"));
                
                String imageUrl = rs.getString("duong_dan_anh");
                if (imageUrl == null || imageUrl.isBlank()) {
                    imageUrl = DEFAULT_PRODUCT_IMAGE;
                }
                item.setImageUrl(imageUrl);
                
                items.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getOrderItems: " + e.getMessage());
        }
        return items;
    }

    /**
     * Lấy tổng số đơn hàng
     */
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM don_hang";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getTotalOrders: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Lấy tổng doanh thu
     */
    public double getTotalRevenue() {
        String sql = "SELECT SUM(tong_tien) FROM don_hang";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getTotalRevenue: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Helper method: Chuyển ResultSet thành Order object
     */
    private DonHang extractOrderFromResultSet(ResultSet rs) throws SQLException {
        DonHang order = new DonHang();
        order.setOrderId(rs.getInt("don_hang_id"));
        order.setUserId(rs.getInt("nguoi_dung_id"));
        order.setTotalAmount(rs.getDouble("tong_tien"));
        order.setStatus(rs.getString("trang_thai"));
        order.setShippingAddress(rs.getString("dia_chi_giao_hang"));
        order.setPhone(rs.getString("so_dien_thoai"));
        order.setNotes(rs.getString("ghi_chu"));
        order.setCreatedAt(rs.getTimestamp("ngay_tao"));
        order.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
        
        // Thông tin từ JOIN
        order.setCustomerName(rs.getString("ho_ten"));
        order.setCustomerEmail(rs.getString("email"));
        
        return order;
    }
}
