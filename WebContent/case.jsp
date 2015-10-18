<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Map"%>
<%@ page import="com.comname.lawservices.ui.WebInterface"%>
<%@ page import="com.comname.lawservices.models.Party"%>
<%@ page import="com.comname.lawservices.models.LegalCase"%>
<%
	WebInterface wI = new WebInterface();
	Map<Integer, Party> parties = wI.getPartyMap();

	int caseID = Integer.parseInt(request.getParameter("caseID"));
	LegalCase legalCase = wI.getLegalCase(caseID);
	pageContext.setAttribute("legalCase", legalCase);
	pageContext.setAttribute("client", parties.get(legalCase.getClientID()));
	pageContext.setAttribute("opposition", parties.get(legalCase.getOppositionID()));
	pageContext.setAttribute("files", wI.getLegalCasesFiles(caseID));
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
	
	<h2>${legalCase.getName()}</h2>
	
	<h2>Case Info</h2>

	<table>
		<tr><td>Case Name</td><td>${legalCase.getName()}</td></tr>
		<tr><td>Client Name</td><td><a href="client.jsp?clientID=${client.getPartyID()}">${client.getFullName()}</a></td></tr>
		<tr><td>Opposition Name</td><td>${opposition.getFullName()}</td></tr>
		<tr><td>Start Date</td><td>${legalCase.getStart()}</td></tr>
		<tr><td>End Date</td><td>${legalCase.getEnd()}</td></tr>
		<tr><td>Description</td><td>${legalCase.getDescription()}</td></tr>
		<tr><td>Note</td><td>${legalCase.getNote()}</td></tr>		
	</table>
	
	<h2>Case Files</h2>
	
	<table>
		<tr><th>File Name</th><th>Size (Bytes)</th><th>Last Updated</th></tr>
		<c:forEach var="file" items="${files}">
			<tr><td>${file.getName()}</td><td>${file.getData().length}</td><td>${file.getUpdated()}</td></tr>
		</c:forEach>
	</table>

</body>
</html>