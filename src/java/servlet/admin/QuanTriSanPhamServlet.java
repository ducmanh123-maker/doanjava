package servlet.admin;

import dao.DanhMucDAO;
import dao.SanPhamDAO;
import model.DanhMuc;
import model.SanPham;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet Admin quản lý sản phẩm (CRUD) - Upload ảnh đã bị tắt để đơn giản hóa
 */
@WebServlet("/admin/products")
public class QuanTriSanPhamServlet extends HttpServlet {

    private static final String DEFAULT_PRODUCT_IMAGE = "images/products/default.jpg";

    private SanPhamDAO productDAO;
    private DanhMucDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new SanPhamDAO();
        categoryDAO = new DanhMucDAO();
    }
    
    /**
     * GET: Hiển thị danh sách sản phẩm
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            showEditForm(request, response);
        } else if ("add".equals(action)) {
            showAddForm(request, response);
        } else {
            showProductList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("edit".equals(action)) {
            editProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }
    
    /**
     * Hiển thị danh sách sản phẩm
     */
    private void showProductList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<SanPham> products = productDAO.getAllProductsAdmin();
        request.setAttribute("products", products);
        
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị form thêm sản phẩm
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<DanhMuc> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
    }
    
    /**
     * Hiển thị form sửa sản phẩm
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int productId = Integer.parseInt(request.getParameter("id"));
        SanPham product = productDAO.getProductById(productId);
        
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }
        
        List<DanhMuc> categories = categoryDAO.getAllCategories();
        List<String> productImages = productDAO.getProductImages(productId);
        
        request.setAttribute("product", product);
        request.setAttribute("categories", categories);
        request.setAttribute("productImages", productImages);
        
        request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
    }
    
    /**
     * Thêm sản phẩm mới
     */
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            String status = request.getParameter("status");
            
            // Lấy đường dẫn ảnh từ input, nếu không nhập thì dùng mặc định
            String imageUrl = request.getParameter("imageUrl");
            if (imageUrl == null || imageUrl.isBlank()) {
                imageUrl = DEFAULT_PRODUCT_IMAGE;
            }

            SanPham product = new SanPham(categoryId, productName, description,
                price, stockQuantity, imageUrl);
            product.setStatus(status);
            
            int productId = productDAO.addProduct(product);
            boolean success = productId > 0;
            
            if (success) {
                request.getSession().setAttribute("success", "Thêm sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("error", "Có lỗi xảy ra khi thêm sản phẩm!");
            }
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
    
    /**
     * Sửa sản phẩm
     */
    private void editProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            String status = request.getParameter("status");
            
            SanPham product = productDAO.getProductById(productId);
            
            // Lấy đường dẫn ảnh từ input, nếu không nhập thì giữ ảnh cũ hoặc dùng mặc định
            String imageUrl = request.getParameter("imageUrl");
            if (imageUrl == null || imageUrl.isBlank()) {
                imageUrl = product.getImageUrl();
                if (imageUrl == null || imageUrl.isBlank()) {
                    imageUrl = DEFAULT_PRODUCT_IMAGE;
                }
            }
            
            product.setCategoryId(categoryId);
            product.setProductName(productName);
            product.setDescription(description);
            product.setPrice(price);
            product.setStockQuantity(stockQuantity);
            product.setImageUrl(imageUrl);
            product.setStatus(status);
            
            boolean success = productDAO.updateProduct(product);
            
            if (success) {
                request.getSession().setAttribute("success", "Cập nhật sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("error", "Có lỗi xảy ra khi cập nhật sản phẩm!");
            }
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
    
    /**
     * Xóa sản phẩm
     */
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            boolean success = productDAO.deleteProduct(productId);
            
            if (success) {
                request.getSession().setAttribute("success", "Xóa sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("error", "Có lỗi xảy ra khi xóa sản phẩm!");
            }
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
    
}
