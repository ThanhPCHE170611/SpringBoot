package com.example.schoolmanagement.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.*;

@Table(indexes = {
        @Index(name = "idx_username", columnList = "username"),
        @Index(name = "idx_email", columnList = "email")
})
@Entity
@Getter
@Setter
public class Users implements UserDetails {
    @Id
    private String rollNumber;

    private String fullname;
    private String username;
    private String password;
    private String email;
    private String dayOfBirth;
    private String cccd;
    //Orgarnizaion
    @ManyToOne
    @JoinColumn(name = "gender")
    private Gender gender;

    @ManyToOne
    @JoinColumn(name = "ethnic")
    private Ethnic ethnic;

    @ManyToOne
    @JoinColumn(name = "religion")
    private Religion religions;

    private String picture;
    private String hobbies;
    private String address;
    private String hometown;
    private String parrentName;
    private String status;
    @ManyToOne
    @JoinColumn(name = "teacher_roll_number")
    private Users teacher;
    private double markAverage;
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="user_role", joinColumns = @JoinColumn(name ="rollnumber"),
            inverseJoinColumns = @JoinColumn(name="id"))
    private Set<Role> roles;

    @OneToOne
    @JoinColumn(name = "teacher_class")
    private Class teacherclass;

    @ManyToOne
    @JoinColumn(name = "student_class")
    private Class studentclass;

    private Date lastchangepassword;
    private Date deactivetime;

    @JsonIgnore
    @OneToMany(mappedBy = "teacher")
    private List<TeacherClassSubject> teacherClassSubjects;

    @OneToOne
    @JoinColumn(name = "organization")
    private Organization schoolOrganization;

    public Users(String rollnumber, String username, String email, String encode, Gender gender, Religion religion, Ethnic ethnic, Set<Role> roleSet, Organization schoolOrganization) {
        this.rollNumber = rollnumber;
        this.username = username;
        this.email = email;
        this.password = encode;
        this.gender = gender;
        this.religions = religion;
        this.ethnic = ethnic;
        this.roles = roleSet;
        this.schoolOrganization = schoolOrganization;
        this.status = "active";
        Date date = new Date();
        this.lastchangepassword = date;
    }

    public Users(String rollNumberStr, String emailStr, String cccdStr, String dobStr, Gender genderObj, Ethnic ethnicObj, Religion religionObj, String username, String password, Organization schoolOrganization, Role role) {
        this.rollNumber = rollNumberStr;
        this.email = emailStr;
        this.cccd = cccdStr;
        this.dayOfBirth = dobStr;
        this.gender = genderObj;
        this.ethnic = ethnicObj;
        this.religions = religionObj;
        this.schoolOrganization = schoolOrganization;
        this.status = "active";
        this.username = username;
        this.password = password;
        this.lastchangepassword = new Date();
        this.roles = new HashSet<>();
        this.roles.add(role);
    }

    public Users() {

    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Set<GrantedAuthority> authorities = new HashSet<>();

        // Iterate through user roles and add them as authorities
        for (Role role : roles) {
            authorities.add(new SimpleGrantedAuthority("ROLE_" + role.getRolename().toUpperCase()));
        }
        return authorities;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
    @PrePersist
    public void prePersist() {
        this.lastchangepassword = new Date();
    }
}
