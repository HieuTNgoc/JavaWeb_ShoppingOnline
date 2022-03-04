<%@page import="model.DAOProduct"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOBill"%>
<%@page import="model.DAOCustomer"%>
<html>
    <head>
        <title>Check Out</title>
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
            DAOProduct dao = new DAOProduct();
            ResultSet rs = dao.getData("select * from Product");
        %>
        <h1></h1>
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
                        <h2 class="head">Shopping Cart Details</h2>
                        <table style="padding: 10px; border: 1px solid black;" >
                            <tr>
                                <td style="padding: 10px; border: 1px solid black; font-size: 1.2em;">Item ID</td>
                                <td style="padding: 10px; border: 1px solid black;font-size: 1.2em;">Name</td>
                                <td style="padding: 10px; border: 1px solid black;font-size: 1.2em;">Price</td>
                                <td style="padding: 10px; border: 1px solid black;font-size: 1.2em;">Quantity</td>
                                <td style="padding: 10px; border: 1px solid black;font-size: 1.2em;">Total</td>
                            </tr>
                            <%
                                double total = 0;
                                java.util.Enumeration em = session.getAttributeNames();
                                String cid = "";
                                if (em.hasMoreElements()) {
                                    cid = em.nextElement().toString();
                                }
                                while (em.hasMoreElements()) {
                                    String id = em.nextElement().toString();
                                    String count = session.getAttribute(id).toString(); //get value
                                    double x = 0;

                                    String name = null;
                                    while (rs.next()) {
                                        if (rs.getString(1).equals(id)) {
                                            name = rs.getString(2);
                                            x = rs.getDouble(4);
                                            break;
                                        }
                                    }
                                    rs.beforeFirst();
                            %>
                            <tr>
                                <td style="padding: 10px; border: 1px solid black;"><%=id%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=name%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=x%></td>
                                <td style="padding: 10px; border: 1px solid black;"><%=count%></td>
                                <% total = total + (x * Double.parseDouble(count));%>
                                <td style="padding: 10px; border: 1px solid black;"> <%=(double) (x * Double.parseDouble(count))%></td>
                            </tr>
                            <%}%>
                            <br>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>ALL</td>
                                <td><%=total%></td>
                                <td><h2 class="head"><a href="ControllerCart?action=addBill&cid=<%=cid%>&total=<%=total%>"> Add to Bill </a></h2></td>

                            </tr>
                        </table>
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
        <%@include file="../components/footer.jsp" %>
    </body>
</html>