package io.github.gasparbarancelli.blog.author;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Objects;

import static io.github.gasparbarancelli.blog.utils.Validators.isEmailValid;

@Entity
@Table(name = "AUTHOR")
public class Author {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "NAME", nullable = false, length = 50)
    private String name;

    @Column(name = "EMAIL", nullable = false, length = 320)
    private String email;

    @Column(name = "LINKEDIN", length = 100)
    private String linkedIn;

    @Column(name = "FACEBOOK", length = 100)
    private String faceBook;

    @Column(name = "TWITTER", length = 100)
    private String twitter;

    @Deprecated
    public Author() {
    }

    private Author(@NotNull String name, @NotNull String email) {
        this.name = Objects.requireNonNull(name, "name must not be null");
        this.email = Objects.requireNonNull(email, "email must not be null");
        if (email.isBlank() || !isEmailValid(email)) {
            throw new IllegalArgumentException("email is not valid");
        }
    }

    public static AuthorBuilder builder(@NotNull String name, @NotNull String email) {
        return new AuthorBuilder(name, email);
    }

    public static class AuthorBuilder {

        private final Author author;

        public AuthorBuilder(@NotNull String name, @NotNull String email) {
            this.author = new Author(name, email);
        }

        public AuthorBuilder linkedIn(String linkedIn) {
            this.author.linkedIn = linkedIn;
            return this;
        }

        public AuthorBuilder faceBook(String faceBook) {
            this.author.faceBook = faceBook;
            return this;
        }

        public AuthorBuilder twitter(String twitter) {
            this.author.twitter = twitter;
            return this;
        }

        public Author build() {
            return this.author;
        }

    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getLinkedIn() {
        return linkedIn;
    }

    public String getFaceBook() {
        return faceBook;
    }

    public String getTwitter() {
        return twitter;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Author author = (Author) o;
        return Objects.equals(name, author.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

}
