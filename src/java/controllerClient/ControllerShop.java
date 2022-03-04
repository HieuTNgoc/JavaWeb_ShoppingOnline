/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllerClient;

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
import model.DAOProduct;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ControllerShop", urlPatterns = {"/ControllerShop"})
public class ControllerShop extends HttpServlet {

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
                action = "product";
            }
            if (action.equals("product")) {
                product(request, response);
            }
        }
    }

    private void product(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOProduct dao = new DAOProduct();
            String title = "List Product";
            ResultSet rsPro;
            String cid = request.getParameter("cid");
            String cname = "All";
            if (cid != null) {
                ResultSet rsCate = dao.getData("select * from Category where cateID='" + cid + "'");
                try {
                    if (rsCate.next()) {
                        cname = rsCate.getString(2);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerShop.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            String name = request.getParameter("name");
            String orderby = request.getParameter("Sort");
            String p =  request.getParameter("pprice");
            String spp = " and price <="+p;
            
            
            String sql = "select * from Product join Category on Product.cateID=Category.cateID" ;
            if (p!=null) sql+=spp;
            if (cid != null && name != null) {
                sql += " where Product.cateID='" + cid + "' and pname like '%" + name + "%'";
            }
            if (cid == null && name != null) {
                sql += " where pname like '%" + name + "%'";
            }
            if (cid != null && name == null) {
                sql += " where Product.cateID='" + cid + "'";
            }
            if (name == null) {
                name = "All";
            }
            String result = "Product: name " + name + " | category " + cname + " | Price "+p;
            if (orderby != null) {
                sql += " order by price " + orderby;
                result += " | " + orderby;
            }

            rsPro = dao.getData(sql);
            request.setAttribute("title", title);
            request.setAttribute("rsPro", rsPro);
            request.setAttribute("result", result);
            dispath(request, response, "client/product.jsp");
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
