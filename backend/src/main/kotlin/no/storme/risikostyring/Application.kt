package no.storme.risikostyring

import io.ktor.server.application.*
import no.storme.risikostyring.model.PostgresRiskAssessmentRepository

fun main(args: Array<String>) {
    io.ktor.server.netty.EngineMain.main(args)
}

fun Application.module() {
    val repository = PostgresRiskAssessmentRepository()
    configureDatabases()
    configureSerialization()
    configureErrors()
    configureRouting()
    configureApiV1Routes(repository)
}
