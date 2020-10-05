package io.github.gasparbarancelli.blog.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.Set;

public class TagTest {

    private static final String TAG_DESCRIPTION = "Java";

    @Test
    public void emptyCconstructor() {
        Assertions.assertDoesNotThrow(Tag::new);
    }

    @Test
    public void createNewTag() {
        var tag = Tag.of(TAG_DESCRIPTION);
        Assertions.assertNull(tag.getId());
        Assertions.assertEquals(TAG_DESCRIPTION, tag.getDescription());
    }

    @Test
    public void uniqueByDescription() {
        var tag1 = Tag.of(TAG_DESCRIPTION);
        var tag2 = Tag.of(TAG_DESCRIPTION);
        Assertions.assertThrows(IllegalArgumentException.class, () -> Set.of(tag1, tag2));
    }

}
