package io.github.gasparbarancelli.blog.ui;

import io.github.gasparbarancelli.blog.post.Post;
import io.github.gasparbarancelli.blog.post.PostService;
import io.github.gasparbarancelli.blog.post.to.PostSimilar;
import io.github.gasparbarancelli.blog.tag.Tag;
import io.github.gasparbarancelli.blog.tag.TagService;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Optional;

@Service
public class FacadeService {

    private final TagService tagService;
    private final PostService postService;

    public FacadeService(TagService tagService, PostService postService) {
        this.tagService = tagService;
        this.postService = postService;
    }

    public Optional<Tag> getTagByUrl(@NotNull String url) {
        return tagService.findByUrl(url);
    }

    public List<Tag> getTags() {
        return tagService.findAllByOrderByDescription();
    }

    public List<Post> findPostsByTag(@NotNull Tag tag, int size) {
        return postService.findByTag(tag, PageRequest.of(0, size));
    }

    public List<PostSimilar> getSimilarPosts(@NotNull Long id, int size) {
        return postService.getSimilarPosts(id, size);
    }

    public Optional<Post> getPostByUrl(@NotNull String url) {
        return postService.findByUrl(url);
    }

}
