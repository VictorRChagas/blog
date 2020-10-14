package io.github.gasparbarancelli.blog.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

public interface UserData extends JpaRepository<User, Long> {

    Optional<User> findByEmailAnd(String email);

    @Transactional
    @Modifying
    @Query("delete from User u where u.id = ?1")
    int deleteUserById(Long userId);
}
