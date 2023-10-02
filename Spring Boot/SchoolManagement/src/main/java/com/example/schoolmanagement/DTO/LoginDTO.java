package com.example.schoolmanagement.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.stereotype.Component;

@Data
public class LoginDTO {
    private String username;
    private String password;
}
