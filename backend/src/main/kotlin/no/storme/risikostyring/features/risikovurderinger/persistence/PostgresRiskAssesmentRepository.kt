package no.storme.risikostyring.features.risikovurderinger.persistence

import no.storme.risikostyring.features.risikovurderinger.domain.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.deleteWhere
import java.time.Instant

class PostgresRiskAssessmentRepository : RiskAssessmentRepository {

    // ---------------------------
    // Risikovurderinger
    // ---------------------------
    override suspend fun allAssessments(): List<RiskAssessment> = suspendTransaction {
        RiskAssessmentDAO.all().map(::daoToModel)
    }

    override suspend fun assessmentById(id: Int): RiskAssessment? = suspendTransaction {
        RiskAssessmentDAO.findById(id)?.let(::daoToModel)
    }

    override suspend fun createAssessment(input: CreateRiskAssessment): RiskAssessment = suspendTransaction {
        val now = Instant.now()
        val dao = RiskAssessmentDAO.new {
            navn = input.navn
            teamOmrade = input.teamOmrade
            status = input.status
            beskrivelse = input.beskrivelse
            oppsummering = input.oppsummering
            createdAt = now
            updatedAt = now
        }
        daoToModel(dao)
    }

    override suspend fun updateAssessment(id: Int, input: UpdateRiskAssessment): RiskAssessment? = suspendTransaction {
        val dao = RiskAssessmentDAO.findById(id) ?: return@suspendTransaction null
        val now = Instant.now()

        input.navn?.let { dao.navn = it }
        input.teamOmrade?.let { dao.teamOmrade = it }
        input.status?.let { dao.status = it }
        input.beskrivelse?.let { dao.beskrivelse = it }
        input.oppsummering?.let { dao.oppsummering = it }

        dao.updatedAt = now
        daoToModel(dao)
    }

    override suspend fun deleteAssessment(id: Int): Boolean = suspendTransaction {
        val rows = RiskAssessmentTable.deleteWhere { RiskAssessmentTable.id eq id }
        rows == 1
    }


    // ---------------------------
    // Risikoer
    // ---------------------------
    override suspend fun risksForAssessment(vurderingId: Int): List<Risiko> = suspendTransaction {
        RisikoDAO.find { RisikoTable.vurderingId eq vurderingId }
            .map(::daoToModel)
    }

    override suspend fun riskById(id: Int): Risiko? = suspendTransaction {
        RisikoDAO.findById(id)?.let(::daoToModel)
    }

    override suspend fun createRisk(vurderingId: Int, input: CreateRisiko): Risiko = suspendTransaction {
        // fail fast hvis vurdering ikke finnes (valgfritt men nyttig)
        RiskAssessmentDAO.findById(vurderingId)
            ?: error("Risikovurdering $vurderingId finnes ikke")

        val now = Instant.now()
        val dao = RisikoDAO.new {
            this.vurderingId = vurderingId
            navn = input.navn
            tema = input.tema
            beskrivelse = input.beskrivelse
            begrunnelse = input.begrunnelse
            sannsynlighet = input.sannsynlighet
            konsekvens = input.konsekvens
            createdAt = now
            updatedAt = now
        }
        daoToModel(dao)
    }

    override suspend fun updateRisk(id: Int, input: UpdateRisiko): Risiko? = suspendTransaction {
        val dao = RisikoDAO.findById(id) ?: return@suspendTransaction null
        val now = Instant.now()

        input.navn?.let { dao.navn = it }
        input.tema?.let { dao.tema = it }
        input.beskrivelse?.let { dao.beskrivelse = it }
        input.begrunnelse?.let { dao.begrunnelse = it }
        input.sannsynlighet?.let { dao.sannsynlighet = it }
        input.konsekvens?.let { dao.konsekvens = it }

        dao.updatedAt = now
        daoToModel(dao)
    }

    override suspend fun deleteRisk(id: Int): Boolean = suspendTransaction {
        val rows = RisikoTable.deleteWhere { RisikoTable.id eq id }
        rows == 1
    }


    // ---------------------------
    // Tiltak
    // ---------------------------
    override suspend fun measuresForRisk(risikoId: Int): List<Tiltak> = suspendTransaction {
        TiltakDAO.find { TiltakTable.risikoId eq risikoId }
            .map(::daoToModel)
    }

    override suspend fun measureById(id: Int): Tiltak? = suspendTransaction {
        TiltakDAO.findById(id)?.let(::daoToModel)
    }

    override suspend fun createMeasure(risikoId: Int, input: CreateTiltak): Tiltak = suspendTransaction {
        RisikoDAO.findById(risikoId)
            ?: error("Risiko $risikoId finnes ikke")

        val now = Instant.now()
        val dao = TiltakDAO.new {
            this.risikoId = risikoId
            navn = input.navn
            beskrivelse = input.beskrivelse
            status = input.status
            createdAt = now
            updatedAt = now
        }
        daoToModel(dao)
    }

    override suspend fun updateMeasure(id: Int, input: UpdateTiltak): Tiltak? = suspendTransaction {
        val dao = TiltakDAO.findById(id) ?: return@suspendTransaction null
        val now = Instant.now()

        input.navn?.let { dao.navn = it }
        input.beskrivelse?.let { dao.beskrivelse = it }
        input.status?.let { dao.status = it }

        dao.updatedAt = now
        daoToModel(dao)
    }

    override suspend fun deleteMeasure(id: Int): Boolean = suspendTransaction {
        val rows = TiltakTable.deleteWhere { TiltakTable.id eq id }
        rows == 1
    }


    // ---------------------------
    // Deltakere
    // ---------------------------
    override suspend fun participantsForAssessment(vurderingId: Int): List<Deltaker> = suspendTransaction {
        DeltakerDAO.find { DeltakerTable.vurderingId eq vurderingId }
            .map(::daoToModel)
    }

    override suspend fun participantById(id: Int): Deltaker? = suspendTransaction {
        DeltakerDAO.findById(id)?.let(::daoToModel)
    }

    override suspend fun addParticipant(vurderingId: Int, input: AddDeltaker): Deltaker = suspendTransaction {
        RiskAssessmentDAO.findById(vurderingId)
            ?: error("Risikovurdering $vurderingId finnes ikke")
        PersonDAO.findById(input.personId)
            ?: error("Person ${input.personId} finnes ikke")

        val dao = DeltakerDAO.new {
            this.vurderingId = vurderingId
            this.personId = input.personId
            rolle = input.rolle
        }
        daoToModel(dao)
    }

    override suspend fun updateParticipant(id: Int, input: UpdateDeltaker): Deltaker? = suspendTransaction {
        val dao = DeltakerDAO.findById(id) ?: return@suspendTransaction null
        dao.rolle = input.rolle
        daoToModel(dao)
    }

    override suspend fun removeParticipant(id: Int): Boolean = suspendTransaction {
        val rows = DeltakerTable.deleteWhere { DeltakerTable.id eq id }
        rows == 1
    }


    // ---------------------------
    // Loggpunkter
    // ---------------------------
    override suspend fun logForAssessment(vurderingId: Int): List<Loggpunkt> = suspendTransaction {
        LoggpunktDAO.find { LoggpunktTable.vurderingId eq vurderingId }
            .map(::daoToModel)
    }

    override suspend fun logEntryById(id: Int): Loggpunkt? = suspendTransaction {
        LoggpunktDAO.findById(id)?.let(::daoToModel)
    }

    override suspend fun addLogEntry(vurderingId: Int, input: CreateLoggpunkt): Loggpunkt = suspendTransaction {
        RiskAssessmentDAO.findById(vurderingId)
            ?: error("Risikovurdering $vurderingId finnes ikke")

        val now = Instant.now()
        val dao = LoggpunktDAO.new {
            this.vurderingId = vurderingId
            tittel = input.tittel
            innhold = input.innhold
            createdAt = now
        }
        daoToModel(dao)
    }

    override suspend fun deleteLogEntry(id: Int): Boolean = suspendTransaction {
        val rows = LoggpunktTable.deleteWhere { LoggpunktTable.id eq id }
        rows == 1
    }


    // ---------------------------
    // Personer
    // ---------------------------
    override suspend fun allPeople(): List<Person> = suspendTransaction {
        PersonDAO.all().map(::daoToModel)
    }

    override suspend fun personById(id: Int): Person? = suspendTransaction {
        PersonDAO.findById(id)?.let(::daoToModel)
    }

    override suspend fun createPerson(input: CreatePerson): Person = suspendTransaction {
        val dao = PersonDAO.new {
            navn = input.navn
            ident = input.ident
        }
        daoToModel(dao)
    }

    override suspend fun updatePerson(id: Int, input: UpdatePerson): Person? = suspendTransaction {
        val dao = PersonDAO.findById(id) ?: return@suspendTransaction null

        input.navn?.let { dao.navn = it }
        input.ident?.let { dao.ident = it }

        daoToModel(dao)
    }

    override suspend fun deletePerson(id: Int): Boolean = suspendTransaction {
        val rows = PersonTable.deleteWhere { PersonTable.id eq id }
        rows == 1
    }
}
