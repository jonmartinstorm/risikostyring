package no.storme.risikostyring.features.risikovurderinger.domain

import kotlinx.serialization.Serializable

@Serializable
data class CreateRiskAssessment(
    val navn: String,
    val teamOmrade: String,
    val beskrivelse: String? = null,
    val oppsummering: String? = null,
    val status: String? = "pågår"
)

@Serializable
data class UpdateRiskAssessment(
    val navn: String? = null,
    val teamOmrade: String? = null,
    val beskrivelse: String? = null,
    val oppsummering: String? = null,
    val status: String? = null
)

@Serializable
data class CreateRisiko(
    val navn: String,
    val tema: String? = null,
    val beskrivelse: String? = null,
    val begrunnelse: String? = null,
    val sannsynlighet: Int,
    val konsekvens: Int
)

@Serializable
data class UpdateRisiko(
    val navn: String? = null,
    val tema: String? = null,
    val beskrivelse: String? = null,
    val begrunnelse: String? = null,
    val sannsynlighet: Int? = null,
    val konsekvens: Int? = null
)

@Serializable
data class CreateTiltak(
    val navn: String,
    val beskrivelse: String? = null,
    val status: String
)

@Serializable
data class UpdateTiltak(
    val navn: String? = null,
    val beskrivelse: String? = null,
    val status: String? = null
)

@Serializable
data class AddDeltaker(
    val personId: Int,
    val rolle: String
)

@Serializable
data class UpdateDeltaker(
    val rolle: String
)

@Serializable
data class CreateLoggpunkt(
    val tittel: String,
    val innhold: String? = null
)

@Serializable
data class CreatePerson(
    val navn: String,
    val ident: String
)

@Serializable
data class UpdatePerson(
    val navn: String? = null,
    val ident: String? = null
)
