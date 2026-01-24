package com.titsuko.server.model

import jakarta.persistence.*
import org.hibernate.annotations.CreationTimestamp
import org.hibernate.annotations.UpdateTimestamp
import java.time.Instant

@Entity
@Table(name = "users")
data class User(
    @Id
    @Column(name = "user_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long,

    @Column(unique = true, nullable = false)
    val email: String,

    @Column(nullable = false)
    val password: String,

    @Column(name = "created_at", nullable = false)
    @CreationTimestamp
    val createdAt: Instant,

    @Column(name = "updated_at", nullable = false)
    @UpdateTimestamp
    val updatedAt: Instant,
)
