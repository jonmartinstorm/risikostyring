package no.storme.risikostyring.routing

import io.ktor.server.routing.*
import no.storme.risikostyring.features.risikovurderinger.risikovurderingerRoutes
import no.storme.risikostyring.features.risikovurderinger.RiskAssessmentRepository

fun Route.apiV1(riskAssessmentRepo: RiskAssessmentRepository) {
    route("/api/v1") {
        route("/risikovurderinger") {
            risikovurderingerRoutes(riskAssessmentRepo)
        }
    }
}
