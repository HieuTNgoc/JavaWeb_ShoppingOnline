<%-- 
    Document   : CustomerView
    Created on : Oct 4, 2021, 1:58:36 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOCustomer"%>
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
        <title>Customer Show</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <!--Customer-->
        <%
            ResultSet rsCu = (ResultSet) request.getAttribute("rsCu");
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
                        <h2 class="head">Customer Management</h2><br>
                        <p><a href="ControllerCustomer?action=insert">Add New Customer Account</a></p><br>
                        <table style="padding: 10px; border: 1px solid black;" >
                            <tr>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Customer ID</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Customer Name</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Customer Phone</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Customer Address</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Username</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Password</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Status</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Update</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Delete</th>
                            </tr>
                            <% while (rsCu.next()) {%>
                            <tr>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsCu.getString(1)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsCu.getString(2)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsCu.getString(3)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsCu.getString(4)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsCu.getString(5)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsCu.getString(6)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=(rsCu.getInt(7) == 1 ? "Enable" : "Disable")%></td>
                                <td style="padding: 10px; border: 1px solid black;"><a href="ControllerCustomer?action=update&cid=<%=rsCu.getString(1)%>">Update</a></td>
                                <td style="padding: 10px; border: 1px solid black;"><a href="ControllerCustomer?action=delete&cid=<%=rsCu.getString(1)%>">Delete</a></td>
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
