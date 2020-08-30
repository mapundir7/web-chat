package com.example.websocketdemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class WebsocketDemoApplication {
	
	

	public static void main(String[] args) {
		System.out.println("Hello we chat app starting...");
		SpringApplication.run(WebsocketDemoApplication.class, args);
		System.out.println("Hello we chat app started");
	}
}
