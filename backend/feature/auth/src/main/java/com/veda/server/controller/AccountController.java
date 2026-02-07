package com.veda.server.controller;

import com.veda.server.dto.request.CheckEmailRequest;
import com.veda.server.dto.request.RegisterRequest;
import com.veda.server.dto.response.AuthResponse;
import com.veda.server.dto.response.AvailabilityResponse;
import com.veda.server.service.AccountService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/accounts")
public class AccountController {

    private final AccountService accountService;

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public AuthResponse createAccount(@Valid @RequestBody RegisterRequest request) {
        return accountService.createAccount(request);
    }

    @PostMapping("/check-email")
    public AvailabilityResponse checkEmail(@Valid @RequestBody CheckEmailRequest request) {
        return accountService.checkEmail(request);
    }
}
