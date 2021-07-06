package org.hango.cloud.ncegdashboard;

import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.support.config.FastJsonConfig;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.web.HttpMessageConverters;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ImportResource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.util.ArrayList;
import java.util.List;

/**
 * @Date: 创建时间: 2017/12/4 上午10:33.
 */
@SpringBootApplication
@EnableScheduling
@ImportResource("classpath:applicationContext.xml")
@PropertySource("classpath:gdashboard-jdbc.properties")
public class DashboardApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(DashboardApplication.class, args);
	}

	@Bean
	public HttpMessageConverters fastJsonHttpMessageConverters() {
		// 1.定义一个converters转换消息的对象
		FastJsonHttpMessageConverter fastConverter = new FastJsonHttpMessageConverter();
		List<MediaType> supportedMediaTypes = new ArrayList<>();
		supportedMediaTypes.add(MediaType.APPLICATION_JSON);
		supportedMediaTypes.add(MediaType.APPLICATION_JSON_UTF8);
		fastConverter.setSupportedMediaTypes(supportedMediaTypes);
		// 2.添加fastjson的配置信息，比如: 是否需要格式化返回的json数据
		FastJsonConfig fastJsonConfig = new FastJsonConfig();
		fastJsonConfig.setSerializerFeatures(SerializerFeature.PrettyFormat, SerializerFeature.UseSingleQuotes);
		// 3.在converter中添加配置信息
		fastConverter.setFastJsonConfig(fastJsonConfig);
		// 4.将converter赋值给HttpMessageConverter
		HttpMessageConverter<?> converter = fastConverter;
		// 5.返回HttpMessageConverters对象
		return new HttpMessageConverters(converter);
	}

}