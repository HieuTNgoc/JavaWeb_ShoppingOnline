<%-- 
    Document   : home
    Created on : Oct 26, 2021, 8:50:52 PM
    Author     : Admin
--%>

<%@page import="model.DAOProduct"%>
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
        <%
            DAOCustomer dao = new DAOCustomer();
            ResultSet rsCate = dao.getData("select * from Category where Category.status='1'");
            ResultSet rsPro = (ResultSet) request.getAttribute("rsPro");
            String title = (String) request.getAttribute("title");
            String result = (String) request.getAttribute("result");
        %>
        <div class="rsidebar span_1_of_left" style="float: right;    padding: 100px 10px; margin: 0 3% 0 0;">
            <h5 class="m_1"><a href="ControllerShop?action=product">Categories</a></h5>
            <ul class="kids">
                <%while (rsCate.next())
                        if (rsCate.getInt(3) == 1) {%>
                <li><a href="ControllerShop?action=product&cid=<%=rsCate.getString(1)%>"><%=rsCate.getString(2)%></a></li>
                    <%}
                        rsCate.beforeFirst();%>
            </ul>
        </div>
            
        <div class="main">
            <div class="wrap">
                <div class="section group">
                    <div class="cont span_2_of_3" style="width: 75%;">
                        <h2 class="head"><%=title%></h2>
                        <div class="mens-toolbar">
                            <div class="sort" style="width: 70%;">
                                <div class="sort-by" >
                                    <form action="ControllerShop?action=product" method="POST">
                                        <label>Search By Name</label>
                                        <input style="margin-right: 20px;" type="text" name="name" value="" />
                                        
                                        <label>Category</label>
                                        <select style="margin-right: 20px;">
                                            <option name="c" value="">All</option>
                                            <%while (rsCate.next()) {%>
                                            <option name="cid" value="<%=rsCate.getString(1)%>"><%=rsCate.getString(2)%></option>
                                            <%}
                                                rsCate.beforeFirst();%>
                                        </select>
                                        
                                        <br><br>
                                        <label>Price</label>
                                        <input style="margin-right: 20px;" type="text" name="pprice" value="" />
                                        
                                        <br><br>
                                        <label>Order By Price</label>
                                        <input style="margin-right: 20px;" type="radio" name="Sort" value="ASC" />Ascending 
                                        <input style="margin-right: 20px;" type="radio" name="Sort" value="DESC" />Descending 
                                        <input type="submit" value="Search" name="submit" />
                                        <br><br>
                                        <label><%=result%></label>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <%if (rsPro.wasNull()) {%>
                        <h3>No Product.</h3>
                        <%return;
                            }
                            while (rsPro.next())
                                if (rsPro.getInt(7) == 1) {%>
                        <div class="top-box">
                            <div class="col_1_of_3 span_1_of_3"> 
                                <a href="single.html">
                                    <div class="inner_content clearfix" style="height: 380px;">
                                        <div class="product_image">
                                            <img style="object-fit: cover;height: 280px;" src="static/images/<%=rsPro.getString(5)%>" alt="../images/<%=rsPro.getString(5)%>"/>
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
                                </a>
                            </div>
                            <% while (rsPro.next())
                                    if (rsPro.getInt(7) == 1) {%>
                            <div class="col_1_of_3 span_1_of_3"> 
                                <a href="single.html">
                                    <div class="inner_content clearfix" style="height: 380px; ">
                                        <div class="product_image">
                                            <img style="object-fit: cover;height: 280px;" src="static/images/<%=rsPro.getString(5)%>" alt="../images/<%=rsPro.getString(5)%>"/>
                                        </div>
                                        <!--<div class="sale-box"><span class="on_sale title_shop">New</span></div>-->	
                                        <div class="price" >
                                            <div class="cart-left" style="position: absolute; bottom: 15px;left: 15px;">
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
                                </a>
                            </div>
                            <%break;
                                }%>   
                            <% while (rsPro.next())
                                    if (rsPro.getInt(7) == 1) {%>
                            <div class="col_1_of_3 span_1_of_3"> 
                                <a href="single.html">
                                    <div class="inner_content clearfix" style="height: 380px;">
                                        <div class="product_image">
                                            <img style="object-fit: cover; height: 280px;" src="static/images/<%=rsPro.getString(5)%>" alt="../images/<%=rsPro.getString(5)%>"/>
                                        </div>
                                        <!--<div class="sale-box"><span class="on_sale title_shop">New</span></div>-->	
                                        <div class="price" >
                                            <div class="cart-left" style="position: absolute; bottom: 15px;left: 15px;">
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
                                </a>
                            </div>
                            <%break;
                                }%> 
                            <div class="clear"></div>
                        </div>
                        <%}%>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        <%@include file="../components/footer.jsp" %>
    </body>
</html>