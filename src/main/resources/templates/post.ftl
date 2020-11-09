<#import "macro.ftl" as macro>
<@macro.page post.title post.summary keyworks "post", "asciidoctor">
    <article class="post">
        <h1>${post.title}</h1>
        <div class="lastModified">
            Última modificação em ${(post.lastModified).format("EEEE, dd 'de' MMMM 'de' yyyy")}
        </div>
        ${post.descriptionHtml}
    </article>

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
