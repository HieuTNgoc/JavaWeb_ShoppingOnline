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
        <title>Admin Home</title>
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
        <%@include file="../components/headerAd.jsp" %>


        <div class="wrap" style="margin: 50px 100px;padding: 50px;">
            <%if (adminID == null) {%>
            <div>
                <h4 style="font-size: 1.2em;" class="color4">Please Log In first!
                    <a href="ControllerAdmin?action=login">Click here to continue...</a></h4>
            </div>
            <%}%>
            <%
                String alt = (String) request.getAttribute("alt");
                if (alt != null) {
            %>
            <div>
                <h4 style="font-size: 1.2em;" class="color4"><%=alt%></h4>
            </div>
            <%}%>
            
            <%
                String slt = (String) request.getAttribute("slt");
                String link = (String) request.getAttribute("link");
                if (slt != null) {
            %>
            <div>
                <h4 style="font-size: 1.2em;" class="color4"><%=slt%></h4>
                <%if (!link.equals("")) {%><a href="<%=link%>">Click here to solve...</a><%}%>
            </div>
            <%}%>
            <div class="clear"></div>
        </div>

        <%@include file="../components/footerAd.jsp" %>
    </body>
</html>
