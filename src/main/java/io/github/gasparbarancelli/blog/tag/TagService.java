package io.github.gasparbarancelli.blog.tag;

import javax.validation.constraints.NotNull;
import java.util.List;

public interface TagService {

    Tag save(@NotNull Tag tag);

    List<Tag> findAllByOrderByDescription();

}
