package io.github.gasparbarancelli.blog.post;

import io.github.gasparbarancelli.blog.post.to.PostSimilar;
import io.github.gasparbarancelli.blog.tag.Tag;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class PostServiceImpl implements PostService {

    private final PostNativeQuery postNativeQuery;

    private final PostData postData;

    public PostServiceImpl(PostData postData, PostNativeQuery postNativeQuery) {
        this.postData = postData;
        this.postNativeQuery = postNativeQuery;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Post> findByTag(@NotNull Tag tag, @NotNull Pageable pageable) {
        Objects.requireNonNull(tag, "tag must not be null");
        Objects.requireNonNull(pageable, "pageable must not be null");
        return postData.findByTag(tag, pageable);
    }

    @Override
    public List<PostSimilar> getSimilarPosts(@NotNull Long id, @NotNull Integer limit) {
        Objects.requireNonNull(id, "id must not be null");
        Objects.requireNonNull(limit, "limit must not be null");
        return postNativeQuery.getSimilarPosts(id, limit);
    }

    // todo on pre save, we need to check if the post got updated if so,
    //  we need to update the last modification field
    @Override
    public List<Post> findAll() {
        return postData.findAll();
    }
  
    @Override
    public Optional<Post> findByUrl(@NotNull String url) {
        Objects.requireNonNull(url, "url must not be null");
        return postData.findByUrl(url);
    }

}
