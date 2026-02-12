package no.storme.risikostyring.model

import kotlinx.serialization.Serializable
import kotlinx.datetime.Instant

@Serializable
data class RiskAssessment(
    val id: Int,
    val navn: String,
    val teamOmrade: String,
    val status: String?,          // nullable siden DB ikke har NOT NULL
    val beskrivelse: String?,     // matcher kolonnen
    val oppsummering: String?,    // manglet i modellen
    val createdAt: Instant,
    val updatedAt: Instant
)
