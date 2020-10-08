package io.github.gasparbarancelli.blog.tag;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TagData extends JpaRepository<Tag, Long> {

    List<Tag> findAllByOrderByDescription();

}
