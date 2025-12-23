package servlet.admin;

import dao.DonHangDAO;
import model.DonHang;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet Admin quản lý đơn hàng (CRUD)
 */
@WebServlet("/admin/orders")
public class QuanTriDonHangServlet extends HttpServlet {

    private DonHangDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new DonHangDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("view".equals(action)) {
            viewOrderDetail(request, response);
        } else {
            showOrderList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {
            updateOrderStatus(request, response);
        } else if ("delete".equals(action)) {
            deleteOrder(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }

    /**
     * Hiển thị danh sách đơn hàng
     */
    private void showOrderList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<DonHang> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }

    /**
     * Hiển thị chi tiết đơn hàng
     */
    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            DonHang order = orderDAO.getOrderById(orderId);

            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }

    /**
     * Cập nhật trạng thái đơn hàng
     */
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            boolean success = orderDAO.updateOrderStatus(orderId, status);

            if (success) {
                request.getSession().setAttribute("success", "Cập nhật trạng thái thành công!");
            } else {
                request.getSession().setAttribute("error", "Có lỗi xảy ra khi cập nhật!");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    /**
     * Xóa đơn hàng
     */
    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(request.getParameter("id"));

            boolean success = orderDAO.deleteOrder(orderId);

            if (success) {
                request.getSession().setAttribute("success", "Xóa đơn hàng thành công!");
            } else {
                request.getSession().setAttribute("error", "Có lỗi xảy ra khi xóa!");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
