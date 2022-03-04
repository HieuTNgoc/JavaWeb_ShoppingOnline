<%-- 
    Document   : insertBill
    Created on : Oct 15, 2021, 3:52:02 AM
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
        <title>Insert Bill</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <%
            ResultSet rs = (ResultSet) request.getAttribute("rs");
            String total = (String) request.getAttribute("total");
            if (rs.next()) {
        %>
        <div class="login">
            <div class="wrap">
                <div class="col_1_of_login span_1_of_login">
                    <div class="login-title">
                        <h4 class="title">Create new Customer account</h4>
                        <div id="loginbox" class="loginbox">
                            <form action="ControllerCart?action=addBill" method="POST" id="login-form">
                                <fieldset class="input">
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Order ID</label>
                                        <input id="modlgn_username" type="text" name="oID" class="inputbox" size="25" autocomplete="off">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Order Date</label>
                                        <input id="modlgn_username" type="text" name="dateTime" class="inputbox" size="25" autocomplete="off">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Customer ID</label>
                                        <input id="modlgn_username" type="text" name="cid" class="inputbox" size="25" autocomplete="off" value="<%=rs.getString(1)%>">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Customer Name</label>
                                        <input id="modlgn_username" type="text" name="cname" class="inputbox" size="25" autocomplete="off" value="<%=rs.getString(2)%>">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Customer Phone</label>
                                        <input id="modlgn_passwd" type="text" name="cphone" class="inputbox" size="25" autocomplete="off" value="<%=rs.getString(3)%>">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Address</label>
                                        <input id="modlgn_passwd" type="text" name="cAddress" class="inputbox" size="25" autocomplete="off" value="<%=rs.getString(4)%>">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Total</label>
                                        <input id="modlgn_passwd" type="text" name="total" class="inputbox" size="25" autocomplete="off" value="<%=total%>">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Status</label> 
                                        <input id="modlgn_username" type="radio" name="status" value="0" />Waiting
                                        <input id="modlgn_username" type="radio" name="status" value="1" />Processing
                                        <input id="modlgn_username" type="radio" name="status" value="2" />Done
                                    </p>
                                    <div class="remember">
                                        <input type="submit" name="submit" class="button" value="submit"><div class="clear"></div>
                                    </div>
                                </fieldset>
                            </form>

                            <%
                                String altIns = (String) request.getAttribute("altIns");
                                if (altIns != null) {
                            %>
                            <br><p style="font-size: 1.2em;"><%=altIns%></p><%}%>
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

