package no.storme.risikostyring.db

import kotlinx.coroutines.Dispatchers
import kotlinx.datetime.Instant as KxInstant
import kotlinx.datetime.toKotlinInstant
import no.storme.risikostyring.features.risikovurderinger.RiskAssessment
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.Transaction
import org.jetbrains.exposed.sql.javatime.timestamp
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction
import java.time.Instant as JInstant

object RiskAssessmentTable : IntIdTable("risikovurderinger") {
    val navn = text("navn")
    val teamOmrade = text("team_omrade")
    val status = text("status").nullable()          // pågår, godkjent, arkivert
    val beskrivelse = text("beskrivelse").nullable()
    val oppsummering = text("oppsummering").nullable()
    val createdAt = timestamp("created_at")        // default now() i DB
    val updatedAt = timestamp("updated_at")        // default now() i DB
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

suspend fun <T> suspendTransaction(block: Transaction.() -> T): T =
    newSuspendedTransaction(Dispatchers.IO, statement = block)

private fun JInstant.toKx(): KxInstant = this.toKotlinInstant()

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
