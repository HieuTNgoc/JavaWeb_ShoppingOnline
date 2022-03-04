<%-- 
    Document   : insertCategory
    Created on : Oct 9, 2021, 11:02:27 PM
    Author     : Admin
--%>

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
        <title>Insert Category</title>
    </head>
    <body>
        <%
            String title = (String) request.getAttribute("title");
        %>
        <form action="ControllerCategory?action=insert" method="POST">
            <table border="0">
                <caption><%=title%></caption>
                <tr>
                    <td>Category Name</td>
                    <td>
                        <input type="text" name="cateName" value="" />
                    </td>
                </tr>
                <tr>
                    <td>Status</td>
                    <td>
                        <input type="radio" name="status" value="1" />Enable
                        <input type="radio" name="status" value="0" />Disable
                    </td>
                </tr>
                <tr>
                    <td><input type="submit" value="Submit" name="submit" /></td>          
                    <td><input type="reset" value="Reset" /></td>
                </tr>
            </table>
        </form>
    </body>
</html>
