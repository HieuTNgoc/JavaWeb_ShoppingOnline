/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllerClient;

import entity.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOCustomer;
import model.DAOProduct;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ControllerHome", urlPatterns = {"/ControllerHome"})
public class ControllerHome extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            if (action == null) {
                action = "home";
            }
            if (action.equals("login")) {
                login(request, response);
            }
            if (action.equals("logout")) {
                HttpSession session = request.getSession();
                session.invalidate();
                dispath(request, response, "client/home.jsp");
            }
            if (action.equals("home")) {
                home(request, response);
            }
            if (action.equals("addAcc")) {
                addAcc(request, response);
            }
            if (action.equals("viewAcc")) {
                response.sendRedirect("ControllerHome?action=home");
            }

        }
    }

    private void home(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOProduct dao = new DAOProduct();
            ResultSet rs = null;
            String submit = request.getParameter("submit");
            if (submit == null) {
                rs = dao.getData("select * from Product join Category on Product.cateID=Category.cateID");
            } else {
                String name = request.getParameter("name");
                String orderby = request.getParameter("Sort");
                String sql = "select * from Product join Category on Product.cateID=Category.cateID where pname like '%" + name + "%'";
                if (orderby != null) {
                    sql += " order by price " + orderby;
                }
                rs = dao.getData(sql);
            }
            request.setAttribute("rs", rs);
            dispath(request, response, "client/home.jsp");
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOCustomer dao = new DAOCustomer();
            String lgCheck = "";
            String link = "";
            String cid = null;
            HttpSession session = request.getSession();
            java.util.Enumeration em = session.getAttributeNames();
            if (em.hasMoreElements()) {
                cid = em.nextElement().toString();
            }
            if (cid != null) {
                dispath(request, response, "client/home.jsp");
            }
            if (cid == null) {
                String login = request.getParameter("login");
                if (login != null) {
                    String name = request.getParameter("username");
                    String password = request.getParameter("password");
                    if (password.length() < 8) {
                        lgCheck = "Password must be more than 8 characters! Try again!";
                    }
                    ResultSet rs = dao.getData("select * from Customer where username='" + name + "' and password='" + password + "'");
                    try {
                        if (rs.next()) {
                            cid = rs.getString(1);
                            session.setAttribute(cid, "1");
                            lgCheck = "Login successful! Go to your Home page.";
                            link = "ControllerHome?action=home";
                        } else {
                            lgCheck = "Wrong info! Try again!";
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ControllerHome.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
            request.setAttribute("link", link);
            request.setAttribute("lgCheck", lgCheck);
            dispath(request, response, "client/login.jsp");

        }
    }

    private void addAcc(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOCustomer dao = new DAOCustomer();
            String submit = request.getParameter("submit");

            if (submit == null) {
                dispath(request, response, "client/signup.jsp");
            } else {
                String altt = null;
                String name = request.getParameter("cname");
                String phone = request.getParameter("cphone");
                String address = request.getParameter("address");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String status = request.getParameter("status");
                if (isEmpty(name) || isEmpty(phone) || isEmpty(address) || isEmpty(username)
                        || isEmpty(password) || status == null) {
                    altt = "Information cannot be left blank!";
                    request.setAttribute("altIns", altt);
                    dispath(request, response, "client/signup.jsp");
                }
                if (checkPhone(phone) == false) {
                    altt = "Wrong format of phone number!";
                    request.setAttribute("altIns", altt);
                    dispath(request, response, "client/signup.jsp");
                }
                ResultSet rs = dao.getData("select * from Customer");
                try {
                    while (rs.next()) {
                        if (username.equals(rs.getString(5))) {
                            altt = "Username already exists!";
                            request.setAttribute("altIns", altt);
                            dispath(request, response, "client/signup.jsp");
                        }
                        break;
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerHome.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (password.length() < 8) {
                    altt = "Password must be more than 8 characters!";
                    request.setAttribute("altIns", altt);
                    dispath(request, response, "client/signup.jsp");
                }
                dao.addCustomer(new Customer(name, phone, address, username, password, Integer.parseInt(status)));
                altt = "Insert successful! New account: " + username;
                String link = "ControllerHome?action=login";
                request.setAttribute("link", link);
                request.setAttribute("altIns", altt);
                dispath(request, response, "client/signup.jsp");
            }
        }
    }

    private boolean isEmpty(String str) {
        return str == null || str.isEmpty() || str.equals("");
    }

    private boolean checkPhone(String phone) {
        return phone.matches("^0[0-9]{9}$");
    }

    private void dispath(HttpServletRequest request, HttpServletResponse response,
            String url) throws ServletException, IOException {
        RequestDispatcher disp = request.getRequestDispatcher(url);
        disp.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
