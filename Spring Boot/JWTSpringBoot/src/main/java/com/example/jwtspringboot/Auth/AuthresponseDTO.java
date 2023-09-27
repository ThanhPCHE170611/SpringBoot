package com.example.jwtspringboot.Auth;

import lombok.Data;

@Data
public class AuthresponseDTO {
    private String accessToken;
    private String tokenType = "Bearer ";

    public AuthresponseDTO(String accessToken) {
        this.accessToken = accessToken;
    }
}
