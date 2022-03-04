/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entity.Bill;
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
public class DAOBill extends DBConnect {

    public int addBill(Bill bill) {
        int n = 0;
        String sql = "insert into Bill(oID,dateCreate,cname,cphone,cAddress,total,cid) values(?,?,?,?,?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, bill.getoID());
            pre.setString(2, bill.getDateCreate());
            pre.setString(3, bill.getCname());
            pre.setString(4, bill.getCphone());
            pre.setString(5, bill.getcAddress());
            pre.setDouble(6, bill.getTotalmoney());
            pre.setInt(7, bill.getCid());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public boolean changeStatus(String id, int status) {
        int n = 0;
        String sql = "update Bill set status=? where oID=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setString(2, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n > 0;
    }

    public void displayAll() {
        int n = 0;
        String sql = "Select * from Bill";
        try {
            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                String oid = rs.getString("oid");
                String date = rs.getString("dateCreate");
                String cname = rs.getString(3);
                String cphone = rs.getString(4);
                String cAddress = rs.getString(5);
                double totalMoney = rs.getDouble(6);
                int status = rs.getInt("status");
                int cID = rs.getInt("cID");
                Bill bill = new Bill(oid, date, cname, cphone, cAddress, totalMoney, status, cID);
                System.out.println(bill);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateTotal(String id, double money) {
        int n = 0;
        String sql = "update Bill set total=? where oID=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setDouble(1, money);
            pre.setString(2, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean updateNBA(String oID, String cname, String cphone, String caddress) {
        int n = 0;
        String sql = "update Bill set cname = ?, cphone = ?, cAddress = ? where oID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, cname);
            pre.setString(2, cphone);
            pre.setString(3, caddress);
            pre.setString(4, oID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n > 0;
    }

    public boolean removeBill(String id) {
        int n = 0;
        String sql = "delete from Bill where oID=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOBill.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n > 0;
    }

    public static void main(String[] args) {
        DAOBill dao = new DAOBill();
        dao.displayAll();
    }
}
