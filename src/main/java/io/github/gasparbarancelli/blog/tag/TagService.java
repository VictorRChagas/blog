package io.github.gasparbarancelli.blog.tag;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Optional;

public interface TagService {

    Tag save(@NotNull Tag tag);

    List<Tag> findAllByOrderByDescription();

    Optional<Tag> findByUrl(@NotNull String url);

}
