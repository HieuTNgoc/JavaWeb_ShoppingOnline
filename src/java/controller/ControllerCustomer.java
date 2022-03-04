/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

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

/**
 *
 * @author Admin
 */
@WebServlet(name = "ControllerCustomer", urlPatterns = {"/ControllerCustomer"})
public class ControllerCustomer extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            DAOCustomer dao = new DAOCustomer();
            String action = request.getParameter("action");
            if (action == null) {
                action = "home";
            }
            HttpSession session = request.getSession();
            java.util.Enumeration em = session.getAttributeNames();
            if (!em.hasMoreElements() && !action.equals("login")) {
                action = "home";
            }
            //check login
            if (action.equals("home")) {
                dispath(request, response, "admin/homeAd.jsp");
            }
            if (action.equals("show")) {
                show(request, response);
            }
            if (action.equals("update")) {
                update(request, response);
            }
            if (action.equals("delete")) {
                delete(request, response);
            }
            if (action.equals("insert")) {
                insert(request, response);
            }

        }
    }

    private void dispath(HttpServletRequest request, HttpServletResponse response,
            String url) throws ServletException, IOException {
        RequestDispatcher disp = request.getRequestDispatcher(url);
        disp.forward(request, response);
    }

    private boolean isEmpty(String str) {
        return str == null || str.isEmpty() || str.equals("");
    }

    private boolean checkPhone(String phone) {
        return phone.matches("^0[0-9]{9}$");
    }

    private void show(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOCustomer dao = new DAOCustomer();
            ResultSet rs = dao.getData("select * from Customer");
            request.setAttribute("rsCu", rs);
            dispath(request, response, "admin/customerShow.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOCustomer dao = new DAOCustomer();
            String id = request.getParameter("cid");
            boolean x = dao.removeCustomer(Integer.parseInt(id));
            String altt;
            if (x) {
                altt = "Customer ID(" + id + ") - Deleted.";
            } else {
                altt = "Customer ID(" + id + ") - Can not delete.";
            }
            ResultSet rs = dao.getData("select * from Customer");
            request.setAttribute("rsCu", rs);
            request.setAttribute("altShow", altt);
            dispath(request, response, "admin/customerShow.jsp");
        }
    }

    private void insert(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOCustomer dao = new DAOCustomer();
            String submit = request.getParameter("submit");
            if (submit == null) {
                dispath(request, response, "admin/customerInsert.jsp");
            } else {
                String altt;
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
                    dispath(request, response, "admin/customerInsert.jsp");
                }
                if (checkPhone(phone) == false) {
                    altt = "Wrong format of phone number!";
                    request.setAttribute("altIns", altt);
                    dispath(request, response, "admin/customerInsert.jsp");
                }
                ResultSet rs = dao.getData("select * from Customer");
                try {
                    while (rs.next()) {
                        if (username.equals(rs.getString(5))) {
                            altt = "Username already exists!";
                            request.setAttribute("altIns", altt);
                            dispath(request, response, "admin/customerInsert.jsp");
                        }
                        break;
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerCustomer.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (password.length() < 8) {
                    altt = "Password must be more than 8 characters!";
                    request.setAttribute("altIns", altt);
                    dispath(request, response, "admin/customerInsert.jsp");
                }
                dao.addCustomer(new Customer(name, phone, address, username, password, Integer.parseInt(status)));
                altt = "Insert successful! New account: " + username;
                ResultSet rsCu = dao.getData("Select * from Customer");
                request.setAttribute("rsCu", rsCu);
                request.setAttribute("altShow", altt);
                dispath(request, response, "admin/customerShow.jsp");
            }
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOCustomer dao = new DAOCustomer();
            String submit = request.getParameter("submit");
            String id = request.getParameter("cid");
            ResultSet rs = dao.getData("select * from Customer where cid='" + id + "'");
            if (submit == null) {
                request.setAttribute("rsCu", rs);
                dispath(request, response, "admin/customerUpdate.jsp");
            } else {
                try {
                    if (rs.next()) {
                        String altt = null;
                        String name = request.getParameter("cname");
                        String username = request.getParameter("username");
                        String phone = request.getParameter("cphone");
                        String address = request.getParameter("address");
                        String password = request.getParameter("password");
                        String status = request.getParameter("status");
                        if (isEmpty(name) || isEmpty(phone) || isEmpty(address)
                                || isEmpty(password) || isEmpty(username) || isEmpty(status)) {
                            altt = "Information cannot be left blank!";
                            request.setAttribute("altUp", altt);
                            rs.beforeFirst();
                            request.setAttribute("rsCu", rs);
                            dispath(request, response, "admin/customerUpdate.jsp");
                        }
                        if (checkPhone(phone) == false) {
                            altt = "Wrong format of phone number!";
                            request.setAttribute("altUp", altt);
                            rs.beforeFirst();
                            request.setAttribute("rsCu", rs);
                            dispath(request, response, "admin/customerUpdate.jsp");
                        }
                        if (password.length() < 8) {
                            altt = "Password must be more than 8 characters!";
                            request.setAttribute("altUp", altt);
                            rs.beforeFirst();
                            request.setAttribute("rsCu", rs);
                            dispath(request, response, "admin/customerUpdate.jsp");
                        }
                        dao.updateCustomer(name, phone, address, username, password, Integer.parseInt(status), Integer.parseInt(id));
                        altt = "Update Account ID(" + id + ") successful!";
                        ResultSet rsC = dao.getData("Select * from Customer");
                        request.setAttribute("rsCu", rsC);
                        request.setAttribute("altShow", altt);
                        dispath(request, response, "admin/customerShow.jsp");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerCustomer.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
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
