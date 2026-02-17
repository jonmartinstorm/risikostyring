package no.storme.risikostyring.features.risikovurderinger.domain

import kotlinx.serialization.Serializable

@Serializable
data class Deltaker(
    val id: Int,
    val personId: Int,
    val vurderingId: Int,
    val rolle: String             // fasilitator, deltaker, risikoeier, kontaktperson
)
