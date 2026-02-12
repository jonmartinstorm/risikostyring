package no.storme.risikostyring.model

interface RiskAssessmentRepository {
    suspend fun all(): List<RiskAssessment>
    suspend fun byId(id: Int): RiskAssessment?
    suspend fun add(name: String, description: String? = null): RiskAssessment
    suspend fun delete(id: Int): Boolean
}
