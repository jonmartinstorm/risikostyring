package no.storme.risikostyring

import io.ktor.http.HttpStatusCode
import io.ktor.serialization.JsonConvertException
import io.ktor.serialization.kotlinx.json.json
import io.ktor.server.application.Application
import io.ktor.server.application.call
import io.ktor.server.application.install
import io.ktor.server.plugins.contentnegotiation.ContentNegotiation
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.delete
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.route
import io.ktor.server.routing.routing
import kotlinx.serialization.Serializable
import no.storme.risikostyring.model.RiskAssessmentRepository

@Serializable
data class CreateRiskAssessmentRequest(
    val name: String,
    val description: String? = null
)

fun Application.configureSerialization(repository: RiskAssessmentRepository) {
    install(ContentNegotiation) {
        json()
    }

    routing {
        route("/risk-assessments") {
            get { call.respond(repository.all()) }

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
                    if (req.name.isBlank()) {
                        call.respond(HttpStatusCode.BadRequest)
                        return@post
                    }
                    val created = repository.add(
                        name = req.name.trim(),
                        description = req.description?.trim()?.ifBlank { null }
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
}
