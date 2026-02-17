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
import kotlinx.serialization.Serializable
import no.storme.risikostyring.features.risikovurderinger.domain.RiskAssessmentRepository

@Serializable
data class CreateRiskAssessmentRequest(
    val navn: String,
    val teamOmrade: String,
    val beskrivelse: String? = null,
    val oppsummering: String? = null
)

fun Route.risikovurderingerRoutes(repository: RiskAssessmentRepository) {
    route("/risikovurderinger") {
        get {
            call.respond(repository.all())
        }

        get("/{id}") {
            val id = call.parameters["id"]?.toIntOrNull()
            if (id == null) {
                call.respond(HttpStatusCode.BadRequest)
                return@get
            }

            val assessment = repository.byId(id)
            if (assessment == null) {
                call.respond(HttpStatusCode.NotFound)
                return@get
            }

            call.respond(assessment)
        }

        post {
            try {
                val req = call.receive<CreateRiskAssessmentRequest>()

                if (req.navn.isBlank() || req.teamOmrade.isBlank()) {
                    call.respond(HttpStatusCode.BadRequest)
                    return@post
                }

                val created = repository.add(
                    navn = req.navn.trim(),
                    teamOmrade = req.teamOmrade.trim(),
                    beskrivelse = req.beskrivelse?.trim()?.ifBlank { null },
                    oppsummering = req.oppsummering?.trim()?.ifBlank { null },
                    // status: lar repo defaulte til "pågår" hvis du har default i interfacet
                )

                call.respond(HttpStatusCode.Created, created)
            } catch (_: JsonConvertException) {
                call.respond(HttpStatusCode.BadRequest)
            } catch (_: IllegalStateException) {
                call.respond(HttpStatusCode.BadRequest)
            }
        }

        delete("/{id}") {
            val id = call.parameters["id"]?.toIntOrNull()
            if (id == null) {
                call.respond(HttpStatusCode.BadRequest)
                return@delete
            }

            if (repository.delete(id)) call.respond(HttpStatusCode.NoContent)
            else call.respond(HttpStatusCode.NotFound)
        }
    }
}
