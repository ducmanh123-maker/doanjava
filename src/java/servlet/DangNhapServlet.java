package servlet;

import dao.NguoiDungDAO;
import model.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet xử lý đăng nhập
 */
@WebServlet("/login")
public class DangNhapServlet extends HttpServlet {
    
    private NguoiDungDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new NguoiDungDAO();
    }
    
    /**
     * GET: Hiển thị trang đăng nhập
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    /**
     * POST: Xử lý đăng nhập
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ username và password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra user trong database
         NguoiDung user = userDAO.getUserByUsername(username);
         
         if (user != null && password.equals(user.getPassword())) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            
            // Redirect theo role
            if (user.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
            
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", "Username hoặc password không đúng");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
