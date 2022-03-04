/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Product;
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
import model.DAOProduct;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ControllerProduct", urlPatterns = {"/ControllerProduct"})
public class ControllerProduct extends HttpServlet {

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
            DAOProduct dao = new DAOProduct();
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

    private boolean checkNumber(String str) {
        return !(str.matches("^[0-9\\.\\+\\-]+$"));
    }

    private void show(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOProduct dao = new DAOProduct();
            ResultSet rsPro = dao.getData("Select * from Product join Category on Product.cateID = Category.cateID");
            request.setAttribute("rsPro", rsPro);
            dispath(request, response, "admin/productShow.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOProduct dao = new DAOProduct();
            String id = request.getParameter("pid");
            boolean x = dao.removeProduct(id);
            String altt;
            if (x) {
                altt = "Product ID(" + id + ") - Deleted.";
            } else {
                altt = "Product ID(" + id + ") - Can not delete.";
            }
            ResultSet rsPro = dao.getData("Select * from Product join Category on Product.cateID = Category.cateID");
            request.setAttribute("rsPro", rsPro);
            request.setAttribute("altShow", altt);
            dispath(request, response, "admin/productShow.jsp");
        }
    }

    private void insert(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOProduct dao = new DAOProduct();
            String submit = request.getParameter("submit");
            if (submit == null) {
                dispath(request, response, "admin/productInsert.jsp");
            } else {
                String altt;
                String id = request.getParameter("pid");
                String name = request.getParameter("name");
                String quantity = request.getParameter("quantity");
                String price = request.getParameter("price");
                String image = request.getParameter("image");
                String description = request.getParameter("description");
                String status = request.getParameter("status");
                String cateID = request.getParameter("cateID");

                if (isEmpty(id) || isEmpty(name) || isEmpty(quantity) || isEmpty(price)
                        || isEmpty(image) || isEmpty(description) || status == null) {
                    altt = "Information cannot be left blank!";
                    request.setAttribute("altIns", altt);
                    dispath(request, response, "admin/productInsert.jsp");
                }
                if (checkNumber(quantity) || checkNumber(price)) {
                    altt = "Quantity & Price information must be an number!";
                    request.setAttribute("altIns", altt);
                    dispath(request, response, "admin/productInsert.jsp");
                }
                int quan = Integer.parseInt(quantity);
                int pri = Integer.parseInt(price);
                if (quan <= 0 || pri <= 0) {
                    altt = "Quantity & Price - Must enter a number greater than 0!";
                    request.setAttribute("altIns", altt);
                    dispath(request, response, "admin/productInsert.jsp");
                }

                int stat = Integer.parseInt(status);
                int cate = Integer.parseInt(cateID);
                dao.addProduct1(new Product(id, name, quan, pri, image, description, stat, cate));
                altt = "Insert successful! New product: " + name;
                request.setAttribute("altShow", altt);
                ResultSet rsPro = dao.getData("Select * from Product join Category on Product.cateID = Category.cateID");
                request.setAttribute("rsPro", rsPro);
                dispath(request, response, "admin/productShow.jsp");
            }

        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOProduct dao = new DAOProduct();
            String submit = request.getParameter("submit");
            String id = request.getParameter("pid");
            ResultSet rs = dao.getData("select * from Product where pid='" + id + "'");
            if (submit == null) {
                request.setAttribute("rsPro", rs);
                dispath(request, response, "admin/productUpdate.jsp");
            } else {
                try {
                    if (rs.next()) {
                        String altt = null;
                        String name = request.getParameter("name");
                        String quantity = request.getParameter("quantity");
                        String price = request.getParameter("price");
                        String image = request.getParameter("image");
                        String description = request.getParameter("description");
                        String status = request.getParameter("status");
                        String cateID = request.getParameter("cateID");

                        if (isEmpty(id) || isEmpty(name) || isEmpty(quantity) || isEmpty(price)
                                || isEmpty(image) || isEmpty(description)) {
                            altt = "Information cannot be left blank!";
                            request.setAttribute("altUp", altt);
                            rs.beforeFirst();
                            request.setAttribute("rsPro", rs);
                            dispath(request, response, "admin/productUpdate.jsp");
                        }
                        int quan = Integer.parseInt(quantity);
                        double pri = Double.parseDouble(price);
                        int stat = Integer.parseInt(status);
                        int cate = Integer.parseInt(cateID);
                        if (quan < 0 || pri < 0) {
                            altt = "Quantity & Price: Must enter a number greater than 0!";
                            request.setAttribute("altUp", altt);
                            rs.beforeFirst();
                            request.setAttribute("rsPro", rs);
                            dispath(request, response, "admin/productUpdate.jsp");
                        }
                        dao.updateProduct(new Product(id, name, quan, pri, image, description, stat, cate));
                        altt = "Update Product ID(" + id + ") successful!";
                        ResultSet rsPro = dao.getData("Select * from Product join Category on Product.cateID = Category.cateID");
                        request.setAttribute("rsPro", rsPro);
                        request.setAttribute("altShow", altt);
                        dispath(request, response, "admin/productShow.jsp");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerProduct.class.getName()).log(Level.SEVERE, null, ex);
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
