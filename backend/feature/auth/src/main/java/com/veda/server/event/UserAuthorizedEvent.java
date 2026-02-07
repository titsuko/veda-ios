package com.veda.server.event;

import com.veda.server.model.User;

public record UserAuthorizedEvent(User user) {
}
