insert into TAG (ID, DESCRIPTION, URL)
values (1, 'Spring', 'spring');


insert into AUTHOR (ID, NAME, EMAIL)
values (1, 'Gaspar Barancelli Junior', 'gasparbarancelli@gmail.com'),
       (2, 'João Chagas', 'jvrc2000@outlook.com');


insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
    1,
    'Ativando a compactação GZip no Spring Boot',
    'ativando-a-compactacao-gzip-no-spring-boot',
    current_date,
    'A compressão GZip é uma forma muito simples e eficaz de economizar largura de banda e melhorar a velocidade do seu site.',
    'A compressão GZip é uma forma muito simples e eficaz de economizar largura de banda e melhorar a velocidade do seu site.

Ele reduz o tempo de resposta do seu site ao compactar os recursos e enviá-los aos clientes.

A compressão GZip é desabilitada por padrão no Spring Boot. Para ativá-lo, adicione as seguintes propriedades ao seu arquivo de configuração *application.properties*

```properties
# Ativar compressão de resposta
server.compression.enabled=true

# A lista separada por vírgulas de tipos MIME que devem ser compactados
server.compression.mime-types=text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json

# Compacte a resposta apenas se o tamanho da resposta for de pelo menos 1 KB
server.compression.min-response-size=1024
```

Observe que a compactação GZip tem uma pequena sobrecarga. Portanto, adicione a propriedade *min-response-size* para dizer ao servidor de boot do Spring para compactar a resposta apenas se o tamanho for maior do que o valor fornecido.

', '<div class="paragraph">
<p>A compressão GZip é uma forma muito simples e eficaz de economizar largura de banda e melhorar a velocidade do seu site.</p>
</div>
<div class="paragraph">
<p>Ele reduz o tempo de resposta do seu site ao compactar os recursos e enviá-los aos clientes.</p>
</div>
<div class="paragraph">
<p>A compressão GZip é desabilitada por padrão no Spring Boot. Para ativá-lo, adicione as seguintes propriedades ao seu arquivo de configuração <strong>application.properties</strong></p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-properties" data-lang="properties"># Ativar compressão de resposta
server.compression.enabled=true

# A lista separada por vírgulas de tipos MIME que devem ser compactados
server.compression.mime-types=text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json

# Compacte a resposta apenas se o tamanho da resposta for de pelo menos 1 KB
server.compression.min-response-size=1024</code></pre>
</div>
</div>
<div class="paragraph">
<p>Observe que a compactação GZip tem uma pequena sobrecarga. Portanto, adicione a propriedade <strong>min-response-size</strong> para dizer ao servidor de boot do Spring para compactar a resposta apenas se o tamanho for maior do que o valor fornecido.</p>
</div>'), (
    2,
    'Habilitando o cache de recursos estáticos do navegador no Spring Boot',
    'habilitando-o-cache-de-recursos-estaticos-do-navegador-no-spring-boot',
    current_date,
    'O cache do navegador melhora a velocidade de carregamento da página do seu site. Você pode definir cabeçalhos de controle de cache para dizer aos navegadores para armazenar recursos estáticos em cache até um determinado período de tempo.',
    'O cache do navegador melhora a velocidade de carregamento da página do seu site. Você pode definir cabeçalhos de controle de cache para dizer aos navegadores para armazenar recursos estáticos em cache até um determinado período de tempo.

A configuração padrão do Spring Boot desabilita o cache do navegador. Mas podemos ativar o armazenamento em cache definindo as seguintes propriedades no arquivo de configuração *application.properties*.

```properties
# Tempo máximo em que a resposta deve ser armazenada em cache, em segundos mas podendo adicionar um sufixo para que seja armazenado em dias
spring.resources.cache.cachecontrol.max-age=365d

# Indica que uma vez que se tornou obsoleto, um cache não deve usar a resposta sem revalidá-lo com o servidor.
spring.resources.cache.cachecontrol.must-revalidate=true

# Indica que a mensagem de resposta é destinada a um único usuário e não deve ser armazenada por um cache compartilhado como por exemplo o CDN.
spring.resources.cache.cachecontrol.cache-private=false

# Indica que o recurso é publico e qualquer cache pode armazenar a resposta
spring.resources.cache.cachecontrol.cache-public=true
```
', '<div class="paragraph">
<p>O cache do navegador melhora a velocidade de carregamento da página do seu site. Você pode definir cabeçalhos de controle de cache para dizer aos navegadores para armazenar recursos estáticos em cache até um determinado período de tempo.</p>
</div>
<div class="paragraph">
<p>A configuração padrão do Spring Boot desabilita o cache do navegador. Mas podemos ativar o armazenamento em cache definindo as seguintes propriedades no arquivo de configuração <strong>application.properties</strong>.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-properties" data-lang="properties"># Tempo máximo em que a resposta deve ser armazenada em cache, em segundos mas podendo adicionar um sufixo para que seja armazenado em dias
spring.resources.cache.cachecontrol.max-age=365d

# Indica que uma vez que se tornou obsoleto, um cache não deve usar a resposta sem revalidá-lo com o servidor.
spring.resources.cache.cachecontrol.must-revalidate=true

# Indica que a mensagem de resposta é destinada a um único usuário e não deve ser armazenada por um cache compartilhado como por exemplo o CDN.
spring.resources.cache.cachecontrol.cache-private=false

# Indica que o recurso é publico e qualquer cache pode armazenar a resposta
spring.resources.cache.cachecontrol.cache-public=true</code></pre>
</div>
</div>'), (3, 'Utilizando Apache FreeMarker com Spring Boot',
           'utilizando-apache-freeMarker-com-spring-boot',
           current_date,
           'Apache Freemarker é um Template Engine desenvolvido em Java que tem por objetivo gerar saídas de texto.',
           'Apache Freemarker é um Template Engine desenvolvido em Java que tem por objetivo
gerar saídas de texto (páginas da web HTML, e-mails, arquivos de configurações, código fonte, etc.)
com base em modelos e dados variaveis.
Os modelos são escritos em FreeMarker Templates (FTL),
que é uma linguagem simples e especializada, onde você se concentra apenas em como apresentar os dados.

Em um projeto baseado em Spring Boot, devemos adicionar as seguintes dependências.

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-freemarker</artifactId>
</dependency>
<!-- Dependência responsável por fazer com que o FreeMarker suporte os novos objetos de datas disponíveis no Java 8 -->
<dependency>
    <groupId>no.api.freemarker</groupId>
    <artifactId>freemarker-java8</artifactId>
    <version>2.0.0</version>
</dependency>
```

O Apache FreeMarker requer algumas configurações básicas para funcionamento, então devemos definir as seguintes propriedades no arquivo de configuração *application.properties*.

```properties
# Diretório que contem os templates do FreeMarker
spring.freemarker.template-loader-path=classpath:/templates
# Sufixo dos templates
spring.freemarker.suffix=.ftl
# Indicamos a utilização dos macros do Spring nos templates do FreeMarker
spring.freemarker.expose-spring-macro-helpers=true
```

Também devemos configurar quais os diretórios que contem os recursos estáticos (CSS, JS, imagens, etc.) da nossa aplicação. Bem como configurar o Apache FreeMarker para suportar os novos Objetos de data.

Para isso devemos criar uma classe de configuração que implemente WebMvcConfigurer e também BeanPostProcessor.

```java
import no.api.freemarker.java8.Java8ObjectWrapper;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

@Configuration
@EnableWebMvc
public class FreemarkerConfig implements BeanPostProcessor, WebMvcConfigurer {

    /**
        Após a criação de qualquer Bean feita pelo Spring esse método é invocado, por isso verificamos se o objeto Bean recebido por parâmetro é uma instancia de FreeMarkerConfigure, para que assim sejamos capazes de definir o Wrapper padrão do FreeMarker, definindo nossa dependência que sabe lidar com os novos objetos de Data do Java 8
    */
    @Override
    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        if (bean instanceof FreeMarkerConfigurer) {
            FreeMarkerConfigurer configurer = (FreeMarkerConfigurer) bean;
            configurer.getConfiguration().setObjectWrapper(new Java8ObjectWrapper(freemarker.template.Configuration.getVersion()));
        }
        return bean;
    }

    /**
        Definimos que os arquivos estáticos a serem expostos se encontram no diretório resources e static que ficam no classpath da nossa aplicação, bem como também configuração a utilização de webjars.
    */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/**")
                .addResourceLocations(
                        "classpath:/META-INF/resources/",
                        "classpath:/resources/",
                        "classpath:/static/",
                        "/webjars/"
                );
    }

}
```

Com tudo configurado agora podemos criar um template FreeMarker, bem como um recurso estático e um endpoint responsável por retornar a página HTML gerada pelo FreeMarker.

Primeiramente vamos criar uma classe Java que será responsável por responder uma requisição HTTP feita pelo navegador.
Ela tem apenas um endpoint que aceita requisição do verbo GET que sejam feitas no Path raiz da aplicação, e que retorna um objeto do tipo ModelAndView contendo o nome do nosso template do FreeMarker passando como variável para o template a data atual.

```java
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;

@Controller
@RequestMapping("/")
public class IndexController {

    @GetMapping
    public ModelAndView get() {
        return new ModelAndView("index")
                .addObject("currentDate", LocalDate.now());
    }

}
```

O próximo passo é criarmos um arquivo estático (CSS) contendo um estilo para nossa aplicação.

```css
h1 {
    color: green;
}
```

E por fim criamos nosso template FreeMarker que adiciona o arquivo CSS criado no passo anterior e que imprime a data atual formatada.

```html
<html>
    <head>
        <title>FreeMarker and Spring Boot</title>
        <link rel="stylesheet" type="text/css" href="css/index.css" />
    </head>
    <body>
        <h1>
            ${currentDate.format("EEEE, dd ''de'' MMMM ''de'' yyyy")}
        </h1>
    </body>
</html>
```

Pelo navegador agora podemos fazer uma requisição para o endereço *http://localhost:8080* e verificarmos que o HTML da resposta é o mesmo do código abaixo.

```html
<html>
    <head>
        <title>FreeMarker and Spring Boot</title>
        <link rel="stylesheet" type="text/css" href="css/index.css" />
    </head>
    <body>
        <h1>
            sexta-feira, 06 de novembro de 2020
        </h1>
    </body>
</html>
```

O código fonte dessa aplicação esta no https://github.com/gasparbarancelli/spring-boot-freemarker.git[repositório] hospedado no GitHub.
', '<div class="paragraph">
<p>Apache Freemarker é um Template Engine desenvolvido em Java que tem por objetivo
gerar saídas de texto (páginas da web HTML, e-mails, arquivos de configurações, código fonte, etc.)
com base em modelos e dados variaveis.
Os modelos são escritos em FreeMarker Templates (FTL),
que é uma linguagem simples e especializada, onde você se concentra apenas em como apresentar os dados.</p>
</div>
<div class="paragraph">
<p>Em um projeto baseado em Spring Boot, devemos adicionar as seguintes dependências.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-xml" data-lang="xml">&lt;dependency&gt;
    &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;
    &lt;artifactId&gt;spring-boot-starter-web&lt;/artifactId&gt;
&lt;/dependency&gt;
&lt;dependency&gt;
    &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;
    &lt;artifactId&gt;spring-boot-starter-freemarker&lt;/artifactId&gt;
&lt;/dependency&gt;
&lt;!-- Dependência responsável por fazer com que o FreeMarker suporte os novos objetos de datas disponíveis no Java 8 --&gt;
&lt;dependency&gt;
    &lt;groupId&gt;no.api.freemarker&lt;/groupId&gt;
    &lt;artifactId&gt;freemarker-java8&lt;/artifactId&gt;
    &lt;version&gt;2.0.0&lt;/version&gt;
&lt;/dependency&gt;</code></pre>
</div>
</div>
<div class="paragraph">
<p>O Apache FreeMarker requer algumas configurações básicas para funcionamento, então devemos definir as seguintes propriedades no arquivo de configuração <strong>application.properties</strong>.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-properties" data-lang="properties"># Diretório que contem os templates do FreeMarker
spring.freemarker.template-loader-path=classpath:/templates
# Sufixo dos templates
spring.freemarker.suffix=.ftl
# Indicamos a utilização dos macros do Spring nos templates do FreeMarker
spring.freemarker.expose-spring-macro-helpers=true</code></pre>
</div>
</div>
<div class="paragraph">
<p>Também devemos configurar quais os diretórios que contem os recursos estáticos (CSS, JS, imagens, etc.) da nossa aplicação. Bem como configurar o Apache FreeMarker para suportar os novos Objetos de data.</p>
</div>
<div class="paragraph">
<p>Para isso devemos criar uma classe de configuração que implemente WebMvcConfigurer e também BeanPostProcessor.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">import no.api.freemarker.java8.Java8ObjectWrapper;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

@Configuration
@EnableWebMvc
public class FreemarkerConfig implements BeanPostProcessor, WebMvcConfigurer {

    /**
        Após a criação de qualquer Bean feita pelo Spring esse método é invocado, por isso verificamos se o objeto Bean recebido por parâmetro é uma instancia de FreeMarkerConfigure, para que assim sejamos capazes de definir o Wrapper padrão do FreeMarker, definindo nossa dependência que sabe lidar com os novos objetos de Data do Java 8
    */
    @Override
    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        if (bean instanceof FreeMarkerConfigurer) {
            FreeMarkerConfigurer configurer = (FreeMarkerConfigurer) bean;
            configurer.getConfiguration().setObjectWrapper(new Java8ObjectWrapper(freemarker.template.Configuration.getVersion()));
        }
        return bean;
    }

    /**
        Definimos que os arquivos estáticos a serem expostos se encontram no diretório resources e static que ficam no classpath da nossa aplicação, bem como também configuração a utilização de webjars.
    */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/**")
                .addResourceLocations(
                        "classpath:/META-INF/resources/",
                        "classpath:/resources/",
                        "classpath:/static/",
                        "/webjars/"
                );
    }

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Com tudo configurado agora podemos criar um template FreeMarker, bem como um recurso estático e um endpoint responsável por retornar a página HTML gerada pelo FreeMarker.</p>
</div>
<div class="paragraph">
<p>Primeiramente vamos criar uma classe Java que será responsável por responder uma requisição HTTP feita pelo navegador.
Ela tem apenas um endpoint que aceita requisição do verbo GET que sejam feitas no Path raiz da aplicação, e que retorna um objeto do tipo ModelAndView contendo o nome do nosso template do FreeMarker passando como variável para o template a data atual.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;

@Controller
@RequestMapping("/")
public class IndexController {

    @GetMapping
    public ModelAndView get() {
        return new ModelAndView("index")
                .addObject("currentDate", LocalDate.now());
    }

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>O próximo passo é criarmos um arquivo estático (CSS) contendo um estilo para nossa aplicação.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-css" data-lang="css">h1 {
    color: green;
}</code></pre>
</div>
</div>
<div class="paragraph">
<p>E por fim criamos nosso template FreeMarker que adiciona o arquivo CSS criado no passo anterior e que imprime a data atual formatada.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-html" data-lang="html">&lt;html&gt;
    &lt;head&gt;
        &lt;title&gt;FreeMarker and Spring Boot&lt;/title&gt;
        &lt;link rel="stylesheet" type="text/css" href="css/index.css" /&gt;
    &lt;/head&gt;
    &lt;body&gt;
        &lt;h1&gt;
            ${currentDate.format("EEEE, dd ''de'' MMMM ''de'' yyyy")}
        &lt;/h1&gt;
    &lt;/body&gt;
&lt;/html&gt;</code></pre>
</div>
</div>
<div class="paragraph">
<p>Pelo navegador agora podemos fazer uma requisição para o endereço <strong><a href="http://localhost:8080" class="bare">http://localhost:8080</a></strong> e verificarmos que o HTML da resposta é o mesmo do código abaixo.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-html" data-lang="html">&lt;html&gt;
    &lt;head&gt;
        &lt;title&gt;FreeMarker and Spring Boot&lt;/title&gt;
        &lt;link rel="stylesheet" type="text/css" href="css/index.css" /&gt;
    &lt;/head&gt;
    &lt;body&gt;
        &lt;h1&gt;
            sexta-feira, 06 de novembro de 2020
        &lt;/h1&gt;
    &lt;/body&gt;
&lt;/html&gt;</code></pre>
</div>
</div>
<div class="paragraph">
<p>O código fonte dessa aplicação esta no <a href="https://github.com/gasparbarancelli/spring-boot-freemarker.git">repositório</a> hospedado no GitHub.</p>
</div>');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 1, 1 ), (2, 1), (3, 1);
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 1, 1 ), (2,1), (3, 1);
