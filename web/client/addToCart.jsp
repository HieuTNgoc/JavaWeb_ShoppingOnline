<%-- 
    Document   : addToCart
    Created on : Oct 14, 2021, 10:24:03 PM
    Author     : Admin
--%>

<%@page import="model.DAOProduct"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head> 
        <title>Add To Cart</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="static/css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="static/css/form.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Exo+2' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="static/js/jquery1.min.js"></script>
        <!-- start menu -->
        <link href="static/css/megamenu.css" rel="stylesheet" type="text/css" media="all" />
        <script type="text/javascript" src="static/js/megamenu.js"></script>
        <script>$(document).ready(function () {
                $(".megamenu").megamenu();
            });</script>
        <!--start slider -->
        <link rel="stylesheet" href="static/css/fwslider.css" media="all">
        <script src="static/js/jquery-ui.min.js"></script>
        <script src="static/js/css3-mediaqueries.js"></script>
        <script src="static/js/fwslider.js"></script>
        <!--end slider -->
        <script src="static/js/jquery.easydropdown.js"></script>
    </head>
    <body>
        <%
            java.util.Enumeration em = session.getAttributeNames();
            if (!em.hasMoreElements()) {%>
        <h1>You need login fist!</h1>  
        <h2><a href="ControllerHome?action=home">Back To Home.</h2>
        <%
        } else {
            String pid = request.getParameter("pid");
            Object value = session.getAttribute(pid);
            if (value == null) {
                session.setAttribute(pid, "1"); // put(key,value)               
            } else {
                int count = Integer.parseInt(value.toString()) + 1;
                session.setAttribute(pid, String.valueOf(count));
            }
        %>
        <h1>Item with id=<%=pid%> was added to the Shopping Cart</h1>
        <h2><a href="ControllerCart?action=viewCart">Show Shopping Cart</h2>
        <%}%>

    </body>
</html>