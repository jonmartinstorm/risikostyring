package no.storme.risikostyring.features.risikovurderinger.persistence

import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.deleteWhere
import no.storme.risikostyring.features.risikovurderinger.domain.RiskAssessment
import no.storme.risikostyring.features.risikovurderinger.domain.RiskAssessmentRepository

class PostgresRiskAssessmentRepository : RiskAssessmentRepository {

    override suspend fun all(): List<RiskAssessment> = suspendTransaction {
        RiskAssessmentDAO.all().map(::daoToModel)
    }

    override suspend fun byId(id: Int): RiskAssessment? = suspendTransaction {
        RiskAssessmentDAO.findById(id)?.let(::daoToModel)
    }

    override suspend fun add(
        navn: String,
        teamOmrade: String,
        beskrivelse: String?,
        oppsummering: String?,
        status: String?,
    ): RiskAssessment = suspendTransaction {
        val dao = RiskAssessmentDAO.new {
            this.navn = navn
            this.teamOmrade = teamOmrade
            this.status = status
            this.beskrivelse = beskrivelse
            this.oppsummering = oppsummering
            // createdAt/updatedAt settes av DB default ved insert (hvis kolonnene har default now())
        }
        daoToModel(dao)
    }

    override suspend fun delete(id: Int): Boolean = suspendTransaction {
        val rows = RiskAssessmentTable.deleteWhere { RiskAssessmentTable.id eq id }
        rows == 1
    }
}
