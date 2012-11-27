/**
 * 
 */
package org.openmrs.module.tracpatienttransfer.service;

import java.util.Date;
import java.util.List;

/**
 * @author Yves GAKUBA
 * 
 */
public interface PatientTransferService {

	public List<Integer> getObsWithConceptReasonOfExit(Integer conceptId,
			Integer locationId);

	public List<Integer> getObsWithConceptReasonOfExitAndWithAnswer(
			Integer conceptId, String option);

	public Integer getNumberOfObsWithConceptReasonOfExitAndWithAnswer(
			Integer conceptId, Date startDate, Date endDate);

	public boolean isThePatientExitedFromCare(Integer patientId);

	public Integer getLastObsWithReasonOfExitForPatient(Integer patientId);

	public List<Integer> findObsBasedOnCreteria(boolean includeVoided,
			String gender, Integer locationId, Integer reasonExitCareId,
			Date dateFrom, Date dateTo, Integer minAge, Integer maxAge, Integer providerId);
	
	/**
	 * Gets Obs ids based on the provided parameters where <code>providerId</code> corresponds to <code>personId</code>
	 * @param includeVoided
	 * @param gender
	 * @param locationId
	 * @param reasonExitCareId
	 * @param dateFrom
	 * @param dateTo
	 * @param minAge
	 * @param maxAge
	 * @param providerId, the personId of the provider.
	 * @return
	 */
	public List<Integer> newFindObsBasedOnCriteria(boolean includeVoided,
			String gender, Integer locationId, Integer reasonExitCareId,
			Date dateFrom, Date dateTo, Integer minAge, Integer maxAge, Integer providerId);
	
	public List<Integer> getObsWithConceptReasonPatientExitedFromCareVoided(Integer conceptId,
			Integer locationId);
	
	public List<String> getReasonsOfResumingCare();
	
	public Integer getNumberOfPatientCareResumeByReason(String reason);

}
