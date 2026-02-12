package no.storme.risikostyring.model

import kotlinx.serialization.Serializable

@Serializable
data class RiskAssessment(
    val id: Int,
    val name: String,
    val description: String? = null
)
