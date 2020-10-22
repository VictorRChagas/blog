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
        <link rel="stylesheet" type="text/css" href="css/asciidoctor.css" />
        <link rel="stylesheet" type="text/css" href="css/post.css" />
        <script src="webjars/jquery/3.5.1/jquery.min.js" type="text/javascript"></script>
        <script src="webjars/bootstrap/4.5.2/js/bootstrap.min.js" type="text/javascript"></script>
    </head>
    <body>
        <@macro.header />
        <div class="container">
            <article class="post">
                <h1>${post.title}</h1>
                <div class="lastModified">
                    Última modificação em ${(post.lastModified).format("EEEE, dd 'de' MMMM 'de' yyyy")}
                </div>
                ${post.descriptionHtml}
            </article>
        </div>
        <@macro.footer tags />
        <script src="js/index.js" type="text/javascript"></script>
    </body>
</html>
