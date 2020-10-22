package io.github.gasparbarancelli.blog.ui;

import io.github.gasparbarancelli.blog.post.Post;
import io.github.gasparbarancelli.blog.tag.Tag;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

@Controller
@RequestMapping("/")
public class IndexController {

    private static final int SIZE_POST_BY_TAG = 5;

    private final FacadeService facadeService;

    public IndexController(FacadeService facadeService) {
        this.facadeService = facadeService;
    }

    @GetMapping
    public ModelAndView index() {
        var model = new ModelAndView("index");
        model.addObject("postsByTag", getPostsByTag());
        return model;
    }

    private HashMap<Tag, List<Post>> getPostsByTag() {
        var tags = facadeService.getTags();
        HashMap<Tag, List<Post>> postsByTag = new LinkedHashMap<>(tags.size());
        for (Tag tag : tags) {
            postsByTag.put(tag, facadeService.findPostsByTag(tag, SIZE_POST_BY_TAG));
        }
        return postsByTag;
    }

}
