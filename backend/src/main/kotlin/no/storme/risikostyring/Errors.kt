package no.storme.risikostyring

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.Application
import io.ktor.server.application.call
import io.ktor.server.plugins.statuspages.StatusPages
import io.ktor.server.response.respondText
import io.ktor.server.application.install

fun Application.configureErrors() {
    install(StatusPages) {
        exception<Throwable> { call, cause ->
            // Ikke leak stacktrace i prod – men ok i tidlig dev.
            call.respondText(
                text = "500: ${cause.message ?: "Internal server error"}",
                status = HttpStatusCode.InternalServerError
            )
        }
    }
}
