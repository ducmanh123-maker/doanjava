package servlet;

import dao.SanPhamDAO;
import model.SanPham;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet hiển thị chi tiết sản phẩm
 */
@WebServlet("/product-detail")
public class ChiTietSanPhamServlet extends HttpServlet {
    
    private SanPhamDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new SanPhamDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productIdStr = request.getParameter("id");
        
        if (productIdStr == null || productIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            SanPham product = productDAO.getProductById(productId);
            
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }
            
            List<String> productImages = productDAO.getProductImages(productId);
            request.setAttribute("product", product);
            request.setAttribute("productImages", productImages);
            request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}
