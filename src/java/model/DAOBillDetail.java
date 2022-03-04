/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.BillDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class DAOBillDetail extends DBConnect {

    public void addBillDetail(BillDetail billd) {
        int n = 0;
        String sql = "insert BillDetail(pid, oID, quantity, price, total)"
                + "values(?,?,?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, billd.getPid());
            pre.setString(2, billd.getoID());
            pre.setInt(3, billd.getQuantity());
            pre.setDouble(4, billd.getPricemoney());
            pre.setDouble(5, billd.getTotalmoney());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBillDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Inserted");
        }
    }

    public void changeQuantity(String id, int quan) {
        int n = 0;
        String sql = "update BillDetail set quantity=? where pid=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, quan);
            pre.setString(2, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBillDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Updated");
        }
    }

    public void updateQuantityandTotal(String pid, String oID, int quan) {
        int n = 0;
        String sql = "update BillDetail set quantity = ?, total = price * ? where pid = ? and oID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, quan);
            pre.setInt(2, quan);
            pre.setString(3, pid);
            pre.setString(4, oID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBillDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (n > 0) {
            System.out.println("Updated");
        }
    }

    public void displayAll() {
        String sql = "select * from BillDetail";
        try {
            ResultSet rs = getData(sql);
            while (rs.next()) {
                String pid = rs.getString(1);
                String oid = rs.getString(2);
                int quantity = rs.getInt(3);
                double pricemoney = rs.getDouble(4);
                double totalmoney = rs.getDouble(5);
                BillDetail bill = new BillDetail(pid, oid, quantity, pricemoney, totalmoney);
                System.out.println(bill);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean deleteBillDetail(String id, String oid) {
        int n = 0;
        String sql = "delete from BillDetail where pid=? and oID=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, id);
            pre.setString(2, oid);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBillDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n > 0;
    }

    public static void main(String[] args) {
        DAOBillDetail dao = new DAOBillDetail();
//      1. Insert Bill Detail
        dao.addBillDetail(new BillDetail("P03", "HE123123", 20, 100, 100));

//      2. Update quantity
        dao.changeQuantity("P03", 15);

//      3. Delete Bill Detail
//        dao.deleteBillDetail("P03");
    }
}
