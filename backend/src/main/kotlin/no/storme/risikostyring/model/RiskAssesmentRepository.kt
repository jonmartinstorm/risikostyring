package no.storme.risikostyring.model

interface RiskAssessmentRepository {
    suspend fun all(): List<RiskAssessment>
    suspend fun byId(id: Int): RiskAssessment?
    suspend fun add(
        navn: String,
        teamOmrade: String,
        beskrivelse: String? = null,
        oppsummering: String? = null,
        status: String? = "pågår",
    ): RiskAssessment
    suspend fun delete(id: Int): Boolean
}
