package no.storme.risikostyring.features.risikovurderinger.domain

interface RiskAssessmentRepository {

    // ---------------------------
    // RiskAssessments (risikovurderinger)
    // ---------------------------
    suspend fun allAssessments(): List<RiskAssessment>
    suspend fun assessmentById(id: Int): RiskAssessment?

    suspend fun createAssessment(input: CreateRiskAssessment): RiskAssessment
    suspend fun updateAssessment(id: Int, input: UpdateRiskAssessment): RiskAssessment?
    suspend fun deleteAssessment(id: Int): Boolean


    // ---------------------------
    // Risks (risikoer)
    // ---------------------------
    suspend fun risksForAssessment(vurderingId: Int): List<Risiko>
    suspend fun riskById(id: Int): Risiko?

    suspend fun createRisk(vurderingId: Int, input: CreateRisiko): Risiko
    suspend fun updateRisk(id: Int, input: UpdateRisiko): Risiko?
    suspend fun deleteRisk(id: Int): Boolean


    // ---------------------------
    // Measures (tiltak)
    // ---------------------------
    suspend fun measuresForRisk(risikoId: Int): List<Tiltak>
    suspend fun measureById(id: Int): Tiltak?

    suspend fun createMeasure(risikoId: Int, input: CreateTiltak): Tiltak
    suspend fun updateMeasure(id: Int, input: UpdateTiltak): Tiltak?
    suspend fun deleteMeasure(id: Int): Boolean


    // ---------------------------
    // Participants (deltakere)
    // ---------------------------
    suspend fun participantsForAssessment(vurderingId: Int): List<Deltaker>
    suspend fun participantById(id: Int): Deltaker?

    suspend fun addParticipant(vurderingId: Int, input: AddDeltaker): Deltaker
    suspend fun updateParticipant(id: Int, input: UpdateDeltaker): Deltaker?
    suspend fun removeParticipant(id: Int): Boolean


    // ---------------------------
    // Log entries (loggpunkter)
    // ---------------------------
    suspend fun logForAssessment(vurderingId: Int): List<Loggpunkt>
    suspend fun logEntryById(id: Int): Loggpunkt?

    suspend fun addLogEntry(vurderingId: Int, input: CreateLoggpunkt): Loggpunkt
    suspend fun deleteLogEntry(id: Int): Boolean


    // ---------------------------
    // People (personer)
    // ---------------------------
    suspend fun allPeople(): List<Person>
    suspend fun personById(id: Int): Person?
    suspend fun createPerson(input: CreatePerson): Person
    suspend fun updatePerson(id: Int, input: UpdatePerson): Person?
    suspend fun deletePerson(id: Int): Boolean
}
