package no.storme.risikostyring.routing

import io.ktor.server.routing.*
import no.storme.risikostyring.features.risikovurderinger.risikovurderingerModule

fun Route.apiV1() {
    route("/api/v1") {
        risikovurderingerModule()
        // risikoregisterRoutes()

    }
}
