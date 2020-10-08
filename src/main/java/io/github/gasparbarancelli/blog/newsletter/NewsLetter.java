package io.github.gasparbarancelli.blog.newsletter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Objects;

import static io.github.gasparbarancelli.blog.utils.Validators.isEmailValid;

@Entity
@Table(name = "NEWSLETTER")
public class NewsLetter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "EMAIL", length = 320, nullable = false, updatable = false)
    private String email;

    @Deprecated
    public NewsLetter() {
    }

    private NewsLetter(@NotNull String email) {
        this.email = Objects.requireNonNull(email, "email must not be null");
        if (email.isBlank() || !isEmailValid(email)) {
            throw new IllegalArgumentException("email is not valid");
        }
        this.email = email;
    }

    public static NewsLetter of(@NotNull String email) {
        return new NewsLetter(email);
    }

    public Long getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        NewsLetter that = (NewsLetter) o;
        return Objects.equals(email, that.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(email);
    }

}
