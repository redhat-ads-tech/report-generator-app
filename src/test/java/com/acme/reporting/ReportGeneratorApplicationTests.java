package com.acme.reporting;

import com.acme.reporting.model.User;
import com.acme.reporting.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class ReportGeneratorApplicationTests {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    @Autowired
    private UserRepository userRepository;

    @Test
    public void contextLoads() {
        assertThat(restTemplate).isNotNull();
        assertThat(userRepository).isNotNull();
    }

    @Test
    public void testGetAllUsers() {
        User[] users = this.restTemplate.getForObject("http://localhost:" + port + "/api/users", User[].class);
        assertThat(users).isNotNull();
    }

    @Test
    public void testCreateUser() {
        User newUser = new User("Test User", "test.user@example.com");

        User createdUser = this.restTemplate.postForObject(
            "http://localhost:" + port + "/api/users",
            newUser,
            User.class
        );

        assertThat(createdUser).isNotNull();
        assertThat(createdUser.getName()).isEqualTo("Test User");
        assertThat(createdUser.getEmail()).isEqualTo("test.user@example.com");
    }
}
