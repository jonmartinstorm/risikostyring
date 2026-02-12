package no.storme.risikostyring

import io.ktor.server.application.*
import io.ktor.server.routing.routing
import no.storme.risikostyring.features.risikovurderinger.PostgresRiskAssessmentRepository
import no.storme.risikostyring.routing.apiV1
import no.storme.risikostyring.routing.configureRouting
import no.storme.risikostyring.config.configureDatabases
import no.storme.risikostyring.config.configureErrors
import no.storme.risikostyring.config.configureSerialization

fun main(args: Array<String>) {
    io.ktor.server.netty.EngineMain.main(args)
}

fun Application.module() {
    configureDatabases()
    configureSerialization()
    configureErrors()
    configureRouting()

    val repo = PostgresRiskAssessmentRepository()

    routing {
        apiV1(repo)
    }
}
