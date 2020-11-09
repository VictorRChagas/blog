package io.github.gasparbarancelli.blog.post;

import io.github.gasparbarancelli.NativeQuery;
import io.github.gasparbarancelli.NativeQueryParam;
import io.github.gasparbarancelli.blog.post.to.PostSimilar;

import javax.validation.constraints.NotNull;
import java.util.List;

public interface PostNativeQuery extends NativeQuery {

    List<PostSimilar> getSimilarPosts(
            @NativeQueryParam("id") @NotNull Long id,
            @NativeQueryParam("limit") @NotNull Integer limit
    );

}
