package com.ebdev.lawservices.core.access;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import com.ebdev.lawservices.core.access.Accessor;

/**
 * Class for managing external access
 * to the system's core.
 *
 * @version 1.0
 * @since 9/18/2015
 */
public class ExternalAccessManager {

	/** Map of Accessors, mapped by their access keys. */
	private Map<String, Accessor> externalAccessors = new HashMap<String, Accessor>();
	
	/** Logger for the core to track access errors. */
	private Logger logger;
	
	/**
	 * Creates an Access Manager.
	 */
	public ExternalAccessManager() {
		logger = Logger.getLogger(this.getClass().getName());
	}
	
	/**
	 * Adds an external Accessor to the
	 * manager.
	 * 
	 * @param accessor to be added to manager.
	 */
	public void addExternalAccessor(Accessor accessor) {
		String accessKey = generateAccessKey(accessor);
		
		externalAccessors.put(accessKey, accessor);
		accessor.setAccessKey(accessKey);

		logger.fine("Access granted to accessor " + accessor.getClass().getName() + " : " + accessor.toString());
	}
	
	/**
	 * Kills the accessor given by calling its
	 * kill method.
	 * 
	 * @param accessor Accessor to kill.
	 */
	public void killExternalAccessor(Accessor accessor) {
		// Potentially remove accessor as well.
		// Or keep accessor so access key is not redistributed.
		accessor.kill(generateAccessKey(accessor));
		
		logger.info("Killing accessor " + accessor.getClass().getName() + " : " + accessor.toString());
	}
	
	/**
	 * Kills all accessors in this AccessManager.
	 */
	public void killAll() {
		for (Accessor a : externalAccessors.values()) {
			killExternalAccessor(a);
		}
	}
	
	/**
	 * Method for generating an access
	 * @param accessor
	 * @return
	 */
	private String generateAccessKey(Accessor accessor) {
		return accessor.toString() + (accessor.hashCode());
	}
	
	/**
	 * Gets the number of Accessors currently managed.
	 * 
	 * @return int representing num of Accessors.
	 */
	int getNumAccessors() {
		return externalAccessors.size();
	}

	/**
	 * Checks to see if access key inputed
	 * is a valid access key in the manager.
	 * 
	 * @param accessKey Access key to check.
	 * @return true if valid, false if not.
	 */
	public boolean isValidKey(String accessKey) {
		return externalAccessors.containsKey(accessKey);
	}
}
