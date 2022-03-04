<%-- 
    Document   : sessionClear
    Created on : Oct 18, 2021, 7:25:00 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Clear Session</title>
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
        <% session.invalidate(); %>
        <h2><a href="../ControllerHome">Back to Home.</h2>
    </body>
</html>
