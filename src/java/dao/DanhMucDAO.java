package dao;

import model.DanhMuc;
import util.KetNoiCSDL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class để thao tác với bảng categories
 */
public class DanhMucDAO {
    
    /**
     * Lấy tất cả categories
     */
    public List<DanhMuc> getAllCategories() {
        List<DanhMuc> categories = new ArrayList<>();
        String sql = "SELECT * FROM danh_muc ORDER BY ten_danh_muc";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                categories.add(extractCategoryFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi getAllCategories: " + e.getMessage());
        }
        
        return categories;
    }
    
    /**
     * Lấy category theo ID
     */
    public DanhMuc getCategoryById(int categoryId) {
        String sql = "SELECT * FROM danh_muc WHERE danh_muc_id = ?";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractCategoryFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi getCategoryById: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Thêm category mới
     */
    public boolean addCategory(DanhMuc category) {
        String sql = "INSERT INTO danh_muc (ten_danh_muc, mo_ta) VALUES (?, ?)";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category.getCategoryName());
            stmt.setString(2, category.getDescription());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi addCategory: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Cập nhật category
     */
    public boolean updateCategory(DanhMuc category) {
        String sql = "UPDATE danh_muc SET ten_danh_muc = ?, mo_ta = ? WHERE danh_muc_id = ?";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category.getCategoryName());
            stmt.setString(2, category.getDescription());
            stmt.setInt(3, category.getCategoryId());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi updateCategory: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Xóa category
     */
    public boolean deleteCategory(int categoryId) {
        String sql = "DELETE FROM danh_muc WHERE danh_muc_id = ?";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi deleteCategory: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Đếm tổng số categories
     */
    public int getTotalCategories() {
        String sql = "SELECT COUNT(*) FROM danh_muc";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi getTotalCategories: " + e.getMessage());
        }
        
        return 0;
    }
    
    /**
     * Helper method: Chuyển ResultSet thành Category object
     */
    private DanhMuc extractCategoryFromResultSet(ResultSet rs) throws SQLException {
        DanhMuc category = new DanhMuc();
        category.setCategoryId(rs.getInt("danh_muc_id"));
        category.setCategoryName(rs.getString("ten_danh_muc"));
        category.setDescription(rs.getString("mo_ta"));
        category.setCreatedAt(rs.getTimestamp("ngay_tao"));
        category.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
        return category;
    }
}
