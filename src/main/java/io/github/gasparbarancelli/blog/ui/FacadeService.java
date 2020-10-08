package io.github.gasparbarancelli.blog.ui;

import io.github.gasparbarancelli.blog.post.Post;
import io.github.gasparbarancelli.blog.post.PostService;
import io.github.gasparbarancelli.blog.tag.Tag;
import io.github.gasparbarancelli.blog.tag.TagService;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;
import java.util.List;

@Service
public class FacadeService {

    private final TagService tagService;
    private final PostService postService;

    public FacadeService(TagService tagService, PostService postService) {
        this.tagService = tagService;
        this.postService = postService;
    }

    public List<Tag> getTags() {
        return tagService.findAllByOrderByDescription();
    }

    public List<Post> findTop5PostsByTag(@NotNull Tag tag) {
        return postService.findByTag(tag, PageRequest.of(0, 5));
    }

}
