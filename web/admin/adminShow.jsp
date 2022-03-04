<%-- 
    Document   : AdminShow
    Created on : Oct 4, 2021, 2:07:21 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOAdmin"%>
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
        <title>Admin Show</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <!--Admin-->
        <%
            ResultSet rsAd = (ResultSet) request.getAttribute("rsAd");
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
                        <h2 class="head">Admin Management</h2><br>
                        <p><a href="ControllerAdmin?action=insert">Add New Account</a></p><br>
                        <table style="padding: 10px; border: 1px solid black;" >
                            <tr>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">AdminID</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Username</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Password</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Update</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Delete</th>
                            </tr>
                            <% while (rsAd.next()) {%>
                            <tr>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsAd.getString(1)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsAd.getString(2)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsAd.getString(3)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><a href="ControllerAdmin?action=update&adminID=<%=rsAd.getString(1)%>">Update</a></td>
                                <td style="padding: 10px; border: 1px solid black;"><a href="ControllerAdmin?action=delete&adminID=<%=rsAd.getString(1)%>">Delete</a></td>
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
