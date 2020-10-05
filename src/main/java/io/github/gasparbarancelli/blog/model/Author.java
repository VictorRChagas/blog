package io.github.gasparbarancelli.blog.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Objects;

@Entity
@Table(name = "AUTHOR")
public class Author {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "NAME", nullable = false, length = 50)
    private String name;

    @Column(name = "MAIL", nullable = false, length = 50)
    private String mail;

    @Column(name = "LINKEDIN", length = 100)
    private String linkedIn;

    @Column(name = "FACEBOOK", length = 100)
    private String faceBook;

    @Column(name = "TWITTER", length = 100)
    private String twitter;

    @Deprecated
    public Author() {
    }

    private Author(@NotNull String name, @NotNull String mail) {
        this.name = Objects.requireNonNull(name, "name must not be null");
        this.mail = Objects.requireNonNull(mail, "mail must not be null");
    }

    public static class AuthorBuilder {

        private final Author author;

        public AuthorBuilder(@NotNull String name, @NotNull String mail) {
            this.author = new Author(name, mail);
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

    public String getMail() {
        return mail;
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
        return Objects.equals(id, author.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

}
