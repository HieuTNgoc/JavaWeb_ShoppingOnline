<%-- 
    Document   : home
    Created on : Oct 26, 2021, 8:50:52 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>Shop</title>
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
        <!-- start slider -->
        <div id="fwslider">
            <div class="slider_container">
                <div class="slide">
                    <img style="object-fit: cover;height: 450px;" src="static/images/bannerWathc.jpg" alt=""/>
                </div>
                <div class="slide">
                    <img style="object-fit: cover;height: 450px;" src="static/images/phone-banner.jpg" alt=""/>
                </div>
                <div class="slide"> 
                    <img style="object-fit: cover;height: 450px;" src="static/images/banner_laptop.jpg" alt=""/>
                </div>
                <div class="slide">
                    <img style="object-fit: cover;height: 450px;" src="static/images/banner_laptop.jpg" alt=""/>
                </div>
                <!--/slide -->
            </div>
            <div class="timers"></div>
            <div class="slidePrev"><span></span></div>
            <div class="slideNext"><span></span></div>
        </div>
        <!--/slider -->
        <%
            DAOCustomer dao = new DAOCustomer();
            ResultSet rsCate = dao.getData("select * from Category where Category.status='1'");
            ResultSet rsPro = null;
        %>
        <div class="main">
            <div class="wrap">
                <div class="section group">

                    <%while (rsCate.next()) {
                            rsPro = dao.getData("select * from Product join Category on Product.cateID='" + rsCate.getString(1) + "'");
                            while (rsPro.next())
                                if (rsPro.getInt(7) == 1) {%>

                    <div class="col_1_of_3 span_1_of_3" style="margin-left: 50px;"> 
                        <a style="font-size: 1.2em; padding-left: 5px;" href="ControllerShop?action=product&cid=<%=rsCate.getString(1)%>"><%=rsCate.getString(2)%></a>
                        <div class="inner_content clearfix" style="height: 380px;">
                            <div class="product_image">
                                <img style="object-fit: cover;height: 280px; width: 100%;" src="static/images/<%=rsPro.getString(5)%>" alt="../images/<%=rsPro.getString(5)%>"/>
                            </div>
                            <!--<div class="sale-box"><span class="on_sale title_shop">New</span></div>-->	
                            <div class="price" >
                                <div class="cart-left" style="position: absolute; bottom: 15px; left: 15px;">
                                    <p class="title"><%=rsPro.getString(2)%></p>
                                    <div class="price1">
                                        <span class="actual">$<%=rsPro.getString(4)%></span>
                                    </div>
                                </div>
                                <a href="ControllerCart?action=add&pid=<%=rsPro.getString(1)%>">
                                    <div class="cart-right" style="bottom: 10px;"></div>
                                </a>
                                <div class="clear"></div>
                            </div>				
                        </div>
                    </div>
                    <%break;
                                }
                        }%>
                    <div class="clear"></div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        <div class="clear"></div>

        <%@include file="../components/footer.jsp" %>

    </body>
</html>