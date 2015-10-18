<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.ebdev.lawservices.ui.WebInterface"%>
<%
	WebInterface wI = new WebInterface();

	pageContext.setAttribute("cases", wI.getAllCases());
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
	
	<h2>Cases</h2>
	<table>
		<tr><th>Case Name</th><th>Client Name</th><th>Opposition Name</th><th>Start Date</th><th>End Date</th></tr>
		<c:forEach var="legalCase" items="${cases}">
			<tr><td><a href="case.jsp?caseID=${legalCase.getCaseID()}">${legalCase.getName()}</a></td><td>${parties.get(legalCase.getClientID()).getFullName()}</td><td>${parties.get(legalCase.getOppositionID()).getFullName()}</td><td>${legalCase.getStart()}</td><td>${legalCase.getEnd()}</td></tr>
		</c:forEach>
	</table>

</body>
</html>