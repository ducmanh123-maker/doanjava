package dao;

import model.NguoiDung;
import util.KetNoiCSDL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class quản lý người dùng (User)
 */
public class NguoiDungDAO {

    /**
     * Lấy user theo ID
     */
    public NguoiDung getUserById(int userId) {
        String sql = "SELECT * FROM nguoi_dung WHERE nguoi_dung_id = ?";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getUserById: " + e.getMessage());
        }
        return null;
    }

    /**
     * Lấy user theo username
     */
    public NguoiDung getUserByUsername(String username) {
        String sql = "SELECT * FROM nguoi_dung WHERE ten_dang_nhap = ?";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getUserByUsername: " + e.getMessage());
        }
        return null;
    }

    /**
     * Tạo user mới
     */
    public boolean addUser(NguoiDung user) {
        return createUser(user);
    }

    /**
     * Tạo user mới
     */
    public boolean createUser(NguoiDung user) {
        String sql = "INSERT INTO nguoi_dung (ten_dang_nhap, mat_khau, ho_ten, email, so_dien_thoai, dia_chi, vai_tro) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone() != null ? user.getPhone() : "");
            stmt.setString(6, user.getAddress() != null ? user.getAddress() : "");
            stmt.setString(7, user.getRole() != null ? user.getRole() : "customer");
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi createUser: " + e.getMessage());
        }
        return false;
    }

    /**
     * Cập nhật user
     */
    public boolean updateUser(NguoiDung user) {
        String sql = "UPDATE nguoi_dung SET ho_ten = ?, email = ?, so_dien_thoai = ?, dia_chi = ?, mat_khau = ? " +
                     "WHERE nguoi_dung_id = ?";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone() != null ? user.getPhone() : "");
            stmt.setString(4, user.getAddress() != null ? user.getAddress() : "");
            stmt.setString(5, user.getPassword());
            stmt.setInt(6, user.getUserId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi updateUser: " + e.getMessage());
        }
        return false;
    }

    /**
     * Kiểm tra username đã tồn tại
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM nguoi_dung WHERE ten_dang_nhap = ?";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi isUsernameExists: " + e.getMessage());
        }
        return false;
    }

    /**
     * Kiểm tra email đã tồn tại
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM nguoi_dung WHERE email = ?";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi isEmailExists: " + e.getMessage());
        }
        return false;
    }

    /**
     * Xóa user theo ID
     */
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM nguoi_dung WHERE nguoi_dung_id = ?";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi deleteUser: " + e.getMessage());
        }
        return false;
    }

    /**
     * Lấy tất cả users
     */
    public List<NguoiDung> getAllUsers() {
        List<NguoiDung> users = new ArrayList<>();
        String sql = "SELECT * FROM nguoi_dung ORDER BY nguoi_dung_id DESC";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getAllUsers: " + e.getMessage());
        }
        return users;
    }

    /**
     * Tìm user theo từ khóa
     */
    public List<NguoiDung> searchUsers(String keyword) {
        List<NguoiDung> users = new ArrayList<>();
        String sql = "SELECT * FROM nguoi_dung WHERE ho_ten LIKE ? OR email LIKE ? OR ten_dang_nhap LIKE ? " +
                     "ORDER BY nguoi_dung_id DESC";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi searchUsers: " + e.getMessage());
        }
        return users;
    }

    /**
     * Lấy tổng số users
     */
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM nguoi_dung";
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi getTotalUsers: " + e.getMessage());
        }
        
        return 0;
    }

    /**
     * Helper method: Chuyển ResultSet thành User object
     */
    private NguoiDung extractUserFromResultSet(ResultSet rs) throws SQLException {
        NguoiDung user = new NguoiDung();
        user.setUserId(rs.getInt("nguoi_dung_id"));
        user.setUsername(rs.getString("ten_dang_nhap"));
        user.setPassword(rs.getString("mat_khau"));
        user.setFullName(rs.getString("ho_ten"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("so_dien_thoai"));
        user.setAddress(rs.getString("dia_chi"));
        user.setRole(rs.getString("vai_tro"));
        user.setCreatedAt(rs.getTimestamp("ngay_tao"));
        user.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
        return user;
    }
}
