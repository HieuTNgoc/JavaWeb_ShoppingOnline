/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Admin;
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
import model.DAOAdmin;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ControllerAdmin", urlPatterns = {"/ControllerAdmin"})
public class ControllerAdmin extends HttpServlet {

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
            DAOAdmin dao = new DAOAdmin();
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
                home(request, response);
            }
            if (action.equals("login")) {
                login(request, response);
            }
            if (action.equals("logout")) {
                session.invalidate();
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

    private void home(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOAdmin dao = new DAOAdmin();
            ResultSet rs = dao.getData("Select * from Bill");
            int num = 0;
            String slt = "Number of Bill are/is not done yet: ";
            try {
                while (rs.next()) {
                    if (!rs.getString(7).equals("2")) num++;
                }
                
            } catch (SQLException ex) {
                Logger.getLogger(ControllerAdmin.class.getName()).log(Level.SEVERE, null, ex);
            }
            slt+=num;
            String link = "ControllerBill?action=show";
            request.setAttribute("link", link);
            request.setAttribute("slt", slt);
            dispath(request, response, "admin/homeAd.jsp");
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOAdmin dao = new DAOAdmin();
            String lgCheck = "";
            String link = "";
            String adminID = null;
            HttpSession session = request.getSession();
            java.util.Enumeration em = session.getAttributeNames();
            if (em.hasMoreElements()) {
                adminID = em.nextElement().toString();
            }

            if (adminID == null) {
                String login = request.getParameter("login");
                if (login != null) {
                    String name = request.getParameter("username");
                    String password = request.getParameter("password");
                    if (password.length() < 8) {
                        lgCheck = "Password must be more than 8 characters! Try again!";
                    }
                    ResultSet rs = dao.getData("select * from admin where username='" + name + "' and password='" + password + "'");
                    try {
                        if (rs.next()) {
                            adminID = rs.getString(1);
                            session.setAttribute(adminID, "1");
                            lgCheck = "Login successful! Go to your Home page.";
                            link = "ControllerAdmin?action=home";
                        } else {
                            lgCheck = "Wrong info! Try again!";
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ControllerAdmin.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
            request.setAttribute("link", link);
            request.setAttribute("lgCheck", lgCheck);
            dispath(request, response, "admin/adminlogin.jsp");
        }
    }

    private void show(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOAdmin dao = new DAOAdmin();
            ResultSet rsAd = dao.getData("Select * from Admin");
            request.setAttribute("rsAd", rsAd);
            dispath(request, response, "admin/adminShow.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOAdmin dao = new DAOAdmin();
            HttpSession session = request.getSession();
            java.util.Enumeration em = session.getAttributeNames();
            String adminID = null;
            if (em.hasMoreElements()) {
                adminID = em.nextElement().toString();
            }
            String id = request.getParameter("adminID");
            String altt;
            if (!adminID.equals(id)) {
                altt = "Account ID(" + id + ") - Deleted.";
                dao.deleteAccount(Integer.parseInt(id));
            } else {
                altt = "Can not delete your account!";
            }
            ResultSet rsAd = dao.getData("Select * from Admin");
            request.setAttribute("rsAd", rsAd);
            request.setAttribute("altShow", altt);
            dispath(request, response, "admin/adminShow.jsp");
        }
    }

    private void insert(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOAdmin dao = new DAOAdmin();
            String submit = request.getParameter("submit");
            if (submit == null) {
                dispath(request, response, "admin/adminInsert.jsp");
            } else {
                String altt;
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                if (isEmpty(username) || isEmpty(password)) {
                    altt = "Information cannot be left blank!";
                    request.setAttribute("altIns", altt);
                    dispath(request, response, "admin/adminInsert.jsp");
                }
                ResultSet rs = dao.getData("select * from Admin");
                try {
                    while (rs.next()) {
                        if (username.equals(rs.getString(2))) {
                            altt = "Username already exists!";
                            request.setAttribute("altIns", altt);
                            dispath(request, response, "admin/adminInsert.jsp");
                        }
                        break;
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerAdmin.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (password.length() < 8) {
                    altt = "Password must be more than 8 characters!";
                    request.setAttribute("altIns", altt);
                    dispath(request, response, "admin/adminInsert.jsp");
                }
                dao.addAdmin(new Admin(username, password));
                altt = "Insert successful! New account: " + username;
                ResultSet rsAd = dao.getData("Select * from Admin");
                request.setAttribute("rsAd", rsAd);
                request.setAttribute("altShow", altt);
                dispath(request, response, "admin/adminShow.jsp");
            }
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOAdmin dao = new DAOAdmin();
            String submit = request.getParameter("submit");
            String id = request.getParameter("adminID");
            ResultSet rs = dao.getData("select * from Admin where adminID='" + id + "'");
            if (submit == null) {
                request.setAttribute("rsAd", rs);
                dispath(request, response, "admin/adminUpdate.jsp");
            } else {
                try {
                    if (rs.next()) {
                        String altt = null;
                        String username = request.getParameter("username");
                        String pass = request.getParameter("password");
                        if (isEmpty(username)) {
                            altt = "Information cannot be left blank!";
                            request.setAttribute("altUp", altt);
                            rs.beforeFirst();
                            request.setAttribute("rsAd", rs);
                            dispath(request, response, "admin/adminUpdate.jsp");
                        }
                        ResultSet rs1 = dao.getData("select * from Admin");

                        try {
                            while (rs1.next()) {
                                if (username.equals(rs1.getString(2))) {
                                    altt = "Username already exists!";
                                    request.setAttribute("altUp", altt);
                                    rs.beforeFirst();
                                    request.setAttribute("rsAd", rs);
                                    dispath(request, response, "admin/adminUpdate.jsp");
                                }
                                break;
                            }
                        } catch (SQLException ex) {
                            Logger.getLogger(ControllerAdmin.class.getName()).log(Level.SEVERE, null, ex);
                        }

                        if (pass.length() < 8) {
                            altt = "Password must be more than 8 charecters!";
                            request.setAttribute("altUp", altt);
                            rs.beforeFirst();
                            request.setAttribute("rsAd", rs);
                            dispath(request, response, "admin/adminUpdate.jsp");
                        }
                        dao.update(Integer.parseInt(id), pass, username);
                        altt = "Update Account ID(" + id + ") successful!";
                        ResultSet rsAd = dao.getData("Select * from Admin");
                        request.setAttribute("rsAd", rsAd);
                        request.setAttribute("altShow", altt);
                        dispath(request, response, "admin/adminShow.jsp");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerAdmin.class.getName()).log(Level.SEVERE, null, ex);
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
