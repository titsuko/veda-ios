package com.veda.server.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.time.Instant;

@Data
@Entity
@Table(name = "tokens")
public class Token {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "token_id", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @NotNull
    @Size(max = 255)
    @Column(name = "token", nullable = false)
    private String token;

    @NotNull
    @Column(name = "expires_in", nullable = false)
    private Instant expiresIn;

    @NotNull
    @Column(name = "is_revoked", nullable = false)
    private Byte isRevoked;
}