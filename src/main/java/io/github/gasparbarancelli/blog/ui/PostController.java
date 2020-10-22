package io.github.gasparbarancelli.blog.ui;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("post")
public class PostController {

    private final FacadeService facadeService;

    public PostController(FacadeService facadeService) {
        this.facadeService = facadeService;
    }

    @GetMapping("{url}")
    public ModelAndView get(@PathVariable("url") String url) {
        return facadeService.getPostByUrl(url)
                .map(post -> {
                    var model = new ModelAndView("post");
                    model.addObject("post", post);
                    return model;
                })
                .orElseGet(() -> new ModelAndView("redirect:/"));
    }

}
