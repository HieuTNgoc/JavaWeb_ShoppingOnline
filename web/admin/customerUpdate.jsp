<%-- 
    Document   : updateCustomer
    Created on : Oct 10, 2021, 2:55:47 AM
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
        <title>Update Customer</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <%
            ResultSet rsCu = (ResultSet) request.getAttribute("rsCu");
        %>
        <%
            if (rsCu.next()) {
        %>
        <div class="login">
            <div class="wrap">
                <div class="col_1_of_login span_1_of_login">
                    <div class="login-title">
                        <h4 class="title">Update Customer account</h4>
                        <div id="loginbox" class="loginbox">
                            <form action="ControllerCustomer?action=update&cid=<%=rsCu.getString(1)%>" method="POST" id="login-form">
                                <fieldset class="input">
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Customer ID(<%=rsCu.getString(1)%>) - Customer Name</label>
                                        <input id="modlgn_username" type="text" name="cname" class="inputbox" size="25" autocomplete="off" value="<%=rsCu.getString(2)%>">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Customer Phone</label>
                                        <input id="modlgn_username" type="text" name="cphone" class="inputbox" size="12" autocomplete="off" value="<%=rsCu.getString(3)%>">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Customer Address</label>
                                        <input id="modlgn_username" type="text" name="address" class="inputbox" size="25" autocomplete="off" value="<%=rsCu.getString(4)%>" >
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Username</label>
                                        <input id="modlgn_username" type="text" name="username" class="inputbox" size="25" autocomplete="off" value="<%=rsCu.getString(5)%>">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Password</label>
                                        <input id="modlgn_passwd" type="password" name="password" class="inputbox" size="25" autocomplete="off" value="<%=rsCu.getString(6)%>">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Status</label> 
                                        <input id="modlgn_username" type="radio" name="status" value="1" <%=(rsCu.getInt(7) == 1 ? "checked" : "")%> />Enable
                                        <input id="modlgn_username" type="radio" name="status" value="1" <%=(rsCu.getInt(7) == 0 ? "checked" : "")%> />Disable
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
