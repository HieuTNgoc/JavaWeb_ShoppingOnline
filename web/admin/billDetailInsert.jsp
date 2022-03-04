<%-- 
    Document   : insertBillDetail
    Created on : Oct 18, 2021, 9:24:21 PM
    Author     : Admin
--%>

<%@page import="model.DAOBillDetail"%>
<%@page import="model.DAOBill"%>
<%@page import="entity.BillDetail"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOProduct"%>
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
        <title>Insert Bill Detail</title>
    </head>
    <body>
        <%@include file="../components/header.jsp" %>
        <%
            DAOProduct dao = new DAOProduct();
            DAOBillDetail dd = new DAOBillDetail();
            ResultSet rs = dao.getData("select * from Product");
            String cid = "";
            String oid = (String) request.getAttribute("oid");
            java.util.Enumeration em = session.getAttributeNames();
            if (em.hasMoreElements()) {
                cid = em.nextElement().toString();
            }
            while (em.hasMoreElements()) {
                String id = em.nextElement().toString();
                String count = session.getAttribute(id).toString();
                dao.subQuantity(id, Integer.parseInt(count));
                double x = 0;
                while (rs.next()) {
                    if (rs.getString(1).equals(id)) {
                        x = rs.getDouble(4);
                        break;
                    }
                }
                double pri = x;
                rs.beforeFirst();
                x = (x * Double.parseDouble(count));
                String pid = id;
                String oID = oid;
                int quan = Integer.parseInt(count);
                double tota = x;
                BillDetail bd = new BillDetail(pid, oID, quan, pri, tota);
                dd.addBillDetail(bd);
            }
        %>
        <div class="login">
            <div class="wrap">
                <div class="col_1_of_login span_1_of_login">
                    <div class="login-title">
                        <h4 class="title"><a href="ControllerCart?action=removeAll">Take product - Save Bill Detail and Clear Cart!</a></h4>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </div>

        <%@include file="../components/footer.jsp" %>
    </body>
</html>
