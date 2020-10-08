package io.github.gasparbarancelli.blog.post;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;
import java.util.Set;

public class PostTest {

    private static final String POST_TITLE = "Clean Code";
    private static final String POST_SUMMARY = "Summary";
    private static final String POST_DESCRIPTION = "Description";
    private Post post;

    @BeforeEach
    void init() {
        post = Post.of(POST_TITLE, POST_SUMMARY, POST_DESCRIPTION);
    }

    @Test
    public void emptyConstructor() {
        Assertions.assertDoesNotThrow(Post::new);
    }

    @Test
    public void createNewPost() {
        Assertions.assertNull(post.getId());
        Assertions.assertEquals(POST_TITLE, post.getTitle());
        Assertions.assertEquals(POST_SUMMARY, post.getSummary());
        Assertions.assertEquals(POST_DESCRIPTION, post.getDescription());
        Assertions.assertEquals(0, post.getAuthors().size());
        Assertions.assertEquals(0, post.getTags().size());
        Assertions.assertEquals(LocalDate.now(), post.getLastModified());
    }

    @Test
    public void uniqueByTitle() {
        var post2 = Post.of(POST_TITLE, POST_SUMMARY, POST_DESCRIPTION);
        Assertions.assertThrows(IllegalArgumentException.class, () -> Set.of(post, post2));
    }

    @Test
    public void addTag() {
        post.addTag(Tag.of("Java"))
            .addTag(Tag.of("Clean Code"))
            .addTag(Tag.of("OOP"));

        Assertions.assertEquals(3, post.getTags().size());
    }

    @Test
    public void addTags() {
        var tags = Set.of(
                Tag.of("Java"),
                Tag.of("Clean Code"),
                Tag.of("OOP")
        );
        post.addTags(tags);
        Assertions.assertEquals(3, post.getTags().size());
    }

    @Test
    public void immutableTags() {
        var tagJava = Tag.of("Java");
        var postTag = PostTag.of(tagJava, post);
        Assertions.assertThrows(UnsupportedOperationException.class, () -> post.getTags().add(postTag));
    }

    @Test
    public void addAuthor() {
        var authorGasparJr = Author.builder(
                "Gaspar Barancelli Junior",
                "gasparbarancelli@gmail.com"
        ).build();

        var authorGasparBarancelli = Author.builder(
                "Gaspar Barancelli",
                "gasparbarancelli@hotmail.com"
        ).build();

        post.addAuthor(authorGasparJr)
            .addAuthor(authorGasparBarancelli);

        Assertions.assertEquals(2, post.getAuthors().size());
    }

    @Test
    public void addAuthors() {
        var authorGasparJr = Author.builder(
                "Gaspar Barancelli Junior",
                "gasparbarancelli@gmail.com"
        ).build();

        var authorGasparBarancelli = Author.builder(
                "Gaspar Barancelli",
                "gasparbarancelli@hotmail.com"
        ).build();

        var authors = Set.of(authorGasparJr, authorGasparBarancelli);
        post.addAuthors(authors);
        Assertions.assertEquals(2, post.getAuthors().size());
    }

    @Test
    public void immutableAuthors() {
        var author = Author.builder(
                "Gaspar Barancelli Junior",
                "gasparbarancelli@gmail.com"
        ).build();

        var postAuthor = PostAuthor.of(author, post);
        Assertions.assertThrows(UnsupportedOperationException.class, () -> post.getAuthors().add(postAuthor));
    }

}
