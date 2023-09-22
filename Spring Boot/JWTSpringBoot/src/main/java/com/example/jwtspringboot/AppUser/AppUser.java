package com.example.jwtspringboot.AppUser;

import com.example.jwtspringboot.Role.Role;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@AllArgsConstructor
public class AppUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;

    private String username;
    private String password;
    private String email;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="user_role", joinColumns = @JoinColumn(name ="userid"),
    inverseJoinColumns = @JoinColumn(name="roleid"))
    private List<Role> roles = new ArrayList<>();

    public AppUser() {
    }
}
