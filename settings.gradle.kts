rootProject.name = "veda-server"

include(
    ":app",
    ":common",
    ":feature:admin",
    ":feature:health",
    ":feature:identity:identity-api",
    ":feature:identity:identity-domain",
    ":feature:cards:cards-api",
    ":feature:cards:cards-domain"
)
