/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class DAOProduct extends DBConnect {

    public int addProduct(Product prod) {
        int n = 0;
        String sql = "INSERT INTO dbo.Product VALUES('" + prod.getPid() + "',N'" + prod.getPname() + "'," + prod.getQuantity() + "," + prod.getPrice() + ",'" + prod.getImage() + "',N'" + prod.getDescription() + "'," + prod.getStatus() + "," + prod.getCateID() + ")";
        System.out.println(sql);
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int addProduct1(Product prod) {
        int n = 0;
        String sql = "INSERT INTO dbo.Product "
                + "VALUES(?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, prod.getPid());
            pre.setString(2, prod.getPname());
            pre.setInt(3, prod.getQuantity());
            pre.setDouble(4, prod.getPrice());
            pre.setString(5, prod.getImage());
            pre.setString(6, prod.getDescription());
            pre.setInt(7, prod.getStatus());
            pre.setInt(8, prod.getCateID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateProduct(Product prod) {
        int n = 0;
        String sql = "update Product set pname=?,quantity=?,price=?,image=?,description=?,"
                + "status=?,cateID=? where pid=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, prod.getPname());
            pre.setInt(2, prod.getQuantity());
            pre.setDouble(3, prod.getPrice());
            pre.setString(4, prod.getImage());
            pre.setString(5, prod.getDescription());
            pre.setInt(6, prod.getStatus());
            pre.setInt(7, prod.getCateID());
            pre.setString(8, prod.getPid());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public void displayAll() {

        String sql = "Select * from Product";
        try {
            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                String pid = rs.getString("pid");
                String pname = rs.getString("pname");
                int quantity = rs.getInt(3);
                double price = rs.getDouble(4);
                String image = rs.getString("image");
                String des = rs.getString("description");
                int status = rs.getInt("status");
                int cateID = rs.getInt("cateID");
                Product pro = new Product(pid, pname, quantity, price, image, des, status, cateID);
                System.out.println(pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Product> getProduct() {
        ArrayList<Product> arr = new ArrayList<>();
        try {
            String sql = "Select * from Product";
            ResultSet rs = getData(sql);
            while (rs.next()) {
                String pid = rs.getString("pid");
                String pname = rs.getString("pname");
                int quantity = rs.getInt(3);
                double price = rs.getDouble(4);
                String image = rs.getString("image");
                String des = rs.getString("description");
                int status = rs.getInt("status");
                int cateID = rs.getInt("cateID");
                Product pro = new Product(pid, pname, quantity, price, image, des, status, cateID);
                arr.add(pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        return arr;
    }

    public ResultSet getPrice(double from, double to) {
        String sql = "Select * from Product where price between " + from + " to " + to;
        return getData(sql);
    }

    public ResultSet getName(String name) {
        String sql = "Select * from Product where pname like '%" + name + "%'";
        return getData(sql);
    }

    public ResultSet sortPriceAscbyName(String name) {
        String sql = "select * from Product where pname like '%" + name + "%' order by price asc";
        return getData(sql);
    }

    public ResultSet sortPriceDescbyName(String name) {
        String sql = "select * from Product where pname like '%" + name + "%' order by price desc";
        return getData(sql);
    }

    public void updateQuantity(String id, int quan) {
        int n = 0;
        String sql = "UPDATE dbo.Product SET quantity = ? WHERE pid = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, quan);
            pre.setString(2, id);

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Updated Successfully!");
        }
    }

    public void subQuantity(String id, int quan) {
        int n = 0;
        String sql = "UPDATE dbo.Product SET quantity = quantity-? WHERE pid = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, quan);
            pre.setString(2, id);

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Updated Successfully!");
        }
    }

    public void changeStatus(String id, int status) {
        int n = 0;
        String sql = "UPDATE dbo.Product SET status = ? WHERE pid = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setString(2, id);

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Updated Successfully!");
        }
    }

    public boolean removeProduct(String id) {
        int n = 0;
        String sql = "DELETE FROM dbo.Product WHERE pid = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n > 0;
    }

    public static void main(String[] args) {
        DAOProduct dao = new DAOProduct();
        dao.displayAll();
    }
}
