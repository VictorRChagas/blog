package io.github.gasparbarancelli.blog.ui;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("post")
public class PostController {

    @Autowired private FacadeService facadeService;

    @GetMapping("{url}")
    public ModelAndView get(@PathVariable("url") String url) {
        var model = new ModelAndView("post");
        model.addObject("post", facadeService.getPostByUrl(url));
        return model;
    }

}
