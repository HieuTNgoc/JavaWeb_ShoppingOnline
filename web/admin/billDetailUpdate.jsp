<%-- 
    Document   : updateBillDetail
    Created on : Oct 10, 2021, 2:32:30 PM
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
        <title>Update Bill Detail</title>
    </head>
    <body>

        <%@include file="../components/headerAd.jsp" %> 
        <%
            ResultSet rsBDT = (ResultSet) request.getAttribute("rsBDT");
            String cname = (String) request.getAttribute("cname");
        %>
        <%
            if (rsBDT.next()) {
        %>
        <div class="login">
            <div class="wrap">
                <div class="col_1_of_login span_1_of_login">
                    <div class="login-title">
                        <h4 class="title">Update Bill Detail (quantity)</h4>
                        <div id="loginbox" class="loginbox">
                            <form action="ControllerBillDetail?action=update&pid=<%=rsBDT.getString(1)%>&oID=<%=rsBDT.getString(2)%>&cname=<%=cname%>" method="POST" id="login-form">
                                <fieldset class="input">
                                    <p id="login-form-username">
                                        <label for="modlgn_username" style="margin-right: 10px" >Order ID:</label>
                                        <label for="modlgn_username"><%=rsBDT.getString(2)%></label>
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username" style="margin-right: 10px" >Product ID:</label>
                                        <label for="modlgn_username"><%=rsBDT.getString(1)%></label>
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username" style="margin-right: 10px">Price: </label>
                                        <label for="modlgn_username"><%=rsBDT.getString(4)%></label>
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Quantity</label>
                                        <input id="modlgn_username" type="text" name="quantity" class="inputbox" size="25" autocomplete="off" value="<%=rsBDT.getString(3)%>">
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
