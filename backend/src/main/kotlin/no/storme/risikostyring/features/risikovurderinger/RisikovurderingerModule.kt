package no.storme.risikostyring.features.risikovurderinger

import io.ktor.server.routing.Route
import no.storme.risikostyring.features.risikovurderinger.persistence.PostgresRiskAssessmentRepository
import no.storme.risikostyring.features.risikovurderinger.domain.RiskAssessmentRepository

fun Route.risikovurderingerModule(
    repository: RiskAssessmentRepository = PostgresRiskAssessmentRepository()
) {
    risikovurderingerRoutes(repository)
}
