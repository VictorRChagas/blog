package io.github.gasparbarancelli.blog.newsletter;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface NewsLetterData extends JpaRepository<NewsLetter, Long> {

    @Transactional
    @Modifying
    @Query("delete from NewsLetter n where n.email = ?1")
    int deleteByEmail(String email);

}
