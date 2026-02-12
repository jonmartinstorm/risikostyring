package no.storme.risikostyring.routing

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.Application
import io.ktor.server.response.respond
import io.ktor.server.response.respondText
import io.ktor.server.routing.get
import io.ktor.server.routing.routing

fun Application.configureRouting() {
    routing {
        get("/") {
            call.respondText("ok")
        }

        get("/health") {
            call.respond(HttpStatusCode.OK)
        }
    }
}
