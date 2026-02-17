package no.storme.risikostyring.features.risikovurderinger.domain

import kotlinx.serialization.Serializable
import kotlinx.datetime.Instant

@Serializable
data class Risiko(
    val id: Int,
    val vurderingId: Int,
    val navn: String,
    val tema: String?,
    val beskrivelse: String?,
    val begrunnelse: String?,
    val sannsynlighet: Int,       // 1–5
    val konsekvens: Int,          // 1–5
    val createdAt: Instant,
    val updatedAt: Instant
) {
    init {
        require(sannsynlighet in 1..5) { "sannsynlighet må være 1..5, var $sannsynlighet" }
        require(konsekvens in 1..5) { "konsekvens må være 1..5, var $konsekvens" }
    }
}
