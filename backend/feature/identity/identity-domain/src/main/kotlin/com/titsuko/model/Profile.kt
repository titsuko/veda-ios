package com.titsuko.model

import jakarta.persistence.*

@Entity
@Table(name = "profile")
open class Profile(
    @Id
    @Column(name = "profile_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long = 0,

    @Column(name = "first_name", nullable = false)
    var firstName: String = "",

    @Column(name = "last_name", nullable = false)
    var lastName: String = "",

    @OneToOne(mappedBy = "profile")
    var user: User? = null
) {
    protected constructor(): this(0)
}