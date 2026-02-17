package no.storme.risikostyring.features.risikovurderinger.persistence

import kotlinx.coroutines.Dispatchers
import kotlinx.datetime.Instant as KxInstant
import kotlinx.datetime.toKotlinInstant
import no.storme.risikostyring.features.risikovurderinger.domain.*
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.ReferenceOption
import org.jetbrains.exposed.sql.Transaction
import org.jetbrains.exposed.sql.javatime.timestamp
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction
import java.time.Instant as JInstant

// ---------------------------
// Transaction helper
// ---------------------------
suspend fun <T> suspendTransaction(block: Transaction.() -> T): T =
    newSuspendedTransaction(Dispatchers.IO, statement = block)

// ---------------------------
// Instant mapping helpers
// ---------------------------
private fun JInstant.toKx(): KxInstant = this.toKotlinInstant()

// ============================================================================
// TABLES + DAOs
// ============================================================================

// ---------------------------
// risikovurderinger
// ---------------------------
object RiskAssessmentTable : IntIdTable("risikovurderinger") {
    val navn = text("navn")
    val teamOmrade = text("team_omrade")
    val status = text("status").nullable()          // pågår, godkjent, arkivert
    val beskrivelse = text("beskrivelse").nullable()
    val oppsummering = text("oppsummering").nullable()
    val createdAt = timestamp("created_at")
    val updatedAt = timestamp("updated_at")
}

class RiskAssessmentDAO(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<RiskAssessmentDAO>(RiskAssessmentTable)

    var navn by RiskAssessmentTable.navn
    var teamOmrade by RiskAssessmentTable.teamOmrade
    var status by RiskAssessmentTable.status
    var beskrivelse by RiskAssessmentTable.beskrivelse
    var oppsummering by RiskAssessmentTable.oppsummering
    var createdAt by RiskAssessmentTable.createdAt
    var updatedAt by RiskAssessmentTable.updatedAt
}

// ---------------------------
// risikoer
// ---------------------------
object RisikoTable : IntIdTable("risikoer") {
    val vurderingId = integer("vurdering_id")
        .references(RiskAssessmentTable.id, onDelete = ReferenceOption.CASCADE)

    val navn = text("navn")
    val tema = text("tema").nullable()
    val beskrivelse = text("beskrivelse").nullable()
    val begrunnelse = text("begrunnelse").nullable()
    val sannsynlighet = integer("sannsynlighet")   // 1–5
    val konsekvens = integer("konsekvens")         // 1–5
    val createdAt = timestamp("created_at")
    val updatedAt = timestamp("updated_at")
}

class RisikoDAO(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<RisikoDAO>(RisikoTable)

    var vurderingId by RisikoTable.vurderingId
    var navn by RisikoTable.navn
    var tema by RisikoTable.tema
    var beskrivelse by RisikoTable.beskrivelse
    var begrunnelse by RisikoTable.begrunnelse
    var sannsynlighet by RisikoTable.sannsynlighet
    var konsekvens by RisikoTable.konsekvens
    var createdAt by RisikoTable.createdAt
    var updatedAt by RisikoTable.updatedAt
}

// ---------------------------
// tiltak
// ---------------------------
object TiltakTable : IntIdTable("tiltak") {
    val risikoId = integer("risiko_id")
        .references(RisikoTable.id, onDelete = ReferenceOption.CASCADE)

    val navn = text("navn")
    val beskrivelse = text("beskrivelse").nullable()
    val status = text("status")                     // mulig, planlagt, implementert, ...
    val createdAt = timestamp("created_at")
    val updatedAt = timestamp("updated_at")
}

class TiltakDAO(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<TiltakDAO>(TiltakTable)

    var risikoId by TiltakTable.risikoId
    var navn by TiltakTable.navn
    var beskrivelse by TiltakTable.beskrivelse
    var status by TiltakTable.status
    var createdAt by TiltakTable.createdAt
    var updatedAt by TiltakTable.updatedAt
}

// ---------------------------
// personer
// ---------------------------
object PersonTable : IntIdTable("personer") {
    val navn = text("navn")
    val ident = text("ident")
}

class PersonDAO(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<PersonDAO>(PersonTable)

    var navn by PersonTable.navn
    var ident by PersonTable.ident
}

// ---------------------------
// deltakere
// ---------------------------
object DeltakerTable : IntIdTable("deltakere") {
    val personId = integer("person_id")
        .references(PersonTable.id, onDelete = ReferenceOption.CASCADE)

    val vurderingId = integer("vurdering_id")
        .references(RiskAssessmentTable.id, onDelete = ReferenceOption.CASCADE)

    val rolle = text("rolle") // fasilitator, deltaker, risikoeier, kontaktperson
}

class DeltakerDAO(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<DeltakerDAO>(DeltakerTable)

    var personId by DeltakerTable.personId
    var vurderingId by DeltakerTable.vurderingId
    var rolle by DeltakerTable.rolle
}

// ---------------------------
// loggpunkter
// ---------------------------
object LoggpunktTable : IntIdTable("loggpunkter") {
    val vurderingId = integer("vurdering_id")
        .references(RiskAssessmentTable.id, onDelete = ReferenceOption.CASCADE)

    val tittel = text("tittel")
    val innhold = text("innhold").nullable()
    val createdAt = timestamp("created_at")
}

class LoggpunktDAO(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<LoggpunktDAO>(LoggpunktTable)

    var vurderingId by LoggpunktTable.vurderingId
    var tittel by LoggpunktTable.tittel
    var innhold by LoggpunktTable.innhold
    var createdAt by LoggpunktTable.createdAt
}

// ============================================================================
// DAO -> DOMAIN MAPPERS
// ============================================================================

fun daoToModel(dao: RiskAssessmentDAO): RiskAssessment =
    RiskAssessment(
        id = dao.id.value,
        navn = dao.navn,
        teamOmrade = dao.teamOmrade,
        status = dao.status,
        beskrivelse = dao.beskrivelse,
        oppsummering = dao.oppsummering,
        createdAt = dao.createdAt.toKx(),
        updatedAt = dao.updatedAt.toKx()
    )

fun daoToModel(dao: RisikoDAO): Risiko =
    Risiko(
        id = dao.id.value,
        vurderingId = dao.vurderingId,
        navn = dao.navn,
        tema = dao.tema,
        beskrivelse = dao.beskrivelse,
        begrunnelse = dao.begrunnelse,
        sannsynlighet = dao.sannsynlighet,
        konsekvens = dao.konsekvens,
        createdAt = dao.createdAt.toKx(),
        updatedAt = dao.updatedAt.toKx()
    )

fun daoToModel(dao: TiltakDAO): Tiltak =
    Tiltak(
        id = dao.id.value,
        risikoId = dao.risikoId,
        navn = dao.navn,
        beskrivelse = dao.beskrivelse,
        status = dao.status,
        createdAt = dao.createdAt.toKx(),
        updatedAt = dao.updatedAt.toKx()
    )

fun daoToModel(dao: PersonDAO): Person =
    Person(
        id = dao.id.value,
        navn = dao.navn,
        ident = dao.ident
    )

fun daoToModel(dao: DeltakerDAO): Deltaker =
    Deltaker(
        id = dao.id.value,
        personId = dao.personId,
        vurderingId = dao.vurderingId,
        rolle = dao.rolle
    )

fun daoToModel(dao: LoggpunktDAO): Loggpunkt =
    Loggpunkt(
        id = dao.id.value,
        vurderingId = dao.vurderingId,
        tittel = dao.tittel,
        innhold = dao.innhold,
        createdAt = dao.createdAt.toKx()
    )
