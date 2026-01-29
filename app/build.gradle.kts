plugins {
    id("org.springframework.boot")
    id("io.spring.dependency-management")
    kotlin("jvm")
    kotlin("plugin.spring")
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-starter-actuator")
    // include database driver
    runtimeOnly("com.mysql:mysql-connector-j")

    // include modules:
    implementation(project(":common"))
    implementation(project(":feature:admin"))
    implementation(project(":feature:health"))
    implementation(project(":feature:cards:cards-api"))
    implementation(project(":feature:identity:identity-api"))
}
