/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Admin
 */
public class BillDetail {
    private String pid;
    private String oID;
    private int quantity;
    private double pricemoney, totalmoney;

    public BillDetail() {
    }

    public BillDetail(String pid, String oID, int quantity, double pricemoney, double totalmoney) {
        this.pid = pid;
        this.oID = oID;
        this.quantity = quantity;
        this.pricemoney = pricemoney;
        this.totalmoney = totalmoney;
    }
    
    public BillDetail(BillDetail bill) {
        this.pid = bill.pid;
        this.oID = bill.oID;
        this.quantity = bill.quantity;
        this.pricemoney = bill.pricemoney;
        this.totalmoney = bill.totalmoney;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getoID() {
        return oID;
    }

    public void setoID(String oID) {
        this.oID = oID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPricemoney() {
        return pricemoney;
    }

    public void setPricemoney(double pricemoney) {
        this.pricemoney = pricemoney;
    }

    public double getTotalmoney() {
        return totalmoney;
    }

    public void setTotalmoney(double totalmoney) {
        this.totalmoney = totalmoney;
    }

    @Override
    public String toString() {
        return "BillDetail{" + "pid=" + pid + ", oID=" + oID + ", quantity=" + quantity + ", pricemoney=" + pricemoney + ", totalmoney=" + totalmoney + '}';
    }
    
    
}

