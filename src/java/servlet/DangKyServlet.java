package servlet;

import dao.NguoiDungDAO;
import model.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet xử lý đăng ký tài khoản
 */
@WebServlet("/register")
public class DangKyServlet extends HttpServlet {
    
    private NguoiDungDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new NguoiDungDAO();
    }
    
    /**
     * GET: Hiển thị trang đăng ký
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
    
    /**
     * POST: Xử lý đăng ký
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            setFormValues(request, username, fullName, email, phone, address);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            setFormValues(request, username, fullName, email, phone, address);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra username đã tồn tại
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Username đã tồn tại");
            setFormValues(request, username, fullName, email, phone, address);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra email đã tồn tại
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email đã được đăng ký");
            setFormValues(request, username, fullName, email, phone, address);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Tạo user mới
        NguoiDung newUser = new NguoiDung(username, password, 
                                fullName, email, phone, address);
        
        boolean success = userDAO.addUser(newUser);
        
        if (success) {
            // Đăng ký thành công
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Đăng ký thất bại
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại");
            setFormValues(request, username, fullName, email, phone, address);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
    
    /**
     * Helper method: Giữ lại giá trị form khi có lỗi
     */
    private void setFormValues(HttpServletRequest request, String username, 
                               String fullName, String email, String phone, String address) {
        request.setAttribute("username", username);
        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);
    }
}
