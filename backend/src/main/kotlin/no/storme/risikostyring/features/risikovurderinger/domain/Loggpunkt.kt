package no.storme.risikostyring.features.risikovurderinger.domain

import kotlinx.datetime.Instant
import kotlinx.serialization.Serializable

@Serializable
data class Loggpunkt(
    val id: Int,
    val vurderingId: Int,
    val tittel: String,
    val innhold: String?,
    val createdAt: Instant
)
