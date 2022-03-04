<%-- 
    Document   : login
    Created on : Oct 14, 2021, 10:50:10 PM
    Author     : Admin
--%>

<%@page import="model.DAOAdmin"%>
<%@page import="model.DAOCustomer"%>
<%@page import="model.DAOProduct"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Login</title>
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
    </head>
    <body>
        <%
            String link = (String) request.getAttribute("link");
            String lgCheck = (String) request.getAttribute("lgCheck");
        %>
        <%@include file="../components/headerAd.jsp" %>
        <!-- login -->
        <div class="login">
            <div class="wrap">
                <div class="col_1_of_login span_1_of_login">
                    <div class="login-title">
                        <h4 class="title">Registered Admin</h4>
                        <div id="loginbox" class="loginbox">
                            <form action="ControllerAdmin?action=login" method="post" name="login" id="login-form">
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
                                        <p id="login-form-remember">
                                            <label for="modlgn_remember"><a href="#">Forget Your Password ? </a></label>
                                        </p>
                                        <input type="submit" name="login" class="button" value="Login"><div class="clear"></div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </div>

                    <div>
                        <p style="font-size: 1.2em;"><%=lgCheck%></p>
                        <%if (!link.equals("")) {%><a href="<%=link%>">Click here to continue...</a><%}%>
                    </div>
                </div>

                <div class="clear"></div>
            </div>
        </div>
        <%@include file="../components/footerAd.jsp" %>
    </body>
</html>
