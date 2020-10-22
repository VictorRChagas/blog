<#import "macro.ftl" as macro>
<@macro.page "Em Desenvolvimento" "tag">
    <div class="row">
        <div class="col-12 tag">
            <h1>${tag.description}</h1>
            <ul class="posts">
                <#list posts as post>
                    <li title="${post.summary}">
                        <a href="/post/${post.url}" class="post-link">
                            ${post.title}
                        </a>
                        <div class="post-author">
                            Por
                            <#list post.authors as postAuthor>
                                ${postAuthor.author.name}
                            </#list>
                        </div>
                    </li>
                </#list>
            </ul>
        </div>
    </div>
</@macro.page>
