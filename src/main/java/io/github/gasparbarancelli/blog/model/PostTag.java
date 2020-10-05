package io.github.gasparbarancelli.blog.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Objects;

@Entity
@Table(name = "POST")
public class PostTag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "ID_TAG")
    private Tag tag;

    @ManyToOne(optional = false)
    @JoinColumn(name = "ID_POST")
    private Post post;

    @Deprecated
    public PostTag() {
    }

    private PostTag(@NotNull Tag tag, @NotNull Post post) {
        this.tag = Objects.requireNonNull(tag, "tag must not be null");
        this.post = Objects.requireNonNull(post, "post must not be null");
    }

    public static PostTag of(@NotNull Tag tag, @NotNull Post post) {
        return new PostTag(tag, post);
    }

    public Long getId() {
        return id;
    }

    public Tag getTag() {
        return tag;
    }

    public Post getPost() {
        return post;
    }

}
