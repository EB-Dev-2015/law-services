package com.ebdev.lawservices.ui;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ebdev.lawservices.models.LegalCase;
import com.ebdev.lawservices.models.LegalFile;
import com.ebdev.lawservices.models.Party;

public class WebInterface extends UserInterface {

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
	
	public List<LegalCase> getAllCases() {
		try {
			return getDB().getAllLegalCases();
		} catch (SQLException e) {
			displayMessage("Failed to retrieve cases: " + e.getMessage());
		}
		
		// If fails, return an empty list.
		return new ArrayList();
	}
	
	public List<Party> getAllClients() {
		
		List<Party> clients = new ArrayList<>();
		
		Map<Integer, Party> parties = getPartyMap();
		
		for (LegalCase legalCase : getAllCases()) {
			clients.add(parties.get(legalCase.getClientID()));
		}
		
		return clients;
	}
	
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
	
	public LegalCase getLegalCase(int caseID) {
		try {
			return getDB().getLegalCase(caseID);
		} catch (SQLException e) {
			displayMessage("Failed to retrieve case: " + e.getMessage());
		}
		
		return null;
	}
	
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
	
	
	@Override
	protected void kill() {
		// Kills tomcat
		System.exit(0);
	}

	@Override
	protected void displayMessage(String message) {
		System.out.println(message);
	}
}
