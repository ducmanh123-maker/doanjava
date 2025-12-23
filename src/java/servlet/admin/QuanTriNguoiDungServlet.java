package servlet.admin;

import dao.NguoiDungDAO;
import model.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet Admin quản lý người dùng
 */
@WebServlet("/admin/users")
public class QuanTriNguoiDungServlet extends HttpServlet {
    
    private NguoiDungDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new NguoiDungDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<NguoiDung> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        
        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("delete".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("id"));
                boolean success = userDAO.deleteUser(userId);
                
                if (success) {
                    request.getSession().setAttribute("success", "Xóa người dùng thành công!");
                }
            }
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
