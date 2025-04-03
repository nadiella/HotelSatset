<%@ page import="models.Room" %>
<%
    Room roomModel = new Room();

    if (roomModel.isConnected()) { 
        out.print("Connection Successful: " + roomModel.getMessage() + "<br />");
    } else { 
        out.print("Connection Failed: " + roomModel.getMessage() + "<br />");
    }
%>
