/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class DAOCategory extends DBConnect {

    public int addCategory(Category cate) {
        int n = 0;
        String sql = "insert into Category values('" + cate.getCateName() + "'," + cate.getStatus() + ")";
        System.out.println(sql);
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public void updateCategory(String cateName, int status, int id) {
        int n = 0;
        String sql = "update Category set cateName = ?, status = ? where cateID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, cateName);
            pre.setInt(2, status);
            pre.setInt(3, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Updated Successfully!");
        }
    }

    public void displayAll() {
        String sql = "select * from Category";
        try {
            ResultSet rs = getData(sql);
            while (rs.next()) {
                int id = rs.getInt("cateID");
                String catename = rs.getString("cateName");
                int status = rs.getInt("status");
                Category cate = new Category(id, catename, status);
                System.out.println(cate);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void getName(String name) {
        String sql = "select * from Category where cateName like N'%" + name + "%'";
        try {
            ResultSet rs = getData(sql);
            while (rs.next()) {
                int id = rs.getInt("cateID");
                String catename = rs.getString("cateName");
                int status = rs.getInt("status");
                Category cate = new Category(id, catename, status);
                System.out.println(cate);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeStatus(int status, int cateID) {
        int n = 0;
        String sql = "update Category set status = ? where cateID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setInt(2, cateID);

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Updated Successfully!");
        }
    }

    public void removeCategory(int cateId) {
        int n = 0;
        String sql = "delete from Category where cateID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, cateId);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Remove Successfully!");
        }
    }

    public static void main(String[] args) {
        DAOCategory dao = new DAOCategory();
        dao.getName("Su");
    }
}
