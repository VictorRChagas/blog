package io.github.gasparbarancelli.blog.tag;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Objects;

@Service
public class TagServiceImpl implements TagService {

    private final TagData tagData;

    public TagServiceImpl(TagData tagData) {
        this.tagData = tagData;
    }

    @Override
    public Tag save(@NotNull Tag tag) {
        Objects.requireNonNull(tag, "tag must not be null");
        return tagData.save(tag);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Tag> findAllByOrderByDescription() {
        return tagData.findAllByOrderByDescription();
    }

}
