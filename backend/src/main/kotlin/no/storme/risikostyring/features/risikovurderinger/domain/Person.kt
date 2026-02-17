package no.storme.risikostyring.features.risikovurderinger.domain

import kotlinx.serialization.Serializable

@Serializable
data class Person(
    val id: Int,
    val navn: String,
    val ident: String
)
