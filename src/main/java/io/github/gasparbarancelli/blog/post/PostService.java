package io.github.gasparbarancelli.blog.post;

import io.github.gasparbarancelli.blog.tag.Tag;
import org.springframework.data.domain.Pageable;

import javax.validation.constraints.NotNull;
import java.util.List;

public interface PostService {

    List<Post> findByTag(@NotNull Tag tag, @NotNull Pageable pageable);

}
