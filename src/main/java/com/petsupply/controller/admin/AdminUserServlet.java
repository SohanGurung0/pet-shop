package com.petsupply.controller.admin;

import com.petsupply.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * AdminUserServlet — admin management of user accounts.
 *
 * GET /admin/users → list all users
 * GET /admin/users?action=approve&id=X → approve user
 * GET /admin/users?action=reject&id=X → reject user
 */
@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("approve".equals(action)) {
            int id = parseId(request.getParameter("id"));
            if (id > 0) {
                boolean ok = userService.approveUser(id);
                HttpSession s = request.getSession(true);
                s.setAttribute(ok ? "successMsg" : "errorMsg",
                        ok ? "User approved." : "Failed to approve user.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");

        } else if ("reject".equals(action)) {
            int id = parseId(request.getParameter("id"));
            if (id > 0) {
                boolean ok = userService.rejectUser(id);
                HttpSession s = request.getSession(true);
                s.setAttribute(ok ? "successMsg" : "errorMsg",
                        ok ? "User rejected." : "Failed to reject user.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");

        } else {
            // Default: list all users
            request.setAttribute("users", userService.getAllUsers());

            java.util.List<com.petsupply.model.User> pendingList = userService.getUsersByStatus("pending");
            request.setAttribute("pendingUserList", pendingList);
            request.setAttribute("pendingUsers", pendingList.size());

            request.getRequestDispatcher("/WEB-INF/views/admin/userList.jsp")
                    .forward(request, response);
        }
    }

    private int parseId(String idParam) {
        try {
            return Integer.parseInt(idParam);
        } catch (Exception e) {
            return -1;
        }
    }
}
