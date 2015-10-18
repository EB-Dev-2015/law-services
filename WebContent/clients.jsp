<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.ebdev.lawservices.ui.WebInterface"%>
<%
	WebInterface wI = new WebInterface();

	pageContext.setAttribute("clients", wI.getAllClients());
	pageContext.setAttribute("parties", wI.getPartyMap());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="main.css" rel="stylesheet">
<title>Law Services</title>
</head>
<body>

<h1>Law Services</h1>
	
	<h2>Main Menu</h2>
	<ul>
		<li><a href="index.jsp">Home</a></li>
		<li><a href="cases.jsp">Cases</a></li>
		<li><a href="clients.jsp">Clients</a></li>
	</ul>
	
	<h2>Clients</h2>
	<table>
		<tr><th>Client Name</th></tr>
		<c:forEach var="client" items="${clients}">
			<tr><td><a href="client.jsp?clientID=${client.getPartyID()}">${client.getFullName()}</a></td></tr>
		</c:forEach>
	</table>

</body>
</html>