<%-- 
    Document   : insertProduct
    Created on : Oct 9, 2021, 5:40:29 PM
    Author     : Admin
--%>

<%@page import="model.DAOCategory"%>
<%@page import="java.sql.ResultSet"%>
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
        <title>Insert Product</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <%
            DAOCategory dao = new DAOCategory();
            ResultSet rsCate = dao.getData("select * from Category");
        %>
        <div class="login">
            <div class="wrap">
                <div class="col_1_of_login span_1_of_login">
                    <div class="login-title">
                        <h4 class="title">Insert new Product</h4>
                        <div id="loginbox" class="loginbox">
                            <form action="ControllerProduct?action=insert" method="POST" id="login-form">
                                <fieldset class="input">
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Category</label>
                                        <select name="cateID" size="1">
                                            <% while (rsCate.next()) {%>
                                            <option value="<%=rsCate.getInt(1)%>"><%=rsCate.getString(2)%></option>
                                            <% }%>
                                        </select>
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Product ID</label>
                                        <input id="modlgn_username" type="text" name="pid" class="inputbox" size="25">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Product name</label>
                                        <input id="modlgn_username" type="text" name="name" class="inputbox" size="12">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Quantity</label>
                                        <input id="modlgn_username" type="text" name="quantity" class="inputbox" size="25">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Price</label>
                                        <input id="modlgn_username" type="text" name="price" class="inputbox" size="25">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Image</label>
                                        <input id="modlgn_passwd" type="text" name="image" class="inputbox" size="25">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Description</label>
                                        <input id="modlgn_passwd" type="text" name="description" class="inputbox" size="25">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Status</label> 
                                        <input id="modlgn_username" type="radio" name="status" value="1" />Enable
                                        <input id="modlgn_username" type="radio" name="status" value="0" />Disable
                                    </p>
                                    <div class="remember">
                                        <input type="submit" name="submit" class="button" value="submit"><div class="clear"></div>
                                    </div>
                                </fieldset>
                            </form>

                            <%
                                String altIns = (String) request.getAttribute("altIns");
                                if (altIns != null) {
                            %>
                            <br><p style="font-size: 1.2em;"><%=altIns%></p><%}%>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <%@include file="../components/footerAd.jsp" %>
    </body>
</html>
