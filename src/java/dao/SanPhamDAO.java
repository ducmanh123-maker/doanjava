package dao;

import model.SanPham;
import util.KetNoiCSDL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class để thao tác với bảng products
 */
public class SanPhamDAO {

    private static final String DEFAULT_PRODUCT_IMAGE = "images/products/default.jpg";
    
    /**
     * Lấy tất cả products (active)
     */
    public List<SanPham> getAllProducts() {
        List<SanPham> products = new ArrayList<>();
        String sql = "SELECT p.*, c.ten_danh_muc " +
                     "FROM san_pham p " +
                     "LEFT JOIN danh_muc c ON p.danh_muc_id = c.danh_muc_id " +
                     "WHERE p.trang_thai = 'active' " +
                     "ORDER BY p.ngay_tao DESC";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi getAllProducts: " + e.getMessage());
        }
        
        return products;
    }
    
    /**
     * Lấy tất cả products (bao gồm inactive - cho admin)
     */
    public List<SanPham> getAllProductsAdmin() {
        List<SanPham> products = new ArrayList<>();
        String sql = "SELECT p.*, c.ten_danh_muc " +
                     "FROM san_pham p " +
                     "LEFT JOIN danh_muc c ON p.danh_muc_id = c.danh_muc_id " +
                     "ORDER BY p.ngay_tao DESC";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi getAllProductsAdmin: " + e.getMessage());
        }
        
        return products;
    }
    
    /**
     * Lấy product theo ID
     */
    public SanPham getProductById(int productId) {
        String sql = "SELECT p.*, c.ten_danh_muc " +
                     "FROM san_pham p " +
                     "LEFT JOIN danh_muc c ON p.danh_muc_id = c.danh_muc_id " +
                     "WHERE p.san_pham_id = ?";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractProductFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi getProductById: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Lấy products theo category
     */
    public List<SanPham> getProductsByCategory(int categoryId) {
        List<SanPham> products = new ArrayList<>();
        String sql = "SELECT p.*, c.ten_danh_muc " +
                     "FROM san_pham p " +
                     "LEFT JOIN danh_muc c ON p.danh_muc_id = c.danh_muc_id " +
                     "WHERE p.danh_muc_id = ? AND p.trang_thai = 'active' " +
                     "ORDER BY p.ngay_tao DESC";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi getProductsByCategory: " + e.getMessage());
        }
        
        return products;
    }
    
    /**
     * Tìm kiếm products theo tên
     */
    public List<SanPham> searchProducts(String keyword) {
        List<SanPham> products = new ArrayList<>();
        String sql = "SELECT p.*, c.ten_danh_muc " +
                     "FROM san_pham p " +
                     "LEFT JOIN danh_muc c ON p.danh_muc_id = c.danh_muc_id " +
                     "WHERE p.ten_san_pham LIKE ? AND p.trang_thai = 'active' " +
                     "ORDER BY p.ngay_tao DESC";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi searchProducts: " + e.getMessage());
        }
        
        return products;
    }
    
    /**
     * Lấy sản phẩm mới nhất (giới hạn số lượng)
     */
    public List<SanPham> getLatestProducts(int limit) {
        List<SanPham> products = new ArrayList<>();
        String sql = "SELECT p.*, c.ten_danh_muc " +
                     "FROM san_pham p " +
                     "LEFT JOIN danh_muc c ON p.danh_muc_id = c.danh_muc_id " +
                     "WHERE p.trang_thai = 'active' " +
                     "ORDER BY p.ngay_tao DESC " +
                     "LIMIT ?";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi getLatestProducts: " + e.getMessage());
        }
        
        return products;
    }
    
    /**
     * Thêm product mới
     */
    public int addProduct(SanPham product) {
        String sql = "INSERT INTO san_pham (danh_muc_id, ten_san_pham, mo_ta, gia, " +
                     "so_luong_ton, duong_dan_anh, trang_thai) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, product.getCategoryId());
            stmt.setString(2, product.getProductName());
            stmt.setString(3, product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getStockQuantity());
            stmt.setString(6, normalizeLocalImagePath(product.getImageUrl()));
            stmt.setString(7, product.getStatus());
            
            int affected = stmt.executeUpdate();
            if (affected <= 0) {
                return -1;
            }

            try (ResultSet keys = stmt.getGeneratedKeys()) {
                if (keys.next()) {
                    int productId = keys.getInt(1);
                    product.setProductId(productId);
                    return productId;
                }
            }

            return -1;
            
        } catch (SQLException e) {
            System.err.println("Lỗi addProduct: " + e.getMessage());
            return -1;
        }
    }

    /**
     * Thêm product mới kèm nhiều ảnh (transaction) 
     * @return productId mới hoặc -1 nếu lỗi
     */
    public int addProductWithImages(SanPham product, List<String> imageUrls) {
        // Complex multi-image product creation removed per user request.
        System.err.println("addProductWithImages removed: feature disabled in simplified demo");
        return -1;
    }

    /**
     * Thêm nhiều ảnh cho sản phẩm
     */
    public boolean addProductImages(int productId, List<String> imageUrls) {
        if (imageUrls == null || imageUrls.isEmpty()) {
            return true;
        }

        String sql = "INSERT INTO anh_san_pham (san_pham_id, duong_dan_anh, thu_tu) VALUES (?, ?, ?)";

        try (Connection conn = KetNoiCSDL.getConnection()) {
            int baseSortOrder = getNextImageSortOrder(conn, productId);

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                int sortOrder = baseSortOrder;
                for (String url : imageUrls) {
                    String normalized = normalizeLocalImagePath(url);
                    if (DEFAULT_PRODUCT_IMAGE.equals(normalized)) {
                        continue;
                    }

                    stmt.setInt(1, productId);
                    stmt.setString(2, normalized);
                    stmt.setInt(3, sortOrder++);
                    stmt.addBatch();
                }

                stmt.executeBatch();
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi addProductImages: " + e.getMessage());
            return false;
        }
    }

    /**
     * Lấy danh sách ảnh của sản phẩm (gallery)
     */
    public List<String> getProductImages(int productId) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT duong_dan_anh FROM anh_san_pham WHERE san_pham_id = ? ORDER BY thu_tu ASC, anh_id ASC";

        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String imageUrl = rs.getString("duong_dan_anh");
                    if (imageUrl == null || imageUrl.isBlank() || isExternalUrl(imageUrl)) {
                        continue;
                    }
                    images.add(imageUrl);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getProductImages: " + e.getMessage());
        }

        return images;
    }
    
    /**
     * Cập nhật product
     */
    public boolean updateProduct(SanPham product) {
        String sql = "UPDATE san_pham SET danh_muc_id = ?, ten_san_pham = ?, mo_ta = ?, " +
                     "gia = ?, so_luong_ton = ?, duong_dan_anh = ?, trang_thai = ? " +
                     "WHERE san_pham_id = ?";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, product.getCategoryId());
            stmt.setString(2, product.getProductName());
            stmt.setString(3, product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getStockQuantity());
            stmt.setString(6, normalizeLocalImagePath(product.getImageUrl()));
            stmt.setString(7, product.getStatus());
            stmt.setInt(8, product.getProductId());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi updateProduct: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Xóa product
     */
    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM san_pham WHERE san_pham_id = ?";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi deleteProduct: " + e.getMessage());
            return false;
        }
    }

    private int getNextImageSortOrder(Connection conn, int productId) throws SQLException {
        String sql = "SELECT COALESCE(MAX(thu_tu), -1) FROM anh_san_pham WHERE san_pham_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) + 1;
                }
            }
        }
        return 0;
    }
    
    /**
     * Cập nhật số lượng tồn kho
     */
    public boolean updateStock(int productId, int quantity) {
        String sql = "UPDATE san_pham SET so_luong_ton = so_luong_ton + ? WHERE san_pham_id = ?";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Lỗi updateStock: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Đếm tổng số products
     */
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM san_pham WHERE trang_thai = 'active'";
        
        try (Connection conn = KetNoiCSDL.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi getTotalProducts: " + e.getMessage());
        }
        
        return 0;
    }
    
    /**
     * Helper method: Chuyển ResultSet thành Product object
     */
    private SanPham extractProductFromResultSet(ResultSet rs) throws SQLException {
         SanPham product = new SanPham();
         product.setProductId(rs.getInt("san_pham_id"));
         product.setCategoryId(rs.getInt("danh_muc_id"));
         product.setProductName(rs.getString("ten_san_pham"));
         product.setDescription(rs.getString("mo_ta"));
         product.setPrice(rs.getDouble("gia"));
         product.setStockQuantity(rs.getInt("so_luong_ton"));
         String imageUrl = rs.getString("duong_dan_anh");
         if (imageUrl == null || imageUrl.isBlank()) {
             imageUrl = DEFAULT_PRODUCT_IMAGE;
         }
         // Cho phép URL từ internet hoặc đường dẫn tương đối
         product.setImageUrl(imageUrl);
         product.setStatus(rs.getString("trang_thai"));
         product.setCreatedAt(rs.getTimestamp("ngay_tao"));
         product.setUpdatedAt(rs.getTimestamp("ngay_cap_nhat"));
         
         // Thông tin từ JOIN
         product.setCategoryName(rs.getString("ten_danh_muc"));
         
         return product;
         }

         private static boolean isExternalUrl(String value) {
         String v = value.trim().toLowerCase();
         return v.startsWith("http://") || v.startsWith("https://") || v.startsWith("//");
         }

         private static String normalizeLocalImagePath(String imageUrl) {
          if (imageUrl == null || imageUrl.isBlank()) {
              return DEFAULT_PRODUCT_IMAGE;
          }
          // Cho phép URL từ internet hoặc đường dẫn tương đối
          return imageUrl.trim();
         }
         }
