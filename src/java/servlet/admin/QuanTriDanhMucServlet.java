package servlet.admin;

import dao.DanhMucDAO;
import model.DanhMuc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet Admin quản lý danh mục (CRUD)
 */
@WebServlet("/admin/categories")
public class QuanTriDanhMucServlet extends HttpServlet {
    
    private DanhMucDAO categoryDAO;
    
    @Override
    public void init() throws ServletException {
        categoryDAO = new DanhMucDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<DanhMuc> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                String categoryName = request.getParameter("categoryName");
                String description = request.getParameter("description");
                
                DanhMuc category = new DanhMuc(categoryName, description);
                boolean success = categoryDAO.addCategory(category);
                
                if (success) {
                    request.getSession().setAttribute("success", "Thêm danh mục thành công!");
                }
                
            } else if ("edit".equals(action)) {
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String categoryName = request.getParameter("categoryName");
                String description = request.getParameter("description");
                
                DanhMuc category = new DanhMuc();
                category.setCategoryId(categoryId);
                category.setCategoryName(categoryName);
                category.setDescription(description);
                
                boolean success = categoryDAO.updateCategory(category);
                
                if (success) {
                    request.getSession().setAttribute("success", "Cập nhật danh mục thành công!");
                }
                
            } else if ("delete".equals(action)) {
                int categoryId = Integer.parseInt(request.getParameter("id"));
                boolean success = categoryDAO.deleteCategory(categoryId);
                
                if (success) {
                    request.getSession().setAttribute("success", "Xóa danh mục thành công!");
                }
            }
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}
