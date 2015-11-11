<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.ebdev.lawservices.ui.WebInterface"%>
<%
	WebInterface wI = new WebInterface();

	String updateType = request.getParameter("updateType");


	if ("addCase".equals(updateType)) {

		try {
			String caseName = request.getParameter("caseName");
			int clientID = Integer.parseInt(request.getParameter("clientID"));
			int opposistionID = Integer.parseInt(request.getParameter("oppID"));
			String description = request.getParameter("description");
			String note = request.getParameter("note");
			
			
			int startYear = Integer.parseInt(request.getParameter("startYear"));
			int startMonth = Integer.parseInt(request.getParameter("startMonth"));
			int startDay = Integer.parseInt(request.getParameter("startDay"));
			
			int endYear = Integer.parseInt(request.getParameter("endYear"));
			int endMonth = Integer.parseInt(request.getParameter("endMonth"));
			int endDay = Integer.parseInt(request.getParameter("endDay"));
			
			// wI.addLegalCase(caseName, clientID, opposistionID, description, note);
			wI.addLegalCase(caseName, clientID, opposistionID, description, note, startYear, startMonth, startDay, endYear, endMonth, endDay);
			
		} catch(NumberFormatException e) {
			out.println("<p id=\"error\">Error, bad update paramters.</p>");
			response.setStatus(510);
		}
		
	} else if ("deleteCase".equals(updateType)) {
		
		try {
			int caseID = Integer.parseInt(request.getParameter("caseID"));
			
			wI.deleteLegalCase(caseID);
		} catch(NumberFormatException e) {
			out.println("<p id=\"error\">Error, bad update paramters.</p>");
			response.setStatus(510);
		}
		
	} else {
		out.println("<p id=\"error\">Error, unknown update type: " + updateType + "</p>");
		response.setStatus(510);
	}
%>