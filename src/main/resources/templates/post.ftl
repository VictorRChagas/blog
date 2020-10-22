<#import "macro.ftl" as macro>
<@macro.page post.title "post">
    <article class="post">
        <h1>${post.title}</h1>
        <div class="lastModified">
            Última modificação em ${(post.lastModified).format("EEEE, dd 'de' MMMM 'de' yyyy")}
        </div>
        ${post.descriptionHtml}
    </article>
</@macro.page>
