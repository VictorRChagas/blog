package io.github.gasparbarancelli.blog.user;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    /***
     * endpoint for registering a new user
     */
    @PostMapping
    public ResponseEntity<User> save(@RequestBody User user) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(userService.save(user));
    }

    /***
     * endpoint for deleting a user
     */
    @PostMapping
    public ResponseEntity<Boolean> deleteUserById(@RequestBody Long userId) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(userService.deleteById(userId));
    }
}
