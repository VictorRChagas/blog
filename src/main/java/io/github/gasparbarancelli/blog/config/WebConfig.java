package io.github.gasparbarancelli.blog.config;

import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.fasterxml.jackson.dataformat.xml.ser.ToXmlGenerator;
import io.github.gasparbarancelli.blog.ui.UserInterfaceInterceptor;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.http.CacheControl;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.converter.xml.MappingJackson2XmlHttpMessageConverter;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.resource.CssLinkResourceTransformer;
import org.springframework.web.servlet.resource.ResourceUrlEncodingFilter;
import org.springframework.web.servlet.resource.VersionResourceResolver;

import java.time.LocalDate;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

	private final ObjectMapper objectMapperJson;

	private final UserInterfaceInterceptor userInterfaceInterceptor;

	public WebConfig(ObjectMapper objectMapperJson, UserInterfaceInterceptor userInterfaceInterceptor) {
		this.objectMapperJson = objectMapperJson;
		this.userInterfaceInterceptor = userInterfaceInterceptor;
	}

	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**")
			.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "HEAD", "TRACE", "CONNECT");
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(userInterfaceInterceptor)
				.excludePathPatterns(
						"/img/**",
						"/css/**",
						"/js/**",
						"/webjars/**"
				);
	}

	@Bean
	public ResourceUrlEncodingFilter resourceUrlEncodingFilter() {
		return new ResourceUrlEncodingFilter();
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/**")
				.addResourceLocations(
						"classpath:/META-INF/resources/",
						"classpath:/resources/",
						"classpath:/static/",
						"/webjars/"
				)
				.setCacheControl(CacheControl.maxAge(365, TimeUnit.DAYS))
				.resourceChain(true)
				.addResolver(new VersionResourceResolver().addContentVersionStrategy("/**"))
				.addTransformer(new CssLinkResourceTransformer());
	}

	private MappingJackson2HttpMessageConverter customJackson2HttpJsonMessageConverter() {
		objectMapperJson.registerModule(getModule());
		MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
		converter.setObjectMapper(objectMapperJson);
		return converter;
	}

	private SimpleModule getModule() {
		SimpleModule module = new SimpleModule("blog", Version.unknownVersion());
		module.addSerializer(LocalDate.class, new LocalDateSerializer());
		module.addDeserializer(LocalDate.class, new LocalDateDeserializer());
		return module;
	}

	private MappingJackson2XmlHttpMessageConverter customJackson2HttpXmlMessageConverter() {
		XmlMapper xmlMapper = new XmlMapper();
		xmlMapper.registerModule(getModule());
		xmlMapper.configure(ToXmlGenerator.Feature.WRITE_XML_DECLARATION, true);
		MappingJackson2XmlHttpMessageConverter converter = new MappingJackson2XmlHttpMessageConverter();
		converter.setObjectMapper(xmlMapper);
		return converter;
	}

	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		converters.add(new StringHttpMessageConverter());
		converters.add(customJackson2HttpJsonMessageConverter());
		converters.add(customJackson2HttpXmlMessageConverter());
		converters.add(new FormHttpMessageConverter());
	}

	@Bean
	public MessageSource messageSource() {
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasename("classpath:i18n/messages");
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setCacheSeconds(3600);
		return messageSource;
	}

}
