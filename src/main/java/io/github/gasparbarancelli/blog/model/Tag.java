package io.github.gasparbarancelli.blog.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Objects;

@Entity
@Table(name = "TAG")
public class Tag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "DESCRIPTION", nullable = false, length = 100)
    private String description;

    @Deprecated
    public Tag() {
    }

    private Tag(@NotNull String description) {
        this.description = Objects.requireNonNull(description, "description must not be null");
    }

    public static Tag of(@NotNull String description) {
        return new Tag(description);
    }

    public Long getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Tag tag = (Tag) o;
        return Objects.equals(id, tag.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

}
