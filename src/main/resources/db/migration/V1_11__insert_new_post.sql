insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
           10,
           'Construindo imagem Docker em projetos Java',
           'construindo-imagem-docker-em-projetos-java',
           current_date,
           'Docker se tornou o padrão no setor de containers e conta com suporte dos maiores fornecedores do ecossistema Linux. Com toda certeza o Docker se tornou padrão para implantação de serviços ou aplicativos baseado em servidor.',
           'Docker se tornou o padrão no setor de containers e conta com suporte dos maiores fornecedores do ecossistema Linux. Com toda certeza o Docker se tornou padrão para implantação de serviços ou aplicativos baseado em servidor.

Mas como podemos gerar uma imagem Docker da nossa aplicação e qual a melhor forma de fazer isso?

Nesse artigo trago 2 exemplos de plugins que utilizo em meus projetos para criar imagens Docker.

Primeiramente vamos falar do https://github.com/GoogleContainerTools/jib[Jib]. Ele é um construtor de imagens para containers, desenvolvido em Java, tem plugins tanto para o Maven como para o Gradle, não é necessário ter nenhum arquivo de configuração como o Dockerfile, e o mais legal de tudo é que ele separa o aplicativo em varias camadas, caso tenha apenas alteração no código fonte da aplicação, apenas a camada do código é reconstruída, caso tenha alguma nova dependência adicionada a aplicação apenas essa camada é reconstruida.

Segue exemplo da configuração do plugin do *Jib* utilizando Maven, onde podemos definir o nome da imagem, definir as flags para a JVM e qual a classe Main.

```xml
<plugin>
    <groupId>com.google.cloud.tools</groupId>
    <artifactId>jib-maven-plugin</artifactId>
    <version>2.6.0</version>
    <configuration>
        <from>
            <image>openjdk:15-jdk-slim-buster</image>
        </from>
        <to>
            <image>gasparbarancelli/blog:${build.number}</image>
        </to>
        <container>
            <jvmFlags>
                <jvmFlag>-Xms512m</jvmFlag>
                <jvmFlag>-Xmx2048m</jvmFlag>
            </jvmFlags>
            <mainClass>com.gasparbarancelli.BlogApplication</mainClass>
        </container>
    </configuration>
</plugin>
```

Com o plugin configurado agora podemos executar a seguinte tarefa (Goal) no Maven.

```shell
# Para construir a imagem sem o Docker Daemon.
mvn compile jib:build
# Para construir a imagem utilizando o Docker daemon.
mvn compile jib:dockerBuild
```

Para verificarmos que a imagem foi construída com sucesso, podemos digitar o seguinte comando.

```shell
docker images | grep blog
```

Para o segundo exemplo vamos utilizar um plugin desenvolvido pelo Spotify.

Devemos criar em nosso projeto o arquivo Dockerfile, esse arquivo deve conter as configurações necessárias para construir nossa imagem, por melhor pratica devemos adicionar esse arquivo dentro do projeto, no meu caso adicionei o arquivo no seguinte diretorio *src/main/docker*. Repare que nesse arquivo configuramos a imagem base, adicionamos o artefato gerado pelo maven dentro da imagem e também definimos o comando que deve ser executado ao iniciar o container docker.

```shell
FROM openjdk:15-jdk-slim-buster
ADD blog.jar app.jar
RUN sh -c ''touch /app.jar''
ENTRYPOINT [ "sh", "-c", "java -Xms512m -Xmx2048m -jar /app.jar"]
```

Depois de configurarmos o Dockerfile podemos adicionar o plugin do maven.

```xml
<plugin>
    <groupId>com.spotify</groupId>
    <artifactId>docker-maven-plugin</artifactId>
    <version>1.2.2</version>
    <configuration>
        <imageName>gasparbarancelli/blog</imageName>
        <imageTags>${build.number}</imageTags>
        <dockerDirectory>src/main/docker</dockerDirectory>
        <resources>
            <resource>
                <targetPath>/</targetPath>
                <directory>${project.build.directory}</directory>
                <include>${project.build.finalName}.jar</include>
            </resource>
        </resources>
    </configuration>
</plugin>
```

Com o plugin configurado agora podemos executar a seguinte tarefa (Goal) no Maven.

```shell
mvn compile docker:build
```

Assim como no exemplo anterior, para verificarmos que a imagem foi construída com sucesso, podemos digitar o seguinte comando.

```shell
docker images | grep blog
```
', '<div class="paragraph">
<p>Docker se tornou o padrão no setor de containers e conta com suporte dos maiores fornecedores do ecossistema Linux. Com toda certeza o Docker se tornou padrão para implantação de serviços ou aplicativos baseado em servidor.</p>
</div>
<div class="paragraph">
<p>Mas como podemos gerar uma imagem Docker da nossa aplicação e qual a melhor forma de fazer isso?</p>
</div>
<div class="paragraph">
<p>Nesse artigo trago 2 exemplos de plugins que utilizo em meus projetos para criar imagens Docker.</p>
</div>
<div class="paragraph">
<p>Primeiramente vamos falar do <a href="https://github.com/GoogleContainerTools/jib">Jib</a>. Ele é um construtor de imagens para containers, desenvolvido em Java, tem plugins tanto para o Maven como para o Gradle, não é necessário ter nenhum arquivo de configuração como o Dockerfile, e o mais legal de tudo é que ele separa o aplicativo em varias camadas, caso tenha apenas alteração no código fonte da aplicação, apenas a camada do código é reconstruída, caso tenha alguma nova dependência adicionada a aplicação apenas essa camada é reconstruida.</p>
</div>
<div class="paragraph">
<p>Segue exemplo da configuração do plugin do <strong>Jib</strong> utilizando Maven, onde podemos definir o nome da imagem, definir as flags para a JVM e qual a classe Main.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-xml" data-lang="xml">&lt;plugin&gt;
    &lt;groupId&gt;com.google.cloud.tools&lt;/groupId&gt;
    &lt;artifactId&gt;jib-maven-plugin&lt;/artifactId&gt;
    &lt;version&gt;2.6.0&lt;/version&gt;
    &lt;configuration&gt;
        &lt;from&gt;
            &lt;image&gt;openjdk:15-jdk-slim-buster&lt;/image&gt;
        &lt;/from&gt;
        &lt;to&gt;
            &lt;image&gt;gasparbarancelli/blog:${build.number}&lt;/image&gt;
        &lt;/to&gt;
        &lt;container&gt;
            &lt;jvmFlags&gt;
                &lt;jvmFlag&gt;-Xms512m&lt;/jvmFlag&gt;
                &lt;jvmFlag&gt;-Xmx2048m&lt;/jvmFlag&gt;
            &lt;/jvmFlags&gt;
            &lt;mainClass&gt;com.gasparbarancelli.BlogApplication&lt;/mainClass&gt;
        &lt;/container&gt;
    &lt;/configuration&gt;
&lt;/plugin&gt;</code></pre>
</div>
</div>
<div class="paragraph">
<p>Com o plugin configurado agora podemos executar a seguinte tarefa (Goal) no Maven.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell"># Para construir a imagem sem o Docker Daemon.
mvn compile jib:build
# Para construir a imagem utilizando o Docker daemon.
mvn compile jib:dockerBuild</code></pre>
</div>
</div>
<div class="paragraph">
<p>Para verificarmos que a imagem foi construída com sucesso, podemos digitar o seguinte comando.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">docker images | grep blog</code></pre>
</div>
</div>
<div class="paragraph">
<p>Para o segundo exemplo vamos utilizar um plugin desenvolvido pelo Spotify.</p>
</div>
<div class="paragraph">
<p>Devemos criar em nosso projeto o arquivo Dockerfile, esse arquivo deve conter as configurações necessárias para construir nossa imagem, por melhor pratica devemos adicionar esse arquivo dentro do projeto, no meu caso adicionei o arquivo no seguinte diretorio <strong>src/main/docker</strong>. Repare que nesse arquivo configuramos a imagem base, adicionamos o artefato gerado pelo maven dentro da imagem e também definimos o comando que deve ser executado ao iniciar o container docker.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">FROM openjdk:15-jdk-slim-buster
ADD blog.jar app.jar
RUN sh -c ''touch /app.jar''
ENTRYPOINT [ "sh", "-c", "java -Xms512m -Xmx2048m -jar /app.jar"]</code></pre>
</div>
</div>
<div class="paragraph">
<p>Depois de configurarmos o Dockerfile podemos adicionar o plugin do maven.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-xml" data-lang="xml">&lt;plugin&gt;
    &lt;groupId&gt;com.spotify&lt;/groupId&gt;
    &lt;artifactId&gt;docker-maven-plugin&lt;/artifactId&gt;
    &lt;version&gt;1.2.2&lt;/version&gt;
    &lt;configuration&gt;
        &lt;imageName&gt;gasparbarancelli/blog&lt;/imageName&gt;
        &lt;imageTags&gt;${build.number}&lt;/imageTags&gt;
        &lt;dockerDirectory&gt;src/main/docker&lt;/dockerDirectory&gt;
        &lt;resources&gt;
            &lt;resource&gt;
                &lt;targetPath&gt;/&lt;/targetPath&gt;
                &lt;directory&gt;${project.build.directory}&lt;/directory&gt;
                &lt;include&gt;${project.build.finalName}.jar&lt;/include&gt;
            &lt;/resource&gt;
        &lt;/resources&gt;
    &lt;/configuration&gt;
&lt;/plugin&gt;</code></pre>
</div>
</div>
<div class="paragraph">
<p>Com o plugin configurado agora podemos executar a seguinte tarefa (Goal) no Maven.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">mvn compile docker:build</code></pre>
</div>
</div>
<div class="paragraph">
<p>Assim como no exemplo anterior, para verificarmos que a imagem foi construída com sucesso, podemos digitar o seguinte comando.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">docker images | grep blog</code></pre>
</div>
</div>');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 10, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 10, 3), (10, 4);
