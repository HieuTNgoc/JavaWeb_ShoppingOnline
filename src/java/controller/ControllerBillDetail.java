/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOBillDetail;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ControllerBillDetail", urlPatterns = {"/ControllerBillDetail"})
public class ControllerBillDetail extends HttpServlet {

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
            DAOBillDetail dao = new DAOBillDetail();
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
            if (action.equals("showDetail")) {
                showDetail(request, response);
            }
            if (action.equals("update")) {
                update(request, response);
            }
            if (action.equals("delete")) {
                delete(request, response);
            }
            if (action.equals("insert")) {
                String altt = "Let's go shopping to create a new Bill Detail";
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

    private boolean checkNumber(String str) {
        return !(str.matches("^[0-9\\.\\+\\-]+$"));
    }

    private void show(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOBillDetail dao = new DAOBillDetail();
            ResultSet rs = dao.getData("select * from BillDetail");
            request.setAttribute("rsBDT", rs);
            dispath(request, response, "admin/billDetailShow.jsp");
        }
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOBillDetail dao = new DAOBillDetail();
            String id = request.getParameter("oID");
            String cname = request.getParameter("cname");
            ResultSet rs = dao.getData("select * from BillDetail where oID='" + id + "'");
            request.setAttribute("rsBDT", rs);
            request.setAttribute("cname", cname);
            dispath(request, response, "admin/billDTshowDT.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOBillDetail dao = new DAOBillDetail();
            String pid = request.getParameter("pid");
            String oid = request.getParameter("oID");
            dao.deleteBillDetail(pid, oid);
            dao.deleteBillDetail(oid, oid);
            String altt;
            altt = "Order ID(" + oid + ") - Product ID(" + pid + ") - Deleted.";
            request.setAttribute("altShow", altt);
            String cname = request.getParameter("cname");
            ResultSet rs = dao.getData("select * from BillDetail where oID='" + oid + "'");
            request.setAttribute("rsBDT", rs);
            request.setAttribute("cname", cname);
            dispath(request, response, "admin/billDTshowDT.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOBillDetail dao = new DAOBillDetail();
            String submit = request.getParameter("submit");
            String oid = request.getParameter("oID");
            String pid = request.getParameter("pid");
            String cname = request.getParameter("cname");
            if (submit == null) {
                ResultSet rs = dao.getData("select * from BillDetail where oID='" + oid + "' and pid='" + pid + "'");
                request.setAttribute("rsBDT", rs);
                request.setAttribute("cname", cname);
                dispath(request, response, "admin/billDetailUpdate.jsp");
            } else {
                String altt = null;
                String quantity = request.getParameter("quantity");
                if (isEmpty(quantity)) {
                    altt = "Information cannot be left blank!";
                    request.setAttribute("altUp", altt);
                    ResultSet rs = dao.getData("select * from BillDetail where oID='" + oid + "' and pid='" + pid + "'");
                    request.setAttribute("rsBDT", rs);
                    request.setAttribute("cname", cname);
                    dispath(request, response, "admin/billDetailUpdate.jsp");
                }
                if (checkNumber(quantity)) {
                    altt = "Quantity information must be an number!";
                    request.setAttribute("altUp", altt);
                    ResultSet rs = dao.getData("select * from BillDetail where oID='" + oid + "' and pid='" + pid + "'");
                    request.setAttribute("rsBDT", rs);
                    request.setAttribute("cname", cname);
                    dispath(request, response, "admin/billDetailUpdate.jsp");
                }
                int quan = Integer.parseInt(quantity);
                if (quan <= 0) {
                    altt = "Quantity information must be an number (>0)!";
                    request.setAttribute("altUp", altt);
                    ResultSet rs = dao.getData("select * from BillDetail where oID='" + oid + "' and pid='" + pid + "'");
                    request.setAttribute("rsBDT", rs);
                    request.setAttribute("cname", cname);
                    dispath(request, response, "admin/billDetailUpdate.jsp");
                }
                dao.updateQuantityandTotal(pid, oid, quan);
                altt = "Order ID(" + oid + ") - Product ID(" + pid + ") - Quantity updated.";
                ResultSet rss = dao.getData("select * from BillDetail where oID='" + oid + "'");
                request.setAttribute("altShow", altt);
                request.setAttribute("rsBDT", rss);
                request.setAttribute("cname", cname);
                dispath(request, response, "admin/billDTshowDT.jsp");

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
