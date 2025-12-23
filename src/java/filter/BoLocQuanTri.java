package filter;

import model.NguoiDung;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter kiểm tra quyền admin
 * Chặn truy cập vào trang admin nếu không phải admin
 */
@WebFilter("/admin/*")
public class BoLocQuanTri implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        // Kiểm tra quyền admin
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        if (!user.isAdmin()) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/");
            return;
        }
        
        // Cho phép tiếp tục
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
    }
}
