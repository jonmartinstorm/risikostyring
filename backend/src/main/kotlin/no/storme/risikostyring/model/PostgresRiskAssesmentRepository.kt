package no.storme.risikostyring.model

import no.storme.risikostyring.db.RiskAssessmentDAO
import no.storme.risikostyring.db.RiskAssessmentTable
import no.storme.risikostyring.db.daoToModel
import no.storme.risikostyring.db.suspendTransaction
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.deleteWhere

class PostgresRiskAssessmentRepository : RiskAssessmentRepository {

    override suspend fun all(): List<RiskAssessment> = suspendTransaction {
        RiskAssessmentDAO.all().map(::daoToModel)
    }

    override suspend fun byId(id: Int): RiskAssessment? = suspendTransaction {
        RiskAssessmentDAO.findById(id)?.let(::daoToModel)
    }

    override suspend fun add(name: String, description: String?): RiskAssessment = suspendTransaction {
        val dao = RiskAssessmentDAO.new {
            navn = name
            beskrivelse = description
        }
        daoToModel(dao)
    }

    override suspend fun delete(id: Int): Boolean = suspendTransaction {
        val rows = RiskAssessmentTable.deleteWhere { RiskAssessmentTable.id eq id }
        rows == 1
    }
}
