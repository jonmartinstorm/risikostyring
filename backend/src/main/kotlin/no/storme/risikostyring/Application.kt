package no.storme.risikostyring

import io.ktor.server.application.*
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

}
