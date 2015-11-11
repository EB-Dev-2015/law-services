package com.ebdev.lawservices.ui;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import com.ebdev.lawservices.models.LegalCase;
import com.ebdev.lawservices.models.LegalFile;
import com.ebdev.lawservices.models.Party;

/**
 * Web Based Interface for the
 * Law Services System.
 *
 * @version 1.0
 * @since 10/15/2015
 */
public class WebInterface extends UserInterface {
	
	private HttpServletResponse response;
	private JspWriter out;
	
	public WebInterface() {
		this(null);
	}
	
	public WebInterface(JspWriter out) {
		this(null, out);
	}
	
	public WebInterface(HttpServletResponse response, JspWriter out) {
		this.response = response;
		this.out = out;
	}

	/**
	 * Gets a map from partyID to Party
	 * of all the parties in the system.
	 * 
	 * @return map of parties in the system.
	 */
	public Map<Integer, Party> getPartyMap() {
		
		Map<Integer, Party> parties = new HashMap<>();
		
		try {
			for(Party party : getDB().getAllParties()) {
				parties.put(party.getPartyID(), party);
			}
		} catch (SQLException e) {
			displayMessage("Failed to retrieve parties: " + e.getMessage());
		}
		
		return parties;
	}
	
	/**
	 * Retrieves a list of all legal cases
	 * in the system.
	 * 
	 * @return List of all Legal Cases.
	 */
	public List<LegalCase> getAllCases() {
		try {
			return getDB().getAllLegalCases();
		} catch (SQLException e) {
			displayMessage("Failed to retrieve cases: " + e.getMessage());
		}
		
		// If fails, return an empty list.
		return new ArrayList<LegalCase>();
	}
	
	/**
	 * Retrieves a list of all parties who are
	 * a client on legal cases in the system.
	 * 
	 * @return List of client parties.
	 */
	public Collection<Party> getAllClients() {
		
		Set<Party> clients = new HashSet<Party>();
		
		Map<Integer, Party> parties = getPartyMap();
		
		for (LegalCase legalCase : getAllCases()) {
			clients.add(parties.get(legalCase.getClientID()));
		}
		
		return clients;
	}
	
	/**
	 * Gets a list of a particular client's cases
	 * 
	 * @param clientID the ID of the client to retrieve cases.
	 * @return List of Legal Cases belonging to the client.
	 */
	public List<LegalCase> getClientsCases(int clientID) {
		
		List<LegalCase> cases = new ArrayList<>();
		
		for (LegalCase legalCase : getAllCases()) {
			if (legalCase.getClientID() == clientID) {
				cases.add(legalCase);
			}
		}
		
		// If fails, return an empty list.
		return cases;
	}
	
	/**
	 * Gets the LegalCase associated with
	 * a specific legal case.
	 * 
	 * @param caseID of the case to get.
	 * @return the legal case
	 */
	public LegalCase getLegalCase(int caseID) {
		try {
			return getDB().getLegalCase(caseID);
		} catch (SQLException e) {
			displayMessage("Failed to retrieve case: " + e.getMessage());
		}
		
		return null;
	}
	
	/**
	 * Gets the files associated with
	 * a specific legal case.
	 * 
	 * @param caseID of the case to get files of.
	 * @return List of legal files used in this case.
	 */
	public List<LegalFile> getLegalCasesFiles(int caseID) {
		
		List<LegalFile> files = new ArrayList<>();
		
		try {
			for (LegalFile file : getDB().getAllFiles()) {
				if (file.getCaseID() == caseID)
					files.add(file);
			}
		} catch (SQLException e) {
			displayMessage("Failed to retrieve files: " + e.getMessage());
		}
		
		return files;
	}
	
	/**
	 * Adds a legal case to the system.
	 */
	public void addLegalCase(String caseName, int clientID, int opposistionID, String description, String note) {
		try {
			getDB().insertLegalCase(caseName, clientID, opposistionID, new java.util.Date(), new java.util.Date(), description, note);
		} catch (SQLException e) {
			displayMessage("Failed to add legal case: " + e.getMessage());
		}
	}
	
	/**
	 * Adds a legal case to the system.
	 */
	public void addLegalCase(String caseName, int clientID, int opposistionID, String description, String note, int startYear, int startMonth, int startDay, int endYear, int endMonth, int endDay) {
		
		java.util.Calendar startC = java.util.Calendar.getInstance();
		startC.set(startYear, startMonth - 1, startDay, 0, 0, 0);
		
		java.util.Calendar endC = java.util.Calendar.getInstance();
		endC.set(endYear, endMonth - 1, endDay, 0, 0, 0);

		
		try {
			getDB().insertLegalCase(caseName, clientID, opposistionID, startC.getTime(), endC.getTime(), description, note);
		} catch (SQLException e) {
			displayMessage("Failed to add legal case: " + e.getMessage());
		}
	}
	
	/**
	 * Deletes a legal case from the system.
	 * 
	 * @param caseID
	 */
	public void deleteLegalCase(int caseID) {
		try {
			getDB().deleteLegalCase(caseID);
		} catch (SQLException e) {
			displayMessage("Failed to delete legal case: " + e.getMessage());
		}
	}
	
	@Override
	protected void kill() {
		// Kills tomcat
		System.exit(0);
	}

	@Override
	protected void displayMessage(String message) {
		if (out != null) {
			
			try {
				out.print("<p id=\"error\">" + message + "</p>");
			} catch (IOException e) {
				System.out.println("Error displaying message: " + e.getMessage());
			}
			
			if (response != null) {
				response.setStatus(510);
			}
		}
		
		System.out.println(message);
	}
}
