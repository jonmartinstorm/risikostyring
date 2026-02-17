package no.storme.risikostyring.features.risikovurderinger.domain

import kotlinx.datetime.Instant
import kotlinx.serialization.Serializable

@Serializable
data class Tiltak(
    val id: Int,
    val risikoId: Int,
    val navn: String,
    val beskrivelse: String?,
    val status: String,
    val createdAt: Instant,
    val updatedAt: Instant
)
