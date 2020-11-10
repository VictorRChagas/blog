insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
           12,
           'Configurando e customizando a serialização e desserialização de Objetos Java com Spring Boot',
           'configurando-e-customizando-a-serializacao-e-desserializacao-de-objetos-java-com-spring-boot',
           current_date,
           'Em ciência da computação, no contexto de armazenamento e transmissão de dados, serialização é o processo de tradução de estruturas de dados ou estado de objeto em um formato que possa ser armazenado e reconstruído posteriormente no mesmo ou em outro ambiente computacional.',
           'Em ciência da computação, no contexto de armazenamento e transmissão de dados, serialização é o processo de tradução de estruturas de dados ou estado de objeto em um formato que possa ser armazenado e reconstruído posteriormente no mesmo ou em outro ambiente computacional.

O Spring Boot por padrão utiliza a biblioteca Jackson para serialização e desserialização de objetos Java para Json. Tanto o Spring como biblioteca Jackson nos permite configurar módulos para customizar toda e qualquer serialização e desserialização de nossos objetos.

Como exemplo vamos implementar uma serialização e desserialização para objetos do tipo LocalDate.

Primeiramente vamos criar uma classe responsável pela serialização, vamos chama-la de _LocalDateSerializer_, ela deve extender _JsonSerializer_ e passar como tipagem o objeto LocalDate. Ao extender a classe _LocalDateSerializer_ somos obrigados a implementar o método _serialize_, nesse método devemos ser capazes de transformar um objeto Java em uma String, como a tipagem informada é LocalDate, receberemos um objeto desse tipo por parâmetro, então vamos formata-lo para o padrão _ISO_LOCAL_DATE (yyyy-MM-dd)_;
```java
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class LocalDateSerializer extends JsonSerializer<LocalDate> {

    @Override
    public void serialize(LocalDate value, JsonGenerator generator, SerializerProvider serializers) throws IOException {
        String formattedDate = value.format(DateTimeFormatter.ISO_LOCAL_DATE);
        generator.writeString(formattedDate);
    }

}
```

Nessa segunda etapa vamos criar uma classe responsavel pela desserialização, então vamos chamala de _LocalDateDeserializer_, esta classe vai extender _JsonDeserializer_ e passar como tipagem o objeto LocalDate. Ao extender a classe _JsonDeserializer_ somos obrigados a implementar o método _deserialize_, nesse método devemos ser capazes de transformar uma String em um Objeto Java, como a tipagem informada é LocalDate, devemos converter uma String em LocalDate, para isso vamos dar um parse no objeto LocalDate passando por parâmetro o valor recebido em String e o formato _ISO_LOCAL_DATE (yyyy-MM-dd)_;

```java
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class LocalDateDeserializer extends JsonDeserializer<LocalDate> {

    @Override
    public LocalDate deserialize(JsonParser parser, DeserializationContext context) throws IOException {
        String value = parser.getValueAsString();
        return LocalDate.parse(value, DateTimeFormatter.ISO_LOCAL_DATE);
    }

}
```

Em nossa última etapa vamos configurar o Jackson e também o Spring, para que eles facam uso dos nossos novos conversores. Para isso vamos criar uma classe chamada _WebConfig_ que implementa _WebMvcConfigurer_, nessa classe vamos sobrescrever o método _configureMessageConverters_, este método recebe uma lista de classes responsáveis por converterem objetos dependendo do formato da saida escolhido na requisição.

Vamos olhar com mais cuidado para essa classe a seguir, vejamos que ela recebe um objeto do tipo ObjectMapper pelo construtor, esse objeto é um bean criado pelo Spring, ele fornece funcionalidades para leitura e gravação de JSON, de e para POJOs (Plain Old Java Objects). Devemos injetar esse objeto pois ele é a base para a nossa configuração.

Agora observe a implementação do método _customJackson2HttpJsonMessageConverter_, nesse método criamos um novo modulo Jackson, e nesse modulo adicionamos nossas classes criadas anteriormente, depois registramos o modulo no ObjectMapper e por fim instanciámos um objeto do tipo _MappingJackson2HttpMessageConverter_ atribuindo o ObjectMapper alterado por parâmetro.

No método _configureMessageConverters_ que sobrescrevemos, retornamos uma lista de conversores, além do nosso objeto _MappingJackson2HttpMessageConverter_ contendo nossas classes de serialização e desserialização, também retornamos StringHttpMessageConverter que é responsável por tratar apenas Strings e também FormHttpMessageConverter que é responsável por tratar a conversão de conteúdos HTML, esses últimos conversores são necessariamente precisam estar configuramos, fica como um bônus.

```java
import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.time.LocalDate;
import java.util.List;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

    private final ObjectMapper objectMapper;

    public WebConfig(ObjectMapper objectMapper) {
		this.objectMapper = objectMapper;
	}

    private MappingJackson2HttpMessageConverter customJackson2HttpJsonMessageConverter() {
        SimpleModule module = new SimpleModule("blog", Version.unknownVersion());
		module.addSerializer(LocalDate.class, new LocalDateSerializer());
		module.addDeserializer(LocalDate.class, new LocalDateDeserializer());
		objectMapper.registerModule(module);

		MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
		converter.setObjectMapper(objectMapper);
		return converter;
	}

    @Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		converters.add(new StringHttpMessageConverter());
		converters.add(customJackson2HttpJsonMessageConverter());
		converters.add(new FormHttpMessageConverter());
	}

}
```

Agora toda requisição que tenha objetos do tipo _LocalDate_ sendo trafegados, e que o _content-type_ for definido como _application/json_, os conversores do Jackson passaram a chamar nossas implementações.
', '<div class="paragraph">
<p>Em ciência da computação, no contexto de armazenamento e transmissão de dados, serialização é o processo de tradução de estruturas de dados ou estado de objeto em um formato que possa ser armazenado e reconstruído posteriormente no mesmo ou em outro ambiente computacional.</p>
</div>
<div class="paragraph">
<p>O Spring Boot por padrão utiliza a biblioteca Jackson para serialização e desserialização de objetos Java para Json. Tanto o Spring como biblioteca Jackson nos permite configurar módulos para customizar toda e qualquer serialização e desserialização de nossos objetos.</p>
</div>
<div class="paragraph">
<p>Como exemplo vamos implementar uma serialização e desserialização para objetos do tipo LocalDate.</p>
</div>
<div class="paragraph">
<p>Primeiramente vamos criar uma classe responsável pela serialização, vamos chama-la de <em>LocalDateSerializer</em>, ela deve extender <em>JsonSerializer</em> e passar como tipagem o objeto LocalDate. Ao extender a classe <em>LocalDateSerializer</em> somos obrigados a implementar o método <em>serialize</em>, nesse método devemos ser capazes de transformar um objeto Java em uma String, como a tipagem informada é LocalDate, receberemos um objeto desse tipo por parâmetro, então vamos formata-lo para o padrão <em>ISO_LOCAL_DATE (yyyy-MM-dd)</em>;</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class LocalDateSerializer extends JsonSerializer&lt;LocalDate&gt; {

    @Override
    public void serialize(LocalDate value, JsonGenerator generator, SerializerProvider serializers) throws IOException {
        String formattedDate = value.format(DateTimeFormatter.ISO_LOCAL_DATE);
        generator.writeString(formattedDate);
    }

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Nessa segunda etapa vamos criar uma classe responsavel pela desserialização, então vamos chamala de <em>LocalDateDeserializer</em>, esta classe vai extender <em>JsonDeserializer</em> e passar como tipagem o objeto LocalDate. Ao extender a classe <em>JsonDeserializer</em> somos obrigados a implementar o método <em>deserialize</em>, nesse método devemos ser capazes de transformar uma String em um Objeto Java, como a tipagem informada é LocalDate, devemos converter uma String em LocalDate, para isso vamos dar um parse no objeto LocalDate passando por parâmetro o valor recebido em String e o formato <em>ISO_LOCAL_DATE (yyyy-MM-dd)</em>;</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class LocalDateDeserializer extends JsonDeserializer&lt;LocalDate&gt; {

    @Override
    public LocalDate deserialize(JsonParser parser, DeserializationContext context) throws IOException {
        String value = parser.getValueAsString();
        return LocalDate.parse(value, DateTimeFormatter.ISO_LOCAL_DATE);
    }

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Em nossa última etapa vamos configurar o Jackson e também o Spring, para que eles facam uso dos nossos novos conversores. Para isso vamos criar uma classe chamada <em>WebConfig</em> que implementa <em>WebMvcConfigurer</em>, nessa classe vamos sobrescrever o método <em>configureMessageConverters</em>, este método recebe uma lista de classes responsáveis por converterem objetos dependendo do formato da saida escolhido na requisição.</p>
</div>
<div class="paragraph">
<p>Vamos olhar com mais cuidado para essa classe a seguir, vejamos que ela recebe um objeto do tipo ObjectMapper pelo construtor, esse objeto é um bean criado pelo Spring, ele fornece funcionalidades para leitura e gravação de JSON, de e para POJOs (Plain Old Java Objects). Devemos injetar esse objeto pois ele é a base para a nossa configuração.</p>
</div>
<div class="paragraph">
<p>Agora observe a implementação do método <em>customJackson2HttpJsonMessageConverter</em>, nesse método criamos um novo modulo Jackson, e nesse modulo adicionamos nossas classes criadas anteriormente, depois registramos o modulo no ObjectMapper e por fim instanciámos um objeto do tipo <em>MappingJackson2HttpMessageConverter</em> atribuindo o ObjectMapper alterado por parâmetro.</p>
</div>
<div class="paragraph">
<p>No método <em>configureMessageConverters</em> que sobrescrevemos, retornamos uma lista de conversores, além do nosso objeto <em>MappingJackson2HttpMessageConverter</em> contendo nossas classes de serialização e desserialização, também retornamos StringHttpMessageConverter que é responsável por tratar apenas Strings e também FormHttpMessageConverter que é responsável por tratar a conversão de conteúdos HTML, esses últimos conversores são necessariamente precisam estar configuramos, fica como um bônus.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.time.LocalDate;
import java.util.List;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

    private final ObjectMapper objectMapper;

    public WebConfig(ObjectMapper objectMapper) {
		this.objectMapper = objectMapper;
	}

    private MappingJackson2HttpMessageConverter customJackson2HttpJsonMessageConverter() {
        SimpleModule module = new SimpleModule("blog", Version.unknownVersion());
		module.addSerializer(LocalDate.class, new LocalDateSerializer());
		module.addDeserializer(LocalDate.class, new LocalDateDeserializer());
		objectMapper.registerModule(module);

		MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
		converter.setObjectMapper(objectMapper);
		return converter;
	}

    @Override
	public void configureMessageConverters(List&lt;HttpMessageConverter&lt;?&gt;&gt; converters) {
		converters.add(new StringHttpMessageConverter());
		converters.add(customJackson2HttpJsonMessageConverter());
		converters.add(new FormHttpMessageConverter());
	}

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Agora toda requisição que tenha objetos do tipo <em>LocalDate</em> sendo trafegados, e que o <em>content-type</em> for definido como <em>application/json</em>, os conversores do Jackson passaram a chamar nossas implementações.</p>
</div>');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 12, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 12, 1);
