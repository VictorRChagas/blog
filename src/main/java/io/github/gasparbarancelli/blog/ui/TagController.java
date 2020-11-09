package io.github.gasparbarancelli.blog.ui;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("tag")
public class TagController {

    private static final int SIZE_POST_BY_TAG = 30;

    private final FacadeService facadeService;

    public TagController(FacadeService facadeService) {
        this.facadeService = facadeService;
    }

    @GetMapping("{url}")
    public ModelAndView get(@PathVariable("url") String url) {
        return facadeService.getTagByUrl(url)
                .map(tag -> {
                    var posts = facadeService.findPostsByTag(tag, SIZE_POST_BY_TAG);
                    var model = new ModelAndView("tag");
                    model.addObject("tag", tag);
                    model.addObject("posts", posts);
                    return model;
                })
                .orElseGet(() -> new ModelAndView("redirect:/"));
    }

}
