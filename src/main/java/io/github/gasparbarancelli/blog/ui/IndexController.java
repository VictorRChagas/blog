package io.github.gasparbarancelli.blog.ui;

import io.github.gasparbarancelli.blog.post.Post;
import io.github.gasparbarancelli.blog.tag.Tag;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.constraints.NotNull;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/")
public class IndexController {

    private final FacadeService facadeService;

    public IndexController(FacadeService facadeService) {
        this.facadeService = facadeService;
    }

    @GetMapping
    public ModelAndView index() {
        var model = new ModelAndView("index");
        var tags = facadeService.getTags();
        model.addObject("tags", tags);
        model.addObject("postsByTag", getPostsByTag(tags));
        return model;
    }

    private HashMap<Tag, List<Post>> getPostsByTag(@NotNull List<Tag> tags) {
        Objects.requireNonNull(tags, "tags must not be null");
        HashMap<Tag, List<Post>> postsByTag = new LinkedHashMap<>(tags.size());
        for (Tag tag : tags) {
            postsByTag.put(tag, facadeService.findTop5PostsByTag(tag));
        }
        return postsByTag;
    }

}
