package io.github.gasparbarancelli.blog.post;

import io.github.gasparbarancelli.blog.author.Author;
import io.github.gasparbarancelli.blog.tag.Tag;
import io.github.gasparbarancelli.blog.utils.StringUtils;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.*;

import static org.asciidoctor.Asciidoctor.Factory.create;

@Entity
@Table(name = "POST")
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "TITLE", nullable = false, length = 100)
    private String title;

    @Column(name = "URL", nullable = false, length = 150)
    private String url;

    @LastModifiedDate
    @Column(name = "LAST_MODIFIED", nullable = false)
    private LocalDate lastModified;

    @Column(name = "SUMMARY", nullable = false)
    private String summary;

    @Column(name = "DESCRIPTION", nullable = false)
    private String description;

    @Column(name = "DESCRIPTION_HTML", nullable = false)
    private String descriptionHtml;

    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private final Set<PostTag> tags = new HashSet<>();

    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private final Set<PostAuthor> authors = new HashSet<>();

    @Deprecated
    public Post() {
    }

    private Post(@NotNull String title, @NotNull String summary, @NotNull String description) {
        this.title = Objects.requireNonNull(title, "title must not be null").trim();
        this.summary = Objects.requireNonNull(summary, "summary must not be null");
        this.description = Objects.requireNonNull(description, "description must not be null");
        this.url = StringUtils.convertToUrlFormat(this.title);
        this.lastModified = LocalDate.now();

        this.descriptionHtml = create().convert(description, new HashMap<>());
    }

    public static Post of(@NotNull String title, @NotNull String summary, @NotNull String description) {
        return new Post(title, summary, description);
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getUrl() {
        return url;
    }

    public LocalDate getLastModified() {
        return lastModified;
    }

    public String getSummary() {
        return summary;
    }

    public String getDescription() {
        return description;
    }

    public String getDescriptionHtml() {
        return descriptionHtml;
    }

    public Set<PostTag> getTags() {
        return Collections.unmodifiableSet(tags);
    }

    public Post addTag(Tag tag) {
        this.tags.add(PostTag.of(tag, this));
        return this;
    }

    public Post addTags(Iterable<Tag> tags) {
        tags.forEach(this::addTag);
        return this;
    }

    public Set<PostAuthor> getAuthors() {
        return Collections.unmodifiableSet(authors);
    }

    public Post addAuthor(Author author) {
        this.authors.add(PostAuthor.of(author, this));
        return this;
    }

    public Post addAuthors(Iterable<Author> authors) {
        authors.forEach(this::addAuthor);
        return this;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Post post = (Post) o;
        return Objects.equals(title, post.title);
    }

    @Override
    public int hashCode() {
        return Objects.hash(title);
    }

}
