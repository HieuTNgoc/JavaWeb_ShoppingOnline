<%-- 
    Document   : header
    Created on : Oct 13, 2021, 7:07:49 PM
    Author     : Admin
--%>

<%@page import="model.DAOProduct"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOCustomer"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="header-top">
    <div class="wrap">  
        <div class="cssmenu">
            <ul>
                <%
                    java.util.Enumeration em1 = session.getAttributeNames();
                    if (em1.hasMoreElements()) {
                        String cid = em1.nextElement().toString();
                        DAOCustomer dao = new DAOCustomer();
                        ResultSet rs = dao.getData("Select * from Customer where cid='" + cid + "'");
                        if (rs.next()) {
                %>
                <li class="active"><a href="ControllerHome?action=viewAcc"><%=rs.getString(5)%></a></li> |
                <li><a href="ControllerHome?action=logout">Log Out</a></li>
                    <%}
                    } else {%>
                <li><a href="ControllerHome?action=login">Log In</a></li> |
                <li><a href="ControllerHome?action=addAcc">Sign Up</a></li>
                    <%}%>
            </ul>
        </div>
        <div class="clear"></div>
    </div>
</div>
<div class="header-bottom">
    <div class="wrap">
        <div class="header-bottom-left">
            <div class="logo">
                <a href="ControllerHome?action=home"><img style="max-width: 50%" src="static/images/logo2.png" alt=""/></a>
            </div>
            <div class="menu">
                <ul class="megamenu skyblue">
                    <li class="active grid"><a style="font-size: 1.5em;" href="ControllerHome?action=home">Home</a></li>
                    <li><a style="font-size: 1.5em;" class="color4" href="ControllerShop?action=product">Product</a></li>				
                    <li><a style="font-size: 1.5em;" class="color5" href="#">Purchase History</a></li>
                </ul>
            </div>
        </div>
        <div class="header-bottom-right">
            <div class="search">	  
                <form  action="ControllerShop?action=product" method="post">
                    <input type="text" name="search" class="textbox" value="Search" onfocus="this.value = '';" onblur="if (this.value == '') {
                                this.value = 'Search';
                            }">
                    <input type="submit" value="Subscribe" id="submit" name="submit">
                    <div id="response"> </div>
                </form>
            </div>
            <div class="tag-list">
                <ul class="icon1 sub-icon1 profile_img">
                    <li><a class="active-icon c2" href="ControllerCart?action=viewCart"> </a>
                        <ul class="sub-icon1 list">
                            <li><h3>Your Cart</h3></li>

                            <table border="1">   
                                <%
                                    DAOProduct dao1 = new DAOProduct();
                                    ResultSet rs1 = dao1.getData("select * from Product");
                                    int num = 0;

                                    while (em1.hasMoreElements()) {
                                        String id1 = em1.nextElement().toString();
                                        String count1 = session.getAttribute(id1).toString(); //get value
                                        String img1 = null;
                                        String name1 = null;
                                        while (rs1.next()) {
                                            if (rs1.getString(1).equals(id1)) {
                                                name1 = rs1.getString(2);
                                                img1 = rs1.getString(5);
                                                break;
                                            }
                                        }
                                        rs1.beforeFirst();
                                        num = num + Integer.parseInt(count1);
                                %>
                                <tr>
                                    <td style="padding: 10px;"><%=name1%></td>
                                    <td style="padding: 10px;"><%=count1%></td>
                                    <td style="padding: 10px;"><img style="object-fit: cover;height: 50px;" src="static/images/<%=img1%>" alt="../images/img"/></td>
                                </tr>
                                <%}%>
                            </table>  
                        </ul>
                    </li>
                </ul>
                <ul class="last"><li><a href="ControllerCart?action=viewCart">Cart(<%=num%>)</a></li></ul>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>