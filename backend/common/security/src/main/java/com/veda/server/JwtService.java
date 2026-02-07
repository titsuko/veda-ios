package com.veda.server;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import javax.crypto.SecretKey;
import java.util.Base64;
import java.util.Date;

@Service
public class JwtService {

    private final SecretKey secretKey;
    private final long accessTokenValidityMs = 15L * 60L * 1000L;
    private final long refreshTokenValidityMs = 30L * 24L * 60L * 60L * 1000L;

    public JwtService(@Value("${jwt.secret}") String jwtSecret) {
        byte[] decodedKey = Base64.getDecoder().decode(jwtSecret);
        this.secretKey = Keys.hmacShaKeyFor(decodedKey);
    }

    public String generateAccessToken(String userId) {
        return generateToken(userId, "access", accessTokenValidityMs);
    }

    public String generateRefreshToken(String userId) {
        return generateToken(userId, "refresh", refreshTokenValidityMs);
    }

    public boolean validateAccessToken(String token) {
        Claims claims = parseAllClaims(token);
        if (claims == null) return false;

        String tokenType = claims.get("type", String.class);
        return "access".equals(tokenType);
    }

    public boolean validateRefreshToken(String token) {
        Claims claims = parseAllClaims(token);
        if (claims == null) return false;

        String tokenType = claims.get("type", String.class);
        return "refresh".equals(tokenType);
    }

    public String getUserIdFromToken(String token) {
        Claims claims = parseAllClaims(token);
        if (claims == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid token");
        }
        return claims.getSubject();
    }

    public long getAccessTokenValidityMs() {
        return accessTokenValidityMs;
    }

    public long getRefreshTokenValidityMs() {
        return refreshTokenValidityMs;
    }

    private String generateToken(String userId, String type, long expiry) {
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + expiry);

        return Jwts.builder()
                .subject(userId)
                .claim("type", type)
                .issuedAt(now)
                .expiration(expiryDate)
                .signWith(secretKey, Jwts.SIG.HS256)
                .compact();
    }

    private Claims parseAllClaims(String token) {
        String rawToken = token;
        if (token != null && token.startsWith("Bearer ")) {
            rawToken = token.substring(7);
        }

        try {
            return Jwts.parser()
                    .verifyWith(secretKey)
                    .build()
                    .parseSignedClaims(rawToken)
                    .getPayload();
        } catch (Exception e) {
            return null;
        }
    }
}