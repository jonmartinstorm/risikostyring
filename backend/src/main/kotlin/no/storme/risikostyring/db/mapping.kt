package no.storme.risikostyring.db

import kotlinx.coroutines.Dispatchers
import no.storme.risikostyring.model.RiskAssessment
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.Transaction
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction

// Matcher tabellen din i SQL: risikovurderinger
object RiskAssessmentTable : IntIdTable("risikovurderinger") {
    val navn = varchar("navn", 200)
    val beskrivelse = text("beskrivelse").nullable()
}

class RiskAssessmentDAO(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<RiskAssessmentDAO>(RiskAssessmentTable)

    var navn by RiskAssessmentTable.navn
    var beskrivelse by RiskAssessmentTable.beskrivelse
}

suspend fun <T> suspendTransaction(block: Transaction.() -> T): T =
    newSuspendedTransaction(Dispatchers.IO, statement = block)

fun daoToModel(dao: RiskAssessmentDAO): RiskAssessment =
    RiskAssessment(
        id = dao.id.value,
        name = dao.navn,
        description = dao.beskrivelse
    )
