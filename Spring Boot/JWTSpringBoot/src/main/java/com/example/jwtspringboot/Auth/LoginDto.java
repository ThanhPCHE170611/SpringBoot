package com.example.jwtspringboot.Auth;

import lombok.Data;

@Data
public class LoginDto {
    private String username;
    private String password;
}
