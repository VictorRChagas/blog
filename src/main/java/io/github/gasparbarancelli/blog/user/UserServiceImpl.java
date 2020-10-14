package io.github.gasparbarancelli.blog.user;

import com.mchange.v2.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    private final UserData userData;

    public UserServiceImpl(UserData userData) {
        this.userData = userData;
    }

    @Override
    public User save(User user) {
        return userData.save(user);
    }

    @Override
    public boolean deleteById(Long userId) {
        return userData.deleteUserById(userId) == 1;
    }

    @Override
    public Optional<User> findByEmail(@NotNull String email) {
        if (StringUtils.nonEmptyString(email)) {
            return userData.findByEmailAnd(email);
        }
        return Optional.empty();
    }
}
