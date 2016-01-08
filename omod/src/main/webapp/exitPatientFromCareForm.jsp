<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<openmrs:htmlInclude file="/scripts/calendar/calendar.js" />
<openmrs:htmlInclude file="/moduleResources/tracpatienttransfer/patienttransfers.css" />

<openmrs:require privilege="Exit a patient from care" otherwise="/login.htm"/>

<script type="text/javascript">
	var $toip = jQuery.noConflict();
</script>

<h2><spring:message code="tracpatienttransfer.title" /></h2>

<br/>
<b class="boxHeader"><spring:message code="tracpatienttransfer.title"/></b>
<div class="box" id="formTransfer">
	<form method="post" action="exitPatientFromCare.form?patientId=${param.patientId}&save=true" name="exitPatientFromCareForm">
		
		<div id="errorDivNewId" style="margin-bottom: 5px;"></div>
		
		<table>
			<tr>
				<td width="250px"><input id="prtSave" value="${param.save}" type="hidden"/></td>
				<td></td>
				<td><input name="patientId" value="${patient.patientId}" type="hidden"/></td>
				<td></td>
			</tr>
			<tr>
				<td><input id="patientTransferedOutConceptId" value="${patientTransferedOutConceptId}" type="hidden"/></td>
				<td></td>
				<td><input id="patientDeadConceptId" value="${patientDeadConceptId}" type="hidden"/></td>
				<td></td>
			</tr>
			<tr>
		   		<td><spring:message code="Patient.names"/></td>
				<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.patientNames"/>"/></td>
		       	<td><b>${patient.personName}</b></td>
				<td></td>
		  	</tr>
		    <tr>
		   		<td><spring:message code="Encounter.provider" /></td>
				<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.provider"/>"/></td>
		       	<td><select name="provider" id="provider">
		       			<option value="0">--</option>
		       			<c:forEach items="${providers}" var="provider">
		       				<option value="${provider.key}" <c:if test="${provider.key==providerId}">selected='selected'</c:if>>${provider.value}</option>
		       			</c:forEach>
		       		</select></td>
				<td><span id="providerError"></span></td>
		    </tr>
		    <tr>
		   		<td><spring:message code="Encounter.location" /></td>
				<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.location"/>"/></td>
		      	<td><openmrs_tag:locationField formFieldName="location" initialValue="${locationId}" /></td>
				<td><span id="locationError"></span></td>
		    </tr>
			<tr>
				<td><spring:message code="Encounter.datetime"/></td>
				<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.encounterDatetime"/>"/></td>
				<td><input id="encounterDate" name="encounterDate" value="" size="11" type="text" onclick="showCalendar(this)" onchange="CompareDates('<openmrs:datePattern />');" /><span id="encounterDateError"></td>
				<td></span></td>
			</tr>
			<tr>
		   		<td>${reasonForExitingCare}</td>
				<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.reasonPatientExitedCare"/>"/></td>
		       	<td><select name="reasonExitCare" id="reasonPatientExitedCareId">
		       			<option value="0">--</option>
		       			<c:forEach items="${exitFromCareReasons}" var="reason">
		       				<option value="${reason.key}">${reason.value}</option>
		       			</c:forEach>
		       		</select>
		       	</td>
				<td><span id="reasonPatientExitedCareError"></span></td>
		  	</tr>
		  	<tr>
		  		<td colspan="4">
		  			<div id="patientTransferedOutDiv" style="display: none;">
		  				<table>
							<tr>
						   		<td width="250px">${reasonForTransferOut}</td>
								<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.reasonForTransferOut"/>"/></td>
						       	<td><textarea name="reasonTransferOut" id="reasonTransferOut" rows="3" cols="40"></textarea></td>
								<td><span id="reasonTransferOutError"></span></td>
						  	</tr>
							<tr>
						   		<td>${transferOutDate}</td>
								<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.transferOutDate"/>"/></td>
						       	<td><input name="transferOutDate" id="transferOutDate" value="" size="11" type="text" onclick="showCalendar(this)" /></td>
								<td><span id="transferOutDateError"></span></td>
						  	</tr>
							<tr>
						   		<td>${transferOutToLocation}</td>
								<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.transferOutToLocation"/>"/></td>
						       	<td><span id="locationDropDownSpan"><openmrs_tag:locationField formFieldName="locationTo" initialValue="" /></span></td>
								<td><span id="transferOutToLocationError"></span></td>
						  	</tr>
							<tr>
						   		<td><spring:message code="tracpatienttransfer.locationNotFound"/></td>
								<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.transferOutToLocationFreeText"/>"/></td>
						       	<td><input type="checkbox" onclick="showHideLocationFreeText();" name="chkbx_locationNotFound" id="chkbx_locationNotFoundId"/><span id="locationNotFoundSpan" style="display: none;"><input size="39" type="text" name="transferToLocationText" id="transferToLocationTextId"/></span></td>
								<td><span id="transferOutToLocationTextError"></span></td>
						  	</tr>  					
		  				</table>
		  			</div>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td colspan="4">
		  			<div id="patientDeadDiv" style="display: none;">
		  				<table>
							<tr>
						   		<td width="250px">Date of Death</td>
								<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.dateOfDeath"/>"/></td>
						       	<td><input name="dateOfDeath" id="dateOfDeath" value="" size="11" type="text" onclick="showCalendar(this)" /></td>
								<td><span id="dateOfDeathError"></span></td>
						  	</tr>
							<tr>
						   		<td>${causeOfDeath_title}</td>
								<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.causeOfDeath"/>"/></td>
						       	<td><select name="causeOfDeath" id="causeOfDeathId">
						       			<option value="0">--</option>
						       			<c:forEach items="${causeOfDeathOptions}" var="cause_death">
						       				<option value="${cause_death.key}">${cause_death.value}</option>
						       			</c:forEach>
						       		</select>
						       	</td>
								<td><span id="causeOfDeathError"></span></td>
						  	</tr>	  					
		  				</table>
		  			</div>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td></td>
		  		<td></td>
		  		<td>
		  			<input id="btSave" type="button" onclick="fxSave();" value='<spring:message code="general.save"/>'/>
		  			<input id="btCancel" type="button" onclick="fxCancel();" value='<spring:message code="general.cancel"/>'/>
		  		</td>
				<td></td>
		  	</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	$toip(document).ready(function(){
		
		$toip("#reasonPatientExitedCareId").change( function() {
			if ($toip("#reasonPatientExitedCareId").val()==$toip("#patientTransferedOutConceptId").val()) {
				$toip("#patientTransferedOutDiv").show(500);
				$toip("#patientDeadDiv").hide();
	        }else if ($toip("#reasonPatientExitedCareId").val()==$toip("#patientDeadConceptId").val()) {
				$toip("#patientDeadDiv").show(500);
				$toip("#patientTransferedOutDiv").hide();
	        }else {
				$toip("#patientTransferedOutDiv").hide();
				$toip("#patientDeadDiv").hide();		        
		    }
		});		
		
	});
</script>

<script type="text/javascript">

	function showHideLocationFreeText(){
		if(document.getElementById("chkbx_locationNotFoundId").checked==true){
			$toip("#locationNotFoundSpan").show();
			$toip("#locationDropDownSpan").hide();
		} else {
			$toip("#locationNotFoundSpan").hide();
			$toip("#locationDropDownSpan").show();
		}
	}

	function backToParent(){
		if ($toip("#prtSave").val()=="true"){
			$toip("#formTransfer").html("<div onclick='fxCancel()' id='savedDiv'> Patient Exited From Care </div>");
			setTimeout(fxCancel,2000);
		}
	}
	backToParent();

	function fxCancel(){
		self.close();
		window.opener.location.reload();
	}

	function fxSave(){
		if (validateFields()){

			var msg="You have chosen to end patient care for this patient for the following reason and on the following date, "
				+"it means also that Drug orders will be stopped and he/she will be taken out of the program"
				+"\nType of exit: "
				+$toip("#reasonPatientExitedCareId :selected").text()
				+"\nDate of exit: "
				+$toip("#encounterDate").val()
				+"\n\nAre you sure you want to proceed?";
			
			if (confirm(msg)) {
				document.exitPatientFromCareForm.submit();				
				//fxCancel();
		    }
		}
	}
	
	function validateFields(){
		var valid=true;
		if($toip("#encounterDate").val()==''){
			$toip("#encounterDateError").html("*");
			$toip("#encounterDateError").addClass("error");
			valid=false;
		} else {
			$toip("#encounterDateError").html("");
			$toip("#encounterDateError").removeClass("error");
		}

		if(document.getElementById("provider").value=='0'){
			$toip("#providerError").html("*");
			$toip("#providerError").addClass("error");
			valid=false;
		} else {
			$toip("#providerError").html("");
			$toip("#providerError").removeClass("error");
		}

		if(document.getElementById("location").value==''){
			$toip("#locationError").html("*");
			$toip("#locationError").addClass("error");
			valid=false;
		} else {
			$toip("#locationError").html("");
			$toip("#locationError").removeClass("error");
		}

		if($toip("#reasonPatientExitedCareId").val()=='0'){
			$toip("#reasonPatientExitedCareError").html("*");
			$toip("#reasonPatientExitedCareError").addClass("error");
			valid=false;
		} else {
			$toip("#reasonPatientExitedCareError").html("");
			$toip("#reasonPatientExitedCareError").removeClass("error");
		}

		if($toip("#reasonPatientExitedCareId").val()==$toip("#patientTransferedOutConceptId").val()){
			if($toip("#transferOutDate").val()==''){
				$toip("#transferOutDateError").html("*");
				$toip("#transferOutDateError").addClass("error");
				valid=false;
			} else {
				$toip("#transferOutDateError").html("");
				$toip("#transferOutDateError").removeClass("error");
			}

			if(document.getElementById("chkbx_locationNotFoundId")!=null){
				if(document.getElementById("chkbx_locationNotFoundId").checked==true){
					if($toip("#transferToLocationTextId").val()==''){
						$toip("#transferOutToLocationTextError").html("*");
						$toip("#transferOutToLocationTextError").addClass("error");
						valid=false;
					} else {
						$toip("#transferOutToLocationTextError").html("");
						$toip("#transferOutToLocationTextError").removeClass("error");
					}
				}
			}

			if($toip("#locationTo").val()==''){
				if(document.getElementById("chkbx_locationNotFoundId").checked==false){
					$toip("#transferOutToLocationError").html("*");
					$toip("#transferOutToLocationError").addClass("error");
					valid=false;
				} else {
					$toip("#transferOutToLocationError").html("");
					$toip("#transferOutToLocationError").removeClass("error");
				}
			}

			var sameLoc=false;
			
			if(document.getElementById("location").value!='' && document.getElementById("locationTo").value!='' && document.getElementById("location").value==document.getElementById("locationTo").value){
				$toip("#locationError").html("**");
				$toip("#locationError").addClass("error");

				$toip("#transferOutToLocationError").html("**");
				$toip("#transferOutToLocationError").addClass("error");
				valid=false;
				sameLoc=true;
			}
		}

		if($toip("#reasonPatientExitedCareId").val()==$toip("#patientDeadConceptId").val()){
			if($toip("#dateOfDeath").val()==''){
				$toip("#dateOfDeathError").html("*");
				$toip("#dateOfDeathError").addClass("error");
				valid=false;
			} else {
				$toip("#dateOfDeathError").html("");
				$toip("#dateOfDeathError").removeClass("error");
			}

			if($toip("#causeOfDeathId").val()=='0'){
				$toip("#causeOfDeathError").html("*");
				$toip("#causeOfDeathError").addClass("error");
				valid=false;
			} else {
				$toip("#causeOfDeathError").html("");
				$toip("#causeOfDeathError").removeClass("error");
			}
		}

		if(!valid){
			$toip("#errorDivNewId").addClass("error");
			if(sameLoc){
				$toip("#errorDivNewId").html("[ * ]  These fields are required, fill all of them before submitting."
						+"<br/>[ ** ]  Location_from and Location_to cannot be the same.");
			}else 
				$toip("#errorDivNewId").html("[ * ]  These fields are required, fill all of them before submitting.");
		} else {
			$toip("#errorDivNewId").html("");
			$toip("#errorDivNewId").removeClass("error");
		}
		
		return valid;
	}

	function CompareDates(dateFormat)
	{
	    var str1 = document.getElementById("encounterDate").value;
	    //var str2 = document.getElementById("nowId").value;
	    var dt1 = null;
	    var mon1 = null;
	    var yr1 = null;
	    var dt2 = null;
	    var mon2 = null;
	    var yr2 = null;
		if(dateFormat=='dd/mm/yyyy' || dateFormat=='jj/mm/aaaa') {
		    dt1  = parseInt(str1.substring(0,2),10);
		    mon1 = parseInt(str1.substring(3,5),10);
		    yr1  = parseInt(str1.substring(6,10),10);
		    //dt2  = parseInt(str2.substring(0,2),10);
		    //mon2 = parseInt(str2.substring(3,5),10);
		    //yr2  = parseInt(str2.substring(6,10),10);
		} else if(dateFormat=='mm/dd/yyyy' || dateFormat=='mm/jj/aaaa') {
		    mon1  = parseInt(str1.substring(0,2),10);
		    dt1 = parseInt(str1.substring(3,5),10);
		    yr1  = parseInt(str1.substring(6,10),10);
		    //mon2  = parseInt(str2.substring(0,2),10);
		    //dt2 = parseInt(str2.substring(3,5),10);
		    //yr2  = parseInt(str2.substring(6,10),10);
		} else{
			alert("Invalid date : "+dateFormat+": not supported !");
			$toip("#encounterDate").val("");
			return;
		}
		var month1 = mon1 - 1;
	    var date1 = new Date(yr1, month1, dt1);
	    var date2 = new Date();//new Date(yr2, mon2, dt2);
	    
	    if(date2 < date1)
	    {
	    	$toip("#encounterDateError").html("The date can't be in future");
	    	$toip("#encounterDateError").addClass("error");
	    	$toip("#encounterDate").val("");    	 
	    }
	    else
	    {
	    	$toip("#encounterDateError").html("");
	    	$toip("#encounterDateError").removeClass("error");
	    }
	} 

</script>

<%@ include file="/WEB-INF/template/footer.jsp"%>
