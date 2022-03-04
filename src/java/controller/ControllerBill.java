/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

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
import model.DAOBill;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ControllerBill", urlPatterns = {"/ControllerBill"})
public class ControllerBill extends HttpServlet {

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
            DAOBill dao = new DAOBill();
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
                String altt = "Let's go shopping to create a new Bill";
                request.setAttribute("alt", altt);
                dispath(request, response, "admin/homeAd.jsp");
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
            DAOBill dao = new DAOBill();
            ResultSet rs = dao.getData("select * from Bill where status<>'2'");
            request.setAttribute("rsB", rs);
            dispath(request, response, "admin/billShow.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOBill dao = new DAOBill();
            String oid = request.getParameter("oID");
            boolean x = dao.removeBill(oid);
            String altt;
            if (x) {
                altt = "Order ID(" + oid + ") - Deleted.";
            } else {
                altt = "Order ID(" + oid + ") - Can not delete.";
            }
            request.setAttribute("altShow", altt);
            ResultSet rs = dao.getData("select * from Bill");
            request.setAttribute("rsB", rs);
            dispath(request, response, "admin/billShow.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOBill dao = new DAOBill();
            String submit = request.getParameter("submit");
            String id = request.getParameter("oID");
            ResultSet rs = dao.getData("select * from Bill where oID='" + id + "'");
            if (submit == null) {
                request.setAttribute("rsB", rs);
                dispath(request, response, "admin/billUpdate.jsp");
            } else {
                try {
                    if (rs.next()) {
                        String altt = null;
                        String name = request.getParameter("cname");
                        String phone = request.getParameter("cphone");
                        String address = request.getParameter("cAdress");
                        String status = request.getParameter("status");
                        if (isEmpty(name) || isEmpty(phone) || isEmpty(address) || isEmpty(status)) {
                            altt = "Information cannot be left blank!";
                            request.setAttribute("altUp", altt);
                            rs.beforeFirst();
                            request.setAttribute("rsB", rs);
                            dispath(request, response, "admin/billUpdate.jsp");
                        }
                        if (!checkPhone(phone)) {
                            altt = "Wrong format of phone number!";
                            request.setAttribute("altUp", altt);
                            rs.beforeFirst();
                            request.setAttribute("rsB", rs);
                            dispath(request, response, "admin/billUpdate.jsp");
                        }
                        dao.updateNBA(id, name, phone, address);
                        dao.changeStatus(id, Integer.parseInt(status));
                        //update total
                        double total = 0;
                        ResultSet rsBDT = dao.getData("select * from BillDetail where oID = '" + id + "'");
                        while (rsBDT.next()) {
                            total += Double.parseDouble(rsBDT.getString(5));
                        }
                        dao.updateTotal(id, total);

                        altt = "Update Bill ID(" + id + ") successful!";
                        request.setAttribute("altShow", altt);
                        ResultSet rsB = dao.getData("select * from Bill");
                        request.setAttribute("rsB", rsB);
                        dispath(request, response, "admin/billShow.jsp");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerBill.class.getName()).log(Level.SEVERE, null, ex);
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
