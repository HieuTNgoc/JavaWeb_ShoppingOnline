/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Customer;
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
public class DAOCustomer extends DBConnect {

    public void addCustomer(Customer cus) {
        String sql = "INSERT INTO dbo.Customer VALUES(N'" + cus.getCname() + "','" + cus.getCphone() + "',N'" + cus.getcAddress() + "','" + cus.getUsername() + "','" + cus.getPassword() + "'," + cus.getStatus() + ")";
        System.out.println(sql);
        try {
            Statement statement = conn.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateCustomer(String name, String phone, String address, String username, String password, int status, int cid) {
        String sql = "update Customer set cname = ?, cphone = ?, cAddress = ?, username = ?, [password] = ?, status = ? where cid = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            pre.setString(2, phone);
            pre.setString(3, address);
            pre.setString(4, username);
            pre.setString(5, password);
            pre.setInt(6, status);
            pre.setInt(7, cid);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void getPhone(String phone) {
        String sql = "select * from Customer where cphone like '%" + phone + "%'";
        try {
            ResultSet rs = getData(sql);
            while (rs.next()) {
                int cid = rs.getInt("cid");
                String cname = rs.getString("cname");
                String cphone = rs.getString("cphone");
                String cAddress = rs.getString("cAddress");
                String username = rs.getString("username");
                String password = rs.getString("password");
                int status = rs.getInt("status");
                Customer cus = new Customer(cid, cname, cphone, cAddress, username, password, status);
                System.out.println(cus);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateCustomerUser(Customer cus) {
        int n = 0;
        String sql = "update Customer set cname = ?, cphone = ?, cAddress = ?, [password] = ?, status = ? where cid = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, cus.getCname());
            pre.setString(2, cus.getCphone());
            pre.setString(3, cus.getcAddress());
            pre.setString(4, cus.getPassword());
            pre.setInt(5, cus.getStatus());
            pre.setInt(6, cus.getCid());
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean removeCustomer(int cid) {
        String sql = "delete from Customer where cid = ?";
        int x = 0;
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, cid);
            x = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCustomer.class.getName()).log(Level.SEVERE, null, ex);
        }
        return x > 0;
    }

    public static void main(String[] args) {
        DAOCustomer cust = new DAOCustomer();
    }
}
