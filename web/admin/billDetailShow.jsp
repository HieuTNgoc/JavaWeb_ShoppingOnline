<%-- 
    Document   : BillDetailView
    Created on : Oct 4, 2021, 6:16:29 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOBillDetail"%>
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
        <title>Bill Detail Show All</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <!--Bill Detail-->
        <%
            ResultSet rsBDT = (ResultSet) request.getAttribute("rsBDT");
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
                        <h2 class="head">Bill Detail Management (list All)</h2><br>
                        <p><a href="ControllerBillDetail?action=insert">Add New Bill Detail</a></p><br>
                        <table style="padding: 10px; border: 1px solid black;" >
                            <tr>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Product ID</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Order ID</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Quantity</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Price</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Total</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Update/Delete</th>

                            </tr>
                            <% while (rsBDT.next()) {%>
                            <tr>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsBDT.getString(1)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsBDT.getString(2)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsBDT.getString(3)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsBDT.getString(4)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsBDT.getString(5)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><a href="ControllerBillDetail?action=showDetail&oID=<%=rsBDT.getString(2)%>">-- Go --></a></td>
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
