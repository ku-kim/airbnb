package team13.kuje.airbnb.login;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

@DisplayName("LoginControllerTest 클래스")
class LoginControllerTest {

	LoginController loginController = new LoginController();

	@Test
	void name() {

		loginController.afterLogin("");

	}
}
