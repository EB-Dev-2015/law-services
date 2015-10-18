package com.ebdev.lawservices.core;

import java.io.IOException;
import java.util.logging.FileHandler;
import java.util.logging.Logger;

import com.ebdev.lawservices.core.access.AccessException;
import com.ebdev.lawservices.core.access.Accessor;
import com.ebdev.lawservices.core.access.ExternalAccessManager;
import com.ebdev.lawservices.db.DBUtilities;

/**
 * Core class of the system.
 */
public class Core {
	
	/** Database Utilites Object for storage. */
	private DBUtilities dbUtil;
	
	/** Logger for the core to track core errors. */
	private Logger logger;
	
	/** Manages all accessors of the core. */
	private static ExternalAccessManager accessManager = new ExternalAccessManager();
	
	/** Single instance of this core class. */
	private static Core systemInstance;
	

	/**
	 * Private constructor for Core to limit
	 * access to the Core.
	 */
	private Core() {
		
		initLogger();
		
		dbUtil = new DBUtilities();
		
		logger.info("Core started");
	}
	
	
	/**
	 * Gets the single instance of
	 * the Core object.
	 * 
	 * @return Core object.
	 */
	static Core getCore() {
		if (systemInstance == null) {
			systemInstance = new Core();
		}
		
		return systemInstance;
	}
	
	/**
	 * Gets the instance of this core,
	 * if the requester is a valid accessor.
	 * 
	 * @param accessor object requesting access.
	 * @return reference to this core.
	 * @throws AccessException
	 */
	public static Core getCore(Object accessor) throws AccessException {
		// Implement Factory to return specific core subclass based
		// upon accessor type in order to limit core functionalities
		// each accessor has access to.
		if (accessor instanceof Accessor) {
			accessManager.addExternalAccessor((Accessor) accessor);
			
			return getCore();
		}
		
		throw new AccessException("Not a valid external accessor.");
	}

	/**
	 * Give reference to the database
	 * to the caller.
	 * 
	 * @return reference to dbUtil.
	 * @throws AccessException 
	 */
	public DBUtilities accessDatabase(String accessKey) throws AccessException {
		if (accessManager.isValidKey(accessKey))
			return dbUtil;
		else
			throw new AccessException("Invalid access key.");
	}
	
	/**
	 * Initializes the logger handler and core logger.
	 */
	private void initLogger() {
		
		logger = Logger.getLogger(this.getClass().getName());
		
		try { 
			FileHandler handler = new FileHandler(Constants.CORE_LOG_FILE, true);
			Logger.getLogger(Logger.GLOBAL_LOGGER_NAME).addHandler(handler);
		} catch (SecurityException e) {
			logger.severe("Unable to add file handler due to security issues: " + e.getMessage());
			
		} catch (IOException e) {
			logger.severe("Unable to add file handler due to IO issues: " + e.getMessage());
		}
	}
}
