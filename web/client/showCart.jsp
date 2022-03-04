<%-- 
    Document   : showCart
    Created on : Oct 15, 2021, 12:04:49 AM
    Author     : Admin
--%>

<%@page import="model.DAOCustomer"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOProduct"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Show Cart</title>
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
        <%@include file="../components/header.jsp" %>

        <%
            DAOCustomer daoc = new DAOCustomer();
            ResultSet rsCate = daoc.getData("select * from Category where Category.status='1'");
        %>
        <div class="rsidebar span_1_of_left" style="float: right;    padding: 100px 10px; margin: 0 3% 0 0;">
            <h5 class="m_1"><a href="ControllerShop?action=product">Add more product</a></h5>
            <ul class="kids">
                <%while (rsCate.next())
                        if (rsCate.getInt(3) == 1) {%>
                <li><a href="ControllerShop?action=product&cid=<%=rsCate.getString(1)%>"><%=rsCate.getString(2)%></a></li>
                    <%}
                        rsCate.beforeFirst();%>
            </ul>
        </div>
        <!-- Show Cart -->
        <%
            ResultSet rsPro = daoc.getData("select * from Product");
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

                        <form action="ControllerCart?action=update" method="POST">
                            <h2 class="head">Shopping Cart Details</h2>
                            <table style="padding: 10px; border: 1px solid black;" >
                                <tr>
                                    <td style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Item ID</td>
                                    <td style="padding: 10px; border: 1px solid black;font-size: 1.2em;">Name</td>
                                    <td style="padding: 10px; border: 1px solid black;font-size: 1.2em;">Images</td>
                                    <td style="padding: 10px; border: 1px solid black;font-size: 1.2em;">Price</td>
                                    <td style="padding: 10px; border: 1px solid black;font-size: 1.2em;">Quantity</td>
                                    <td style="padding: 10px; border: 1px solid black;font-size: 1.2em;">Total</td>
                                    <td style="padding: 10px; border: 1px solid black;font-size: 1.2em;"> Remove</td>
                                </tr>
                                <%
                                    double total = 0;
                                    java.util.Enumeration em = session.getAttributeNames();
                                    if (em.hasMoreElements()) {
                                        em.nextElement();
                                    }
                                    while (em.hasMoreElements()) {
                                        String id = em.nextElement().toString();
                                        String count = session.getAttribute(id).toString(); //get value
                                        double x = 0;
                                        int quan = 0;
                                        String img = "";
                                        String name = "";
                                        while (rsPro.next()) {
                                            if (rsPro.getString(1).equals(id)) {
                                                name = rsPro.getString(2);
                                                quan = rsPro.getInt(3);
                                                x = rsPro.getDouble(4);
                                                img = rsPro.getString(5);
                                                break;
                                            }
                                        }
                                        rsPro.beforeFirst();
                                %>
                                <tr>
                                    <td style="padding: 10px; border: 1px solid black;"><%=id%></td>
                                    <td style="padding: 10px; border: 1px solid black;"><%=name%></td>
                                    <td style="padding: 10px; border: 1px solid black;">
                                        <img style="object-fit: cover;height: 100px;" src="static/images/<%=img%>" alt="../images/img"/></td>
                                    <td style="padding: 10px; border: 1px solid black;"><%=x%></td>
                                    <td style="padding: 10px; border: 1px solid black;"><input onchange="this.form.submit()" type="number"  min="1" max="<%=quan%>"
                                                                                               name="quantity<%=id%>" value="<%=count%>"/></td>

                                    <% total = total + (x * Double.parseDouble(count));
                                            out.println("<td style=\"padding: 10px; border: 1px solid black;\">" + (double) (x * Double.parseDouble(count)) + "</td>");
                                            out.println("<td><a href=\"ControllerCart?action=remove&pid=" + id + "\">Remove</a></td>");
                                            out.println("</tr>");

                                        }%>

                                <tr>
                                    <td ></td>
                                    <td></td>
                                    <td></td>
                                    <td style="padding: 10px; border: 1px solid black;">Total</td>
                                    <td style="padding: 10px; border: 1px solid black;"><%=total%></td>
                                    <td style="padding: 10px; border: 1px solid black;"><a href="ControllerCart?action=removeAll">Remove All</a></td>
                                </tr>
                            </table>
                        </form>
                        <div class="clear"></div>

                        <%
                            String altIns = (String) request.getAttribute("altIns");
                            if (altIns != null) {
                        %>
                        <br><p style="font-size: 1.2em;"><%=altIns%></p><%}%>
                        <br>
                        <h2 class="head"><a href="ControllerCart?action=checkOut">Solve</a></h2>

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
        <%@include file="../components/footer.jsp" %>
    </body>
</html>
