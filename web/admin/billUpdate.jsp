<%-- 
    Document   : updateBill
    Created on : Oct 10, 2021, 12:24:33 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="static/css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Exo+2' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="static/js/jquery1.min.js"></script>
        <!-- start menu -->
        <link href="static/css/megamenu.css" rel="stylesheet" type="text/css" media="all" />
        <script type="text/javascript" src="static/js/megamenu.js"></script>
        <script>$(document).ready(function () {
                $(".megamenu").megamenu();
            });</script>
        <!-- dropdown -->
        <script src="static/js/jquery.easydropdown.js"></script>
        <title>Update Bill</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <%
            ResultSet rsB = (ResultSet) request.getAttribute("rsB");
        %>
        <%
            if (rsB.next()) {
        %>
        <div class="login">
            <div class="wrap">
                <div class="col_1_of_login span_1_of_login">
                    <div class="login-title">
                        <h4 class="title">Update Bill</h4>
                        <div id="loginbox" class="loginbox">
                            <form action="ControllerBill?action=update&oID=<%=rsB.getString(1)%>" method="POST" id="login-form">
                                <fieldset class="input">
                                    <p id="login-form-username">
                                        <label for="modlgn_username" style="margin-right: 10px" >Order ID </label>
                                        <label for="modlgn_username"><%=rsB.getString(1)%></label>
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username" style="margin-right: 10px">Order Date </label>
                                        <label for="modlgn_username"><%=rsB.getString(2)%></label>
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username" style="margin-right: 10px">Customer ID </label>
                                        <label for="modlgn_username"><%=rsB.getString(1)%></label>
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Customer Name</label>
                                        <input id="modlgn_username" type="text" name="cname" class="inputbox" size="25" autocomplete="off" value="<%=rsB.getString(3)%>">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Customer Phone</label>
                                        <input id="modlgn_passwd" type="text" name="cphone" class="inputbox" size="25" autocomplete="off" value="<%=rsB.getString(4)%>">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Address</label>
                                        <input id="modlgn_passwd" type="text" name="cAdress" class="inputbox" size="25" autocomplete="off" value="<%=rsB.getString(5)%>">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_username" style="margin-right: 10px">Total </label>
                                        <label for="modlgn_username"><%=rsB.getString(6)%></label>
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Status</label> 
                                        <input id="modlgn_username" type="radio" name="status" value="0" <%=(rsB.getInt(7) == 0 ? "checked" : "")%>/>Waiting
                                        <input id="modlgn_username" type="radio" name="status" value="1" <%=(rsB.getInt(7) == 1 ? "checked" : "")%>/>Processing
                                        <input id="modlgn_username" type="radio" name="status" value="2" <%=(rsB.getInt(7) == 2 ? "checked" : "")%>/>Done
                                    </p>
                                    <div class="remember">
                                        <input type="submit" name="submit" class="button" value="submit"><div class="clear"></div>
                                    </div>
                                </fieldset>
                            </form>
                            <%
                                String altUp = (String) request.getAttribute("altUp");
                                if (altUp != null) {
                            %>
                            <br><p style="font-size: 1.2em;"><%=altUp%></p><%}%>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </div>

        <%}%>
        <%@include file="../components/footerAd.jsp" %>
    </body>
</html>
