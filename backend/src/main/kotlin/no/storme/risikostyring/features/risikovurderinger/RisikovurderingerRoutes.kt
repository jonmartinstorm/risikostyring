package no.storme.risikostyring.features.risikovurderinger

import io.ktor.http.HttpStatusCode
import io.ktor.serialization.JsonConvertException
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.delete
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.route
import no.storme.risikostyring.features.risikovurderinger.domain.CreateRiskAssessment
import no.storme.risikostyring.features.risikovurderinger.domain.RiskAssessmentRepository

fun Route.risikovurderingerRoutes(repository: RiskAssessmentRepository) {
    route("/risikovurderinger") {

        // GET /risikovurderinger
        get {
            call.respond(repository.allAssessments())
        }

        // GET /risikovurderinger/{id}
        get("/{id}") {
            val id = call.parameters["id"]?.toIntOrNull()
                ?: return@get call.respond(HttpStatusCode.BadRequest)

            val assessment = repository.assessmentById(id)
                ?: return@get call.respond(HttpStatusCode.NotFound)

            call.respond(assessment)
        }

        // POST /risikovurderinger
        post {
            try {
                val req = call.receive<CreateRiskAssessment>()

                if (req.navn.isBlank() || req.teamOmrade.isBlank()) {
                    return@post call.respond(HttpStatusCode.BadRequest)
                }

                val created = repository.createAssessment(
                    req.copy(
                        navn = req.navn.trim(),
                        teamOmrade = req.teamOmrade.trim(),
                        beskrivelse = req.beskrivelse?.trim()?.ifBlank { null },
                        oppsummering = req.oppsummering?.trim()?.ifBlank { null },
                        status = req.status?.trim()?.ifBlank { null }
                    )
                )

                call.respond(HttpStatusCode.Created, created)
            } catch (_: JsonConvertException) {
                call.respond(HttpStatusCode.BadRequest)
            } catch (_: IllegalStateException) {
                call.respond(HttpStatusCode.BadRequest)
            }
        }

        // DELETE /risikovurderinger/{id}
        delete("/{id}") {
            val id = call.parameters["id"]?.toIntOrNull()
                ?: return@delete call.respond(HttpStatusCode.BadRequest)

            if (repository.deleteAssessment(id)) call.respond(HttpStatusCode.NoContent)
            else call.respond(HttpStatusCode.NotFound)
        }

        // ----------
        // Risikoer
        // ----------
        get("/{id}/risikoer") {
            val id = call.parameters["id"]?.toIntOrNull()
                ?: return@get call.respond(HttpStatusCode.BadRequest)

            call.respond(repository.risksForAssessment(id))
        }

        // ----------
        // Personer
        // ----------
        get("/{id}/personer") {
            val id = call.parameters["id"]?.toIntOrNull()
                ?: return@get call.respond(HttpStatusCode.BadRequest)

            val persons = repository
                .participantsForAssessment(id)
                .mapNotNull { participant ->
                    repository.personById(participant.personId)
                }

            call.respond(persons)
        }
    }
}
