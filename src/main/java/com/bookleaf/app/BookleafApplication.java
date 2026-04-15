package com.bookleaf.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.Bean;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.JdbcTemplate;


@SpringBootApplication
@ServletComponentScan
public class BookleafApplication {

	public static void main(String[] args) {
		SpringApplication.run(BookleafApplication.class, args);
		System.out.println("===============================================");
		System.out.println("  BookLeaf is running at http://localhost:8080");
		System.out.println("===============================================");
	}

	@Bean
	CommandLineRunner run(JdbcTemplate jdbcTemplate) {
		return args -> {
			try {
				jdbcTemplate.execute("ALTER TABLE orders MODIFY COLUMN order_status VARCHAR(50)");
				System.out.println("Database auto-migrated: order_status is now VARCHAR(50).");
			} catch (Exception e) {
				System.out.println("Auto-migration note: " + e.getMessage());
			}
		};
	}
}
