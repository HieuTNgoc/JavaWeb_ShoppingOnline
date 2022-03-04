/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Category;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DAOCategory;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ControllerCategory", urlPatterns = {"/ControllerCategory"})
public class ControllerCategory extends HttpServlet {

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
            DAOCategory dao = new DAOCategory();
            String action = request.getParameter("action");
            if (action == null) {
                action = "listAll";
            }
            if (action.equals("listAll")) {
                listAll(request, response);

            }
            if (action.equals("update")) {
                update(request, response);

            }
            if (action.equals("delete")) {
                String id = request.getParameter("cateID");
                dao.removeCategory(Integer.parseInt(id));
                response.sendRedirect("ControllerCategory");
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

    private void listAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOCategory dao = new DAOCategory();
            ResultSet rs = dao.getData("select * from Category");
            String title = "<h1>Category List</h1>";
            request.setAttribute("rs", rs);
            request.setAttribute("title", title);
            dispath(request, response, "/CategoryView.jsp");
        }
    }

    private void insert(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOCategory dao = new DAOCategory();
            String submit = request.getParameter("submit");
            if (submit == null) {
                String title = "<h1>Insert Category</h1>";
                request.setAttribute("title", title);
                dispath(request, response, "/insertCategory.jsp");
            } else {
                String name = request.getParameter("cateName");
                String status = request.getParameter("status");
                if (isEmpty(name) || status == null) {
                    out.println("<h1>Information cannot be left blank!</h1>");
                    out.println("<a href=\"ControllerCategory\"><---Back.</a>");
                    return;
                }
                dao.addCategory(new Category(0, name, Integer.parseInt(status)));
                response.sendRedirect("ControllerCategory");
            }
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOCategory dao = new DAOCategory();
            String submit = request.getParameter("submit");
            if (submit == null) {
                String id = request.getParameter("cateID");
                String title = "<h1>Update Category</h1>";
                ResultSet rs = dao.getData("select * from Category where cateID='" + id + "'");
                request.setAttribute("update", rs);
                request.setAttribute("title", title);
                dispath(request, response, "/updateCategory.jsp");
            } else {
                String id = request.getParameter("cateID");
                String cateName = request.getParameter("cateName");
                String status = request.getParameter("status");
                if (isEmpty(cateName)) {
                    out.println("<h1>Information cannot be left blank!</h1>");
                    out.println("<a href=\"ControllerCategory\"><---Back.</a>");
                    return;
                }
                dao.updateCategory(cateName, Integer.parseInt(status), Integer.parseInt(id));
                response.sendRedirect("ControllerCategory");
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
