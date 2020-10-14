package io.github.gasparbarancelli.blog.post;

import io.github.gasparbarancelli.blog.tag.Tag;
import org.springframework.data.domain.Pageable;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Optional;

public interface PostService {

    List<Post> findByTag(@NotNull Tag tag, @NotNull Pageable pageable);

    List<Post> findAll();
  
    Optional<Post> findByUrl(@NotNull String url);
  
}
