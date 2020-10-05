package io.github.gasparbarancelli.blog.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.Set;

public class PostAuthorTest {

    private static final Author author = Author.builder(
            "Gaspar Barancelli Junior",
            "gasparbarancelli@gmail.com"
    ).build();

    private static final Post post = Post.of(
            "Clean Code",
            "Summary",
            "Description"
    );

    @Test
    public void emptyConstructor() {
        Assertions.assertDoesNotThrow(PostAuthor::new);
    }

    @Test
    public void createNewPostAuthor() {
        var postAuthor = PostAuthor.of(author, post);
        Assertions.assertNull(postAuthor.getId());
        Assertions.assertEquals(postAuthor.getAuthor(), author);
        Assertions.assertEquals(postAuthor.getPost(), post);
    }

    @Test
    public void unique() {
        var postAuthor1 = PostAuthor.of(author, post);
        var postAuthor2 = PostAuthor.of(author, post);
        Assertions.assertThrows(IllegalArgumentException.class, () -> Set.of(postAuthor1, postAuthor2));
    }

}
