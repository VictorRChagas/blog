package io.github.gasparbarancelli.blog.post;

import io.github.gasparbarancelli.blog.post.to.PostSimilar;
import io.github.gasparbarancelli.blog.tag.Tag;
import org.springframework.data.domain.Pageable;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Optional;

public interface PostService {

    List<Post> findByTag(@NotNull Tag tag, @NotNull Pageable pageable);

    /**
     * Searches the database for a list of posts that have the same tag as the post passed by parameter
     * @param id post identifier
     * @param limit maximum number of posts to be returned
     * @return list of similar posts
     */
    List<PostSimilar> getSimilarPosts(@NotNull Long id, @NotNull Integer limit);

    List<Post> findAll();
  
    Optional<Post> findByUrl(@NotNull String url);
  
}
