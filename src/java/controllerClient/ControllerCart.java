/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllerClient;

import entity.Bill;
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
import model.DAOBill;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ControllerCart", urlPatterns = {"/ControllerCart"})
public class ControllerCart extends HttpServlet {

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
                action = "viewCart";
            }
            if (action.equals("viewCart")) {
                dispath(request, response, "client/showCart.jsp");
            }
            if (action.equals("add")) {
                add(request, response);
            }
            if (action.equals("update")) {
                update(request, response);
            }
            if (action.equals("remove")) {
                remove(request, response);
            }
            if (action.equals("removeAll")) {
                removeAll(request, response);
            }
            if (action.equals("checkOut")) {
                HttpSession session = request.getSession();
                java.util.Enumeration em = session.getAttributeNames();
                if (em.hasMoreElements()) {
                    dispath(request, response, "client/checkout.jsp");
                }
                response.sendRedirect("ControllerHome?action=login");

            }
            if (action.equals("addBill")) {
                addBill(request, response);
            }
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            java.util.Enumeration em = session.getAttributeNames();
            if (em.hasMoreElements()) {
                em.nextElement();
            }
            while (em.hasMoreElements()) {
                String id = em.nextElement().toString(); //get key
                int count = Integer.parseInt(request.getParameter("quantity" + id));//get new value
                session.setAttribute(id, String.valueOf(count));
            }
            dispath(request, response, "client/showCart.jsp");
        }
    }

    private void remove(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String pid = request.getParameter("pid");
            HttpSession session = request.getSession();
            String quan = session.getAttribute(pid).toString();
            session.removeAttribute(pid);
            String alt = "Item ID(" + pid + ") - Quantity(" + quan + ") was removed from the Shopping Cart";
            request.setAttribute("pid", pid);
            request.setAttribute("altIns", alt);
            dispath(request, response, "client/showCart.jsp");
        }
    }

    private void removeAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            java.util.Enumeration em = session.getAttributeNames();
            if (em.hasMoreElements()) {
                em.nextElement();
            }
            while (em.hasMoreElements()) {
                String id = em.nextElement().toString(); //get key
                session.removeAttribute(id);
            }
            String alt = "All items were remove from the Shopping Cart";
            request.setAttribute("altIns", alt);
            dispath(request, response, "client/showCart.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            java.util.Enumeration em = session.getAttributeNames();
            if (em.hasMoreElements()) {
                String pid = request.getParameter("pid");
                Object value = session.getAttribute(pid);
                if (value == null) {
                    if (!pid.equals("P01")) {
                        session.setAttribute(pid, "1");
                    }
                } else {
                    int count = Integer.parseInt(value.toString()) + 1;
                    session.setAttribute(pid, String.valueOf(count));
                }
                dispath(request, response, "client/showCart.jsp");
            } else {
                response.sendRedirect("ControllerHome?action=login");
            }
        }
    }

    private void addBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String cid = request.getParameter("cid");
            String total = request.getParameter("total");
            DAOBill dao = new DAOBill();
            String submit = request.getParameter("submit");
            if (submit == null) {
                ResultSet rs = dao.getData("Select * from Customer where cid=" + cid);
                request.setAttribute("rs", rs);
                request.setAttribute("total", total);
                dispath(request, response, "admin/billInsert.jsp");
            } else {
                String oID = request.getParameter("oID");
                int cusid = Integer.parseInt(cid);
                String cname = request.getParameter("cname");
                String cphone = request.getParameter("cphone");
                String cAddress = request.getParameter("cAddress");
                String status = request.getParameter("status");
                String date = request.getParameter("dateTime");
                int sta = Integer.parseInt(status);
                double tot = Double.parseDouble(total);
                Bill bill = new Bill(oID, date, cname, cphone, cAddress, tot, sta, cusid);
                dao.addBill(bill);
                request.setAttribute("oid", oID);
                dispath(request, response, "admin/billDetailInsert.jsp");
            }
        }
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
