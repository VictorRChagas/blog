<!DOCTYPE html>
<html lang="en">
<head>
    <title>Blog</title>
    <link rel="stylesheet" type="text/css" href="webjars/css-reset/2.5.1/reset.min.css" />
    <link rel="stylesheet" type="text/css" href="css/font.css" />
    <link rel="stylesheet" type="text/css" href="webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="css/index.css" />
    <script src="webjars/jquery/3.5.1/jquery.min.js" type="text/javascript"></script>
    <script src="webjars/bootstrap/4.5.2/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
    <div class="container">
        <div class="row">
            <#list postsByTag as tag, posts>
                <div class="col-12 col-md-6">
                    <h1>${tag.description}</h1>
                    <ul>
                        <#list posts as post>
                            <li title="${post.summary}">${post.title}</li>
                        </#list>
                    </ul>
                </div>
            </#list>
        </div>
    </div>
    <script src="js/index.js" type="text/javascript"></script>
</body>
</html>
