package io.github.gasparbarancelli.blog.post;

import io.github.gasparbarancelli.blog.tag.Tag;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Objects;

@Service
public class PostServiceImpl implements PostService {

    private final PostData postData;

    public PostServiceImpl(PostData postData) {
        this.postData = postData;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Post> findByTag(@NotNull Tag tag, @NotNull Pageable pageable) {
        Objects.requireNonNull(tag, "tag must not be null");
        Objects.requireNonNull(pageable, "pageable must not be null");
        return postData.findByTag(tag, pageable);
    }

}
