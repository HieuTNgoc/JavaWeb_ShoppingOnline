<%-- 
    Document   : BillView
    Created on : Oct 4, 2021, 2:15:56 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOBill"%>
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
        <title>Bill Show</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <!--Bill-->
        <%
            ResultSet rsB = (ResultSet) request.getAttribute("rsB");
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
                        <h2 class="head">Bill Management</h2><br>
                        <p><a href="ControllerBill?action=insert">Add New Bill</a></p><br>
                        <table style="padding: 10px; border: 1px solid black;" >
                            <tr>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Order ID</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Date Create</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Customer ID</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Customer Name</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Customer Phone</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Customer Address</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Total Money</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Status</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Update</th>
                                <th style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Delete</th>
                            </tr>
                            <% while (rsB.next()) {%>
                            <tr>
                                <td style="padding: 10px; border: 1px solid black;">
                                    <a href="ControllerBillDetail?action=showDetail&oID=<%=rsB.getString(1)%>
                                       &cname=<%=rsB.getString(3)%>"><%=rsB.getString(1)%></a></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsB.getString(2)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsB.getString(8)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsB.getString(3)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsB.getString(4)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsB.getString(5)%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=rsB.getString(6)%></td>
                                <%if (rsB.getInt(7) == 0) {%>
                                <td style="padding: 10px; border: 1px solid black;">Waiting</td>
                                <%}%>
                                <%if (rsB.getInt(7) == 1) {%>
                                <td style="padding: 10px; border: 1px solid black;">Processing</td>
                                <%}%>
                                <%if (rsB.getInt(7) == 2) {%>
                                <td style="padding: 10px; border: 1px solid black;">Done</td>
                                <%}%>
                                <td style="padding: 10px; border: 1px solid black;"><a href="ControllerBill?action=update&oID=<%=rsB.getString(1)%>">Update</a></td>
                                <td style="padding: 10px; border: 1px solid black;"><a href="ControllerBill?action=delete&oID=<%=rsB.getString(1)%>">Delete</a></td>
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
