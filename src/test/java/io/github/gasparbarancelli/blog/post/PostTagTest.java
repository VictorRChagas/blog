package io.github.gasparbarancelli.blog.post;

import io.github.gasparbarancelli.blog.tag.Tag;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.Set;

public class PostTagTest {

    private static final Tag tag = Tag.of("Java");

    private static final Post post = Post.of(
            "Clean Code",
            "Summary",
            "Description",
            "https://www.blog.com.br/spring/clean-code"
    );

    @Test
    public void emptyConstructor() {
        Assertions.assertDoesNotThrow(PostTag::new);
    }

    @Test
    public void createNewPostTag() {
        var postTag = PostTag.of(tag, post);
        Assertions.assertNull(postTag.getId());
        Assertions.assertEquals(postTag.getTag(), tag);
        Assertions.assertEquals(postTag.getPost(), post);
    }

    @Test
    public void unique() {
        var postTag1 = PostTag.of(tag, post);
        var postTag2 = PostTag.of(tag, post);
        Assertions.assertThrows(IllegalArgumentException.class, () -> Set.of(postTag1, postTag2));
    }
}
