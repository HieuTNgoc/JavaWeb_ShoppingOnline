<%-- 
    Document   : updateProduct
    Created on : Oct 8, 2021, 12:54:40 PM
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
        <title>Update Product</title>
    </head>
    <body>
        <%@include file="../components/headerAd.jsp" %> 
        <%
            DAOCategory dao = new DAOCategory();
            ResultSet rsCate = dao.getData("select * from Category");
            ResultSet rsPro = (ResultSet) request.getAttribute("rsPro");
        %>
        <%if (rsPro.next()) {%>
        <div class="login">
            <div class="wrap">
                <div class="col_1_of_login span_1_of_login">
                    <div class="login-title">
                        <h4 class="title">Update Product</h4>
                        <div id="loginbox" class="loginbox">
                            <form action="ControllerProduct?action=update&pid=<%=rsPro.getString(1)%>" method="POST" id="login-form">
                                <fieldset class="input">
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Category</label>
                                        <select name="cateID" size="1">

                                            <% while (rsCate.next()) {%>
                                            <% if (rsCate.getString(1).equals(rsPro.getString(8))) {%>
                                            <option value="<%=rsCate.getInt(1)%>" selected><%=rsCate.getString(2)%></option>
                                            <%} else {%>
                                            <option value="<%=rsCate.getInt(1)%>"><%=rsCate.getString(2)%></option>
                                            <%}%>
                                            <% }%>

                                        </select>
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Product ID</label>
                                        <input id="modlgn_username" type="text" name="pid" class="inputbox" size="25" value="<%=rsPro.getString(1)%>">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Product name</label>
                                        <input id="modlgn_username" type="text" name="name" class="inputbox" size="12" value="<%=rsPro.getString(2)%>">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Quantity</label>
                                        <input id="modlgn_username" type="text" name="quantity" class="inputbox" size="25" value="<%=rsPro.getString(3)%>">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Price</label>
                                        <input id="modlgn_username" type="text" name="price" class="inputbox" size="25" value="<%=rsPro.getString(4)%>">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Image</label>
                                        <input id="modlgn_passwd" type="text" name="image" class="inputbox" size="25" value="<%=rsPro.getString(5)%>">
                                    </p>
                                    <p id="login-form-password">
                                        <label for="modlgn_passwd">Description</label>
                                        <input id="modlgn_passwd" type="text" name="description" class="inputbox" size="25" value="<%=rsPro.getString(6)%>">
                                    </p>
                                    <p id="login-form-username">
                                        <label for="modlgn_username">Status</label> 
                                        <input id="modlgn_username" type="radio" name="status" value="1" <%=(rsPro.getInt(7) == 1 ? "checked" : "")%>/>Enable
                                        <input id="modlgn_username" type="radio" name="status" value="0" <%=(rsPro.getInt(7) == 0 ? "checked" : "")%> />Disable
                                    </p>
                                    <div class="remember">
                                        <input type="submit" name="submit" class="button" value="submit"><div class="clear"></div>
                                    </div>
                                </fieldset>
                            </form>

                            <%
                                String altUp = (String) request.getAttribute("altUp");
                                if (altUp != null) {
                            %>
                            <br><p style="font-size: 1.2em;"><%=altUp%></p><%}%>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <%}%>
        <%@include file="../components/footerAd.jsp" %>
    </body>
</html>
