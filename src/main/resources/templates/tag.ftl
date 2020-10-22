<#import "macro.ftl" as macro>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Blog</title>
    <base href="http://localhost:8080/" />
    <link rel="stylesheet" type="text/css" href="webjars/css-reset/2.5.1/reset.min.css" />
    <link rel="stylesheet" type="text/css" href="css/font.css" />
    <link rel="stylesheet" type="text/css" href="webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="css/base.css" />
    <link rel="stylesheet" type="text/css" href="css/index.css" />
    <script src="webjars/jquery/3.5.1/jquery.min.js" type="text/javascript"></script>
    <script src="webjars/bootstrap/4.5.2/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
<@macro.header />
<div class="container">
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
</div>
<@macro.footer tags />
<script src="js/index.js" type="text/javascript"></script>
</body>
</html>
