package com.example.schoolmanagement.Utilities;

import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.stereotype.Component;

@Component
public class GoogleLoginHandle {
    public String getEmailFromOAuth2Authentication(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();
            if (principal instanceof OidcUser) {
                OidcUser oidcUser = (OidcUser) principal;
                return oidcUser.getAttribute("email");
            }
        }
        return null; // Return null if email not found or authentication is not valid
    }
}
