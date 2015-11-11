/**
 * This gets an AJAX request
 * object to be used by pages.
 */
function getRequestObject() {
	var xhttp;
	
	if (window.XMLHttpRequest) {
	    xhttp = new XMLHttpRequest();
	    } else {
	    // code for IE6, IE5
	    xhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	return xhttp;
}

/**
 * This is for testing to
 * make sure javascript is
 * working appropriately.
 */
function jsTest() {
	alert("This message should appear on the screen");
}

function deleteCase(caseID) {
	
	var params = "updateType=" + "deleteCase" + "&" 
		+ "caseID=" + caseID;
	
	var xhttp = getRequestObject();
	xhttp.responseType = "document";
	
	
	xhttp.onreadystatechange = function() {
		if (xhttp.readyState == 4) {
			var response = xhttp.response;
			
	    	if (xhttp.status == 200) {
	    		alert("Succeeded");
	    		location.href="cases.jsp";
	    	} else if (xhttp.status == 510) {
	    		alert(response.getElementById("error").innerHTML);
	    	}
	    }
	}
	
	xhttp.open("POST", "update.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
	xhttp.send(params);
}




function addCase(nameID, clientID, oppID, startID, endID, descrID, noteID) {
	
	nameText = document.getElementById(nameID).value;
	clientNum = document.getElementById(clientID).value;
	oppNum = document.getElementById(oppID).value;
	descrText = document.getElementById(descrID).value;
	noteText = document.getElementById(noteID).value;
	
	
	var params = "updateType=" + "addCase" + "&" 
		+ "caseName=" + nameText + "&"
		+ "clientID=" + clientNum + "&"
		+ "oppID=" + oppNum + "&"
		+ "description=" + descrText + "&"
		+ "note=" + noteText;
	
	var xhttp = getRequestObject();
	xhttp.responseType = "document";
	
	
	xhttp.onreadystatechange = function() {
		if (xhttp.readyState == 4) {
			var response = xhttp.response;
			
	    	if (xhttp.status == 200) {
	    		alert("Succeeded");
	    		location.href="cases.jsp";
	    	} else if (xhttp.status == 510) {
	    		alert(response.getElementById("error").innerHTML);
	    	}
	    }
	}
	
	xhttp.open("POST", "update.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
	xhttp.send(params);
}




function addCaseFull(nameID, clientID, oppID, startID, endID, descrID, noteID, startYearID, startMonthID, startDayID, endYearID, endMonthID, endDayID) {
	
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
	
	
	var params = "updateType=" + "addCase" + "&" 
		+ "caseName=" + nameText + "&"
		+ "clientID=" + clientNum + "&"
		+ "oppID=" + oppNum + "&"
		+ "description=" + descrText + "&"
		+ "note=" + noteText + "&"
		+ "startYear=" + startYear + "&"
		+ "startMonth=" + startMonth + "&"
		+ "startDay=" + startDay + "&"
		+ "endYear=" + endYear + "&"
		+ "endMonth=" + endMonth + "&"
		+ "endDay=" + endDay;
	
	var xhttp = getRequestObject();
	xhttp.responseType = "document";
	
	
	xhttp.onreadystatechange = function() {
		if (xhttp.readyState == 4) {
			var response = xhttp.response;
			
	    	if (xhttp.status == 200) {
	    		alert("Succeeded");
	    		location.href="cases.jsp";
	    	} else if (xhttp.status == 510) {
	    		alert(response.getElementById("error").innerHTML);
	    	}
	    }
	}
	
	xhttp.open("POST", "update.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
	xhttp.send(params);
}