package io.github.gasparbarancelli.blog.ui;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("development")
public class DevelopmentController {

    @GetMapping
    public String get() {
        return "development";
    }

}
