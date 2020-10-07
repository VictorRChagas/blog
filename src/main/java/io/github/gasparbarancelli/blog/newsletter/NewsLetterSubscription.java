package io.github.gasparbarancelli.blog.newsletter;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name = "NEWSLETTER_SUBSCRIPTION")
public class NewsLetterSubscription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @NotBlank
    @Column(name = "MAIL", nullable = false, updatable = false)
    private String email;

    @Deprecated
    public NewsLetterSubscription() {
    }

    public NewsLetterSubscription(String email) {
        this.email = email;
    }
}
