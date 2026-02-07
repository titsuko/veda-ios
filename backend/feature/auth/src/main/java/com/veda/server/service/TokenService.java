package com.veda.server.service;

import com.veda.server.event.UserAuthorizedEvent;
import com.veda.server.model.Token;
import com.veda.server.model.User;
import com.veda.server.repository.TokenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TokenService {

    private final TokenRepository tokenRepository;

    public void saveRefreshToken(User user, String jwtRefreshToken, long validityMs) {
        Token token = new Token();
        token.setUser(user);
        token.setToken(jwtRefreshToken);
        token.setIsRevoked((byte) 0);
        token.setExpiresIn(Instant.now().plusMillis(validityMs));

        tokenRepository.save(token);
    }

    @EventListener
    @Transactional
    public void onUserAuthorized(UserAuthorizedEvent event) {
        List<Token> validUserTokens = tokenRepository.findAllValidTokenByUser(event.user());
        if (validUserTokens.isEmpty()) return;

        validUserTokens.forEach(token -> {
            token.setIsRevoked((byte) 1);
        });

        tokenRepository.saveAll(validUserTokens);
    }

    @Transactional
    public void revokeRefreshToken(Token token) {
        token.setIsRevoked((byte) 1);
        tokenRepository.save(token);
    }
}