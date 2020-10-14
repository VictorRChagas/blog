package io.github.gasparbarancelli.blog.user;

import javax.validation.constraints.NotNull;
import java.util.Optional;

public interface UserService {

    Optional<User> findByEmail(@NotNull String email);

    User save(User user);

    boolean deleteById(Long userId);
}
