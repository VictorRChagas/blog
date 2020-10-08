package io.github.gasparbarancelli.blog.post;

import io.github.gasparbarancelli.blog.tag.Tag;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Optional;

public interface PostData extends JpaRepository<Post, Long> {

    @Query("select p from Post p inner join p.tags t where t.tag = ?1")
    List<Post> findByTag(@NotNull Tag tag, @NotNull Pageable pageable);

    Optional<Post> findByUrl(@NotNull String url);

}
