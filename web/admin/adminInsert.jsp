<%-- 
    Document   : insertAdmin
    Created on : Oct 10, 2021, 12:31:17 AM
    Author     : Admin
--%>

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
        <title>Insert Admin</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <div class="login">
            <div class="wrap">
                <div class="col_1_of_login span_1_of_login">
                    <div class="login-title">
                        <h4 class="title">Create new Admin account</h4>
                        <div id="loginbox" class="loginbox">
                            <form action="ControllerAdmin?action=insert" method="post" id="login-form">
                                <fieldset class="input">
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Username</label>
                                        <input id="modlgn_username" type="text" name="username" class="inputbox" size="25" autocomplete="off">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Password</label>
                                        <input id="modlgn_passwd" type="password" name="password" class="inputbox" size="25" autocomplete="off">
                                    </p>
                                    <div class="remember">
                                        <input type="submit" name="submit" class="button" value="Submit"><div class="clear"></div>
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
        <%@include file="../components/footerAd.jsp" %>
    </body>
</html>
