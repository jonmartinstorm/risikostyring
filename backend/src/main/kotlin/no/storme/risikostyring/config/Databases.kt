package no.storme.risikostyring.config

import io.ktor.server.application.*
import org.jetbrains.exposed.sql.*

data class DbConfig(
    val url: String,
    val username: String,
    val password: String,
)

fun Application.configureDatabases() {
    val cfg = loadDbConfig()
    log.info("Connecting to postgres: url=${cfg.url}, username=${cfg.username}")
    Database.connect(
        url = cfg.url,
        driver = "org.postgresql.Driver",
        user = cfg.username,
        password = cfg.password
    )
}

private fun Application.loadDbConfig(): DbConfig {
    val envUrl = System.getenv("DB_JDBC_URL")
    val envUsername = System.getenv("DB_USER")
    val envPassword = System.getenv("DB_PASSWORD")
    if (!envUrl.isNullOrBlank() && !envUsername.isNullOrBlank() && !envPassword.isNullOrBlank()) {
        return DbConfig(envUrl, envUsername, envPassword)
    }

    // fallback to application.yaml
    val hasConfig = environment.config.propertyOrNull("postgres.url")?.getString() != null
    if (hasConfig) {
        val url = environment.config.property("postgres.url").getString()
        val username = environment.config.property("postgres.user").getString()
        val password = environment.config.property("postgres.password").getString()
        return DbConfig(url, username, password)
    }


    return DbConfig(
        url = "jdbc:postgresql://localhost:5432/risikovurdering",
        username = "app_user",
        password = "demo-passord"
    )
}
