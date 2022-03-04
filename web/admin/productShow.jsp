<%-- 
    Document   : ProductView
    Created on : Oct 4, 2021, 1:27:21 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOProduct"%>
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
        <title>Product Show</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <!--Product-->
        <%
            ResultSet rsPro = (ResultSet) request.getAttribute("rsPro");
        %>

        <div class="wrap">
            <div class="section group">
                <div class="cont span_2_of_3 mens-toolbar" style="width:  75%;">
                </div>
            </div>
        </div>
        <div class="main">
            <div class="wrap">
                <div class="section group">
                    <div class="cont span_2_of_3" style="width: 75%;">
                        <h2 class="head">Product Management</h2><br>
                        <p><a href="ControllerProduct?action=insert">Add New Product</a></p><br>
                        <table style="padding: 10px; border: 1px solid black;" >
                            <tr>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">PID</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Product Name</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Quanity</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Price</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Image</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Description</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Status</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">CateName</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Update</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Delete</th>
                            </tr>
                            <%
                                while (rsPro.next()) {%>
                            <tr>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsPro.getString(1)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsPro.getString(2)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsPro.getString(3)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsPro.getString(4)%></td>
                                <td style="padding: 10px; border: 1px solid black;">
                                    <img style="object-fit: cover;height: 100px;" src="static/images/<%=rsPro.getString(5)%>" alt="../images/img"/></td>                    
                                <td style="padding: 10px; border: 1px solid black;"><%=rsPro.getString(6)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=(rsPro.getInt(7) == 1 ? "Enable" : "Disable")%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsPro.getString(10)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><a href="ControllerProduct?action=update&pid=<%=rsPro.getString(1)%>">Update</a></td>
                                <td style="padding: 10px; border: 1px solid black;"><a href="ControllerProduct?action=delete&pid=<%=rsPro.getString(1)%>">Delete</a></td>
                            </tr>
                            <%}%>

                        </table>
                        <%
                            String altShow = (String) request.getAttribute("altShow");
                            if (altShow != null) {
                        %>
                        <br><p><%=altShow%></p><%}%>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>

        <div class="wrap" style="border-block: inherit; padding: 50px;">
            <div class="section group">
                <div class="cont span_2_of_3 mens-toolbar" style="width:  75%;">
                </div>
            </div>
        </div>
        <%@include file="../components/footerAd.jsp" %>
    </body>
</html>
