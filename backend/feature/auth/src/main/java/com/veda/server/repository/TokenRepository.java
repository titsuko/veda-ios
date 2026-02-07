package com.veda.server.repository;

import com.veda.server.model.Token;
import com.veda.server.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface TokenRepository extends JpaRepository<Token, Integer> {
    @Query("""
      select t from Token t 
      where t.user = :user and t.isRevoked = 0
      """)
    List<Token> findAllValidTokenByUser(@Param("user") User user);
    Optional<Token> findByToken(String token);
}
