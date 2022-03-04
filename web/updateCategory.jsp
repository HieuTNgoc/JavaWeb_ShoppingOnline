<%-- 
    Document   : updateCategory
    Created on : Oct 8, 2021, 1:29:35 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
              integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <link href="../static/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="static/css/main.css">
        <title>Update Category</title>
    </head>
    <body>
        <%
            ResultSet rs = (ResultSet) request.getAttribute("update");
            String title = (String) request.getAttribute("title");
        %>
        <%if (rs.next()) {%>
        <form action="ControllerCategory?action=update&cateID=<%=rs.getInt(1)%>" method="POST">

            <table border="0">
                <caption><%=title%></caption>
                <tr>
                    <td>Category ID</td>
                    <td>
                        <p><%=rs.getInt(1)%></p>
                    </td>
                </tr>
                <tr>
                    <td>Category Name</td>
                    <td>
                        <input type="text" name="cateName" value="<%=rs.getString(2)%>" />
                    </td>
                </tr>
                <tr>
                    <td>Status</td>
                    <td>
                        <input type="radio" name="status" value="1" <%=(rs.getInt(3) == 1 ? "checked" : "")%>/>Enable
                        <input type="radio" name="status" value="0" <%=(rs.getInt(3) == 0 ? "checked" : "")%>/>Disable
                    </td>
                </tr>

                <tr>
                    <td><input type="submit" value="Submit" name="submit" /></td>          
                    <td><input type="reset" value="Reset" /></td>
                </tr>
            </table>
        </form>
        <%}%>
    </body>
</html>
