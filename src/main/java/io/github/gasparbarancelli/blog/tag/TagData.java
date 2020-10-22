package io.github.gasparbarancelli.blog.tag;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface TagData extends JpaRepository<Tag, Long> {

    List<Tag> findAllByOrderByDescription();

    Optional<Tag> findByUrl(String url);

}
