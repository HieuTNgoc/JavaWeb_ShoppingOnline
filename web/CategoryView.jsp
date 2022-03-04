<%-- 
    Document   : CategoryView
    Created on : Oct 4, 2021, 1:48:08 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOCategory"%>
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
        <title>Category View</title>
    </head>
    <body>
        <%
//            DAOCategory dao = new DAOCategory();
//            ResultSet rs = dao.getData("select * from Category");

            ResultSet rs = (ResultSet) request.getAttribute("rs");
            String title = (String) request.getAttribute("title");
        %>
        <div style="margin-left: 5%;"><caption><%=title%></caption></div>
        <p><a href="ControllerCategory?action=insert">Add Category</a></p>
        <table border="1">            
            <thead>
                <tr>
                    <th>Category ID</th>
                    <th>Category Name</th>
                    <th>Status</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <%while (rs.next()) {%>
                <tr>
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getString(2)%></td>
                    <td><%=(rs.getInt(3) == 1 ? "Enable" : "Disable")%></td>
                    <td><a href="ControllerCategory?action=update&cateID=<%=rs.getString(1)%>">Update</a></td>
                    <td><a href="ControllerCategory?action=delete&cateID=<%=rs.getString(1)%>">Delete</a></td>
                </tr>
                <%}%>
            </tbody>
        </table>
    </body>
</html>
