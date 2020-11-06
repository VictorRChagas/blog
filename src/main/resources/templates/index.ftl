<#import "macro.ftl" as macro>
<@macro.page
    "Blog"
    "Programação, desenvolvimento da Web e notícias de DevOps, tutoriais e ferramentas para iniciantes a especialistas, contendo centenas de publicações gratuitas"
    "programação, desenvolvimento de software, devops, java, agile, web, iot, database, mobile, big data, cloud, docker, kubernetes"
    "index">
    <div class="row">
        <#list postsByTag as tag, posts>
            <div class="col-12 col-md-6 tag">
                <h1>
                    <a href="/tag/${tag.url}" class="tag-link">
                        ${tag.description}
                    </a>
                </h1>
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
        </#list>
    </div>
</@macro.page>
