package com.programacion.app.config;

import java.util.Collections;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerAdapter;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.webflow.config.AbstractFlowConfiguration;
import org.springframework.webflow.definition.registry.FlowDefinitionRegistry;
import org.springframework.webflow.engine.builder.support.FlowBuilderServices;
import org.springframework.webflow.executor.FlowExecutor;
import org.springframework.webflow.mvc.builder.MvcViewFactoryCreator;
import org.springframework.webflow.mvc.servlet.FlowController;
import org.springframework.webflow.mvc.servlet.FlowHandlerAdapter;
import org.springframework.webflow.mvc.servlet.FlowHandlerMapping;

@Configuration
public class WebFlowConfig extends AbstractFlowConfiguration {
	
	@Bean
	public FlowDefinitionRegistry flowRegistry() {
		return getFlowDefinitionRegistryBuilder()
			.setBasePath("/WEB-INF/jsp/flujo/")
			.addFlowLocation("mapa.xml", "sistemaComercial")
			.build();
	}
	
	@Bean
	public FlowExecutor flowExecutor() {
		return getFlowExecutorBuilder(flowRegistry()).build();
	}
	
	@Bean
	public FlowController flowController() {
		FlowController controller = new FlowController();
		controller.setFlowExecutor(flowExecutor());
		return controller;
	}
	
	@Bean
	public FlowBuilderServices flowBuilderServices(MvcViewFactoryCreator viewFactoryCreator) {
		return getFlowBuilderServicesBuilder()
			.setViewFactoryCreator(viewFactoryCreator)
			.setDevelopmentMode(true)
			.build();
	}
	
	@Bean
	public MvcViewFactoryCreator viewFactoryCreator(
	@Qualifier("internalResourceViewResolver")  ViewResolver viewResolver) {
		MvcViewFactoryCreator factoryCreator = new MvcViewFactoryCreator();
		factoryCreator.setViewResolvers(Collections.singletonList(viewResolver));
		factoryCreator.setUseSpringBeanBinding(true);
		return factoryCreator;
	}
	
	@Bean
	public FlowHandlerMapping flowHandlerMapping() {
		FlowHandlerMapping handlerMapping = new FlowHandlerMapping();
		handlerMapping.setOrder(-1);
		handlerMapping.setFlowRegistry(flowRegistry());
		return handlerMapping;
	}
	
	@Bean
	public HandlerAdapter flowHandlerAdapter() {
		FlowHandlerAdapter handlerAdapter = new FlowHandlerAdapter();
		handlerAdapter.setFlowExecutor(flowExecutor());
		return handlerAdapter;
	}

}