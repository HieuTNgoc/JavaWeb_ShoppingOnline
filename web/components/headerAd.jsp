<%-- 
    Document   : headerAd
    Created on : Nov 6, 2021, 6:20:34 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOAdmin"%>
<%@page import="model.DAOAdmin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--header-->
<div class="header-top">
    <div class="wrap">  
        <div class="cssmenu">
            <ul>
                <%
                    String adminID = null;
                    java.util.Enumeration em1 = session.getAttributeNames();
                    if (em1.hasMoreElements()) {
                        adminID = em1.nextElement().toString();
                    }
                    if (adminID == null) {
                %>
                <li><a href="ControllerAdmin?action=login">Log In</a></li> 
                    <%}%> 
                    <%if (adminID != null) {
                            DAOAdmin dao = new DAOAdmin();
                            ResultSet rs = null;
                            rs = dao.getData("Select * from admin where adminID='" + adminID + "'");
                            if (rs.next()) {
                    %>
                <li class="active"><a href="ControllerAdmin?action=show"><%=rs.getString(2)%></a></li> |
                <li><a href="ControllerAdmin?action=logout">Log Out</a></li>|
                <li><a href="ControllerAdmin?action=show">Acc Managment</a></li>
                    <%}
                        }%>
            </ul>
        </div>
        <div class="clear"></div>
    </div>
</div>
<div class="header-bottom">
    <div class="wrap">
        <div class="header-bottom-left">
            <div class="logo">
                <a href="ControllerAdmin?action=home"><img style="max-width: 50%" src="static/images/logo2.png" alt=""/></a>
                <p style="font-size: 1.5em;" class="active grid" >SHOP MANAGEMENT</p><br>
            </div>
            <div class="menu">
                <ul class="megamenu skyblue">
                    <li><a style="font-size: 1.2em;" class="color4" href="ControllerAdmin?action=show">Admin</a></li>
                    <li><a style="font-size: 1.2em;" class="color4" href="ControllerCustomer?action=show">Customer</a></li>				
                    <li><a style="font-size: 1.2em;" class="color4" href="ControllerProduct?action=show">Product</a></li>
                    <li><a style="font-size: 1.2em;" class="color4" href="ControllerBill?action=show">Bill</a></li>	
                </ul>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>

