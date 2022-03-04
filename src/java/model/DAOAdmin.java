/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Admin;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class DAOAdmin extends DBConnect {

    public boolean login(String username, String password) {
        String sql = "select * from admin where username=? and password=? ";
        try {
            PreparedStatement pre = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            pre.setString(1, username);
            pre.setString(2, password);
            ResultSet rs = pre.executeQuery();
            if (rs.wasNull()) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
    }

    public void addAdmin(Admin admin) {
        int n = 0;
        String sql = "insert into Admin(username,password) values(?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, admin.getUsername());
            pre.setString(2, admin.getPassword());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Inserted");
        }
    }

    public void changePassword(int id, String pass) {
        int n = 0;
        String sql = "update Admin set password=? where adminID=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, pass);
            pre.setInt(2, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Updated");
        }
    }

    public void update(int id, String pass, String name) {
        int n = 0;
        String sql = "update Admin set password=?, username=? where adminID=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, pass);
            pre.setString(2, name);
            pre.setInt(3, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Updated");
        }
    }

    public void changePasswordUser(String username, String pass) {
        int n = 0;
        String sql = "update Admin set password=? where username=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, pass);
            pre.setString(2, username);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Updated");
        }
    }

    public void deleteAccount(int id) {
        int n = 0;
        String sql = "delete from Admin where adminID=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Deleted");
        }
    }

    public static void main(String[] args) {
        DAOAdmin dao = new DAOAdmin();
        dao.deleteAccount(1);
    }
}
