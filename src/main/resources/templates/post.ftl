<#import "macro.ftl" as macro>
<@macro.page post.title post.summary keyworks "post", "asciidoctor">
    <article class="post">
        <div class="author">
            <span>POR:</span>
            <#list post.authors as postAuthor>
                <a href="/author/${postAuthor.author.email}" target="_blank">
                    ${postAuthor.author.name}
                </a>
                <#sep>, </#sep>
            </#list>
        </div>
        <h1>${post.title}</h1>
        <div class="lastModified">
            Última modificação em ${(post.lastModified).format("EEEE, dd 'de' MMMM 'de' yyyy")}
        </div>
        ${post.descriptionHtml}
    </article>

    <div class="share">
        <h4>
            // Compartilhe esse Post
        </h4>
        <div class="sharethis-inline-share-buttons"></div>
    </div>

    <#if similarList?has_content>
        <nav class="similar">
            <h4>
                // Posts Relacionados
            </h4>
            <ul>
                <#list similarList as similar>
                    <li>
                        <a href="/post/${similar.url}">
                            ${similar.title}
                        </a>
                    </li>
                </#list>
            </ul>
        </nav>
    </#if>
</@macro.page>
