package io.github.gasparbarancelli.blog.ui;

import io.github.gasparbarancelli.blog.post.Post;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.constraints.NotNull;
import java.util.Objects;
import java.util.stream.Collectors;

@Controller
@RequestMapping("post")
public class PostController {

    private static final int SIZE_SIMILAR_POSTS = 5;

    private final FacadeService facadeService;

    public PostController(FacadeService facadeService) {
        this.facadeService = facadeService;
    }

    @GetMapping("{url}")
    public ModelAndView get(@PathVariable("url") String url) {
        return facadeService.getPostByUrl(url)
                .map(post -> {
                    var similarList = facadeService.getSimilarPosts(post.getId(), SIZE_SIMILAR_POSTS);

                    var model = new ModelAndView("post");
                    model.addObject("post", post);
                    model.addObject("keyworks", getKeyWords(post));
                    model.addObject("similarList", similarList);
                    return model;
                })
                .orElseGet(() -> new ModelAndView("redirect:/"));
    }

    private String getKeyWords(@NotNull Post post) {
        Objects.requireNonNull(post, "post must not be null");
        return post.getTags().stream()
                .map(it -> it.getTag().getDescription())
                .collect(Collectors.joining());
    }

}
