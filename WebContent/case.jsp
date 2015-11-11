<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Collection"%>
<%@ page import="com.ebdev.lawservices.core.Constants"%>
<%@ page import="com.ebdev.lawservices.ui.WebInterface"%>
<%@ page import="com.ebdev.lawservices.models.Party"%>
<%@ page import="com.ebdev.lawservices.models.LegalCase"%>
<%
	WebInterface wI = new WebInterface(out);

	int caseID = Integer.parseInt(request.getParameter("caseID"));
	
	if ((caseID != Constants.NULL_ID)) {
		Map<Integer, Party> parties = wI.getPartyMap();

		LegalCase legalCase = wI.getLegalCase(caseID);
		pageContext.setAttribute("legalCase", legalCase);
		pageContext.setAttribute("client", parties.get(legalCase.getClientID()));
		pageContext.setAttribute("opposition", parties.get(legalCase.getOppositionID()));
		pageContext.setAttribute("files", wI.getLegalCasesFiles(caseID));
	} else {
		Collection<Party> parties = wI.getPartyMap().values();
		pageContext.setAttribute("parties", parties);
		pageContext.setAttribute("legalCase", null);
	}
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
	
	<c:choose>
		<c:when test="${legalCase != null}">
			<button onclick="deleteCase(${legalCase.getCaseID()})">Delete Case</button>
			<table>
				<tr><td>Case Name</td><td>${legalCase.getName()}</td></tr>
				<tr><td>Client Name</td><td><a href="client.jsp?clientID=${client.getPartyID()}">${client.getFullName()}</a></td></tr>
				<tr><td>Opposition Name</td><td>${opposition.getFullName()}</td></tr>
				<tr><td>Start Date</td><td>${legalCase.getStart()}</td></tr>
				<tr><td>End Date</td><td>${legalCase.getEnd()}</td></tr>
				<tr><td>Description</td><td>${legalCase.getDescription()}</td></tr>
				<tr><td>Note</td><td>${legalCase.getNote()}</td></tr>		
			</table>
		</c:when>
		<c:otherwise>
			<button onclick="addCaseFull('caseName', 'clientID', 'oppID', 'start', 'end', 'description', 'note', 'start_year', 'start_month', 'start_day', 'end_year', 'end_month', 'end_day')">Submit Case</button>
			<table>
				<tr><td>Case Name</td><td><input type="text" id="caseName"></td></tr>
				<tr><td>Client Name</td><td>
					<select id="clientID">
						<option value="0">No Client</option>
						<c:forEach var="party" items="${parties}">
							<option value="${party.getPartyID()}">${party.getFullName()}</option>
						</c:forEach>
					</select></td></tr>
				<tr><td>Opposition Name</td><td>
					<select id="oppID">
						<option value="0">No Opposition</option>
						<c:forEach var="party" items="${parties}">
							<option value="${party.getPartyID()}">${party.getFullName()}</option>
						</c:forEach>
					</select></td></tr>
				<tr><td>Start Date</td><td>
					<select id="start_month">
						<c:forEach begin="1" end="12" varStatus="loop">
							<option value="${loop.index}">${loop.index}</option>
						</c:forEach>
					</select>
					<select id="start_day">
						<c:forEach begin="1" end="31" varStatus="loop">
							<option value="${loop.index}">${loop.index}</option>
						</c:forEach>
					</select>
					<select id="start_year">
						<c:forEach begin="1995" end="2050" varStatus="loop">
							<option value="${loop.index}">${loop.index}</option>
						</c:forEach>
					</select></td></tr>
				<tr><td>End Date</td><td>
					<select id="end_month">
						<c:forEach begin="1" end="12" varStatus="loop">
							<option value="${loop.index}">${loop.index}</option>
						</c:forEach>
					</select>
					<select id="end_day">
						<c:forEach begin="1" end="31" varStatus="loop">
							<option value="${loop.index}">${loop.index}</option>
						</c:forEach>
					</select>
					<select id="end_year">
						<c:forEach begin="1995" end="2050" varStatus="loop">
							<option value="${loop.index}">${loop.index}</option>
						</c:forEach>
					</select></td></tr>
				<tr><td>Description</td><td><input type="text" id="description"></td></tr>
				<tr><td>Note</td><td><input type="text" id="note"></td></tr>		
			</table>
		</c:otherwise>
	</c:choose>
	
	<h2>Case Files</h2>
	
	<table>
		<tr><th>File Name</th><th>Size (Bytes)</th><th>Last Updated</th></tr>
		<c:forEach var="file" items="${files}">
			<tr><td>${file.getName()}</td><td>${file.getData().length}</td><td>${file.getUpdated()}</td></tr>
		</c:forEach>
	</table>

</body>
<script src="javascript/jsmain.js">
	function addCase2(submitID, nameID, clientID, oppID, descrID, noteID, startYearID, startMonthID, startDayID, endYearID, endMonthID, endDayID) {
		
		button = document.getElementById(submitID).enabled = false;
		
		nameText = document.getElementById(nameID).value;
		clientNum = document.getElementById(clientID).value;
		oppNum = document.getElementById(oppID).value;
		descrText = document.getElementById(descrID).value;
		noteText = document.getElementById(noteID).value;
		
		startYear = document.getElementById(startYearID).value;
		startMonth = document.getElementById(startMonthID).value;
		startDay = document.getElementById(startDayID).value;
		
		endYear = document.getElementById(endYearID).value;
		endMonth = document.getElementById(endMonthID).value;
		endDay= document.getElementById(endDayID).value;
		
		submitAddCase(nameText, clientNum, oppNum, descrText, noteText, function(button){ button.enabled = true;});
	}
</script>
</html>