package io.github.gasparbarancelli.blog.tag;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/tag")
public class TagApi {

    private final TagService tagService;

    public TagApi(TagService tagService) {
        this.tagService = tagService;
    }

    @PostMapping
    public ResponseEntity<Tag> save(@RequestParam("description") String description) {
        var tag = Tag.of(description);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(tagService.save(tag));
    }

}
