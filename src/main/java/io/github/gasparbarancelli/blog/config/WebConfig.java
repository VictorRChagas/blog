package io.github.gasparbarancelli.blog.config;

import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

	private final ObjectMapper objectMapper;

	public WebConfig(ObjectMapper objectMapper) {
		this.objectMapper = objectMapper;
	}

	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**")
			.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "HEAD", "TRACE", "CONNECT");
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(
				"/img/**",
				"/css/**",
				"/js/**")
				.addResourceLocations(
						"classpath:static/img/",
						"classpath:static/css/",
						"classpath:static/js/");
	}

	private MappingJackson2HttpMessageConverter customJackson2HttpMessageConverter() {
		var module = new SimpleModule("blog", Version.unknownVersion());
		objectMapper.registerModule(module);
		var converter = new MappingJackson2HttpMessageConverter();
		converter.setObjectMapper(objectMapper);
		return converter;
	}

	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		converters.add(new StringHttpMessageConverter());
		converters.add(customJackson2HttpMessageConverter());
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
