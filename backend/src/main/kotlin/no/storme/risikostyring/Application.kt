package no.storme.risikostyring

import io.ktor.server.application.*
import no.storme.risikostyring.model.FakeTaskRepository
import no.storme.risikostyring.model.PostgresTaskRepository

fun main(args: Array<String>) {
    io.ktor.server.netty.EngineMain.main(args)
}

fun Application.module() {
    val repository = PostgresTaskRepository()
    configureSerialization(repository)
    configureDatabases()
    configureRouting()
}
