package servlet.admin;

import dao.DanhMucDAO;
import dao.DonHangDAO;
import dao.NguoiDungDAO;
import dao.SanPhamDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet Admin Dashboard - Trang tổng quan
 */
@WebServlet("/admin/dashboard")
public class QuanTriTongQuanServlet extends HttpServlet {

    private SanPhamDAO productDAO;
    private DanhMucDAO categoryDAO;
    private DonHangDAO orderDAO;
    private NguoiDungDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new SanPhamDAO();
        categoryDAO = new DanhMucDAO();
        orderDAO = new DonHangDAO();
        userDAO = new NguoiDungDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy thống kê
        int totalProducts = productDAO.getTotalProducts();
        int totalCategories = categoryDAO.getTotalCategories();
        int totalOrders = orderDAO.getTotalOrders();
        int totalUsers = userDAO.getTotalUsers();
        double totalRevenue = orderDAO.getTotalRevenue();
        
        // Set attributes
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalRevenue", totalRevenue);
        
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
