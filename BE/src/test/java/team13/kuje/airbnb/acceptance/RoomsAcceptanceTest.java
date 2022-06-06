package team13.kuje.airbnb.acceptance;

import static io.restassured.RestAssured.given;
import static org.hamcrest.core.IsEqual.equalTo;

import io.restassured.RestAssured;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;

@DisplayName("Rooms API 테스트")
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class RoomsAcceptanceTest {

	@LocalServerPort
	int port;

	@BeforeEach
	void setUp() {
		RestAssured.port = port;
	}

	@Test
	void 만약_특정_id_주어진_경우_해당_숙소의_가격정보를_제외한_디테일_정보가_조회된다() {
		given()
			.accept(MediaType.APPLICATION_JSON_VALUE)

		.when()
			.get("/api/rooms/1")

		.then()
			.statusCode(HttpStatus.OK.value())
			.assertThat()
			.body("data.id", equalTo(1))
			.body("data.title", equalTo("제리네 집"))
			.body("data.hostName", equalTo("제리"))
			.body("data.reviewCount", equalTo(30))
			.body("data.roomDetailPriceDto.headCount", equalTo(null));
	}

	@Test
	void 만약_모든_정보가_주어진_경우_해당_숙소의_모든_디테일_정보가_조회된다() {
		given()
			.accept(MediaType.APPLICATION_JSON_VALUE)

		.when()
			.get("/api/rooms/2?check_in=2000-10-31T01:30:00.000-05:00&check_out=2000-11-01T01:30:00.000-05:00&adults=2&children=1&infants=1")

		.then()
			.statusCode(HttpStatus.OK.value())
			.assertThat()
			.body("data.id", equalTo(2))
			.body("data.title", equalTo("쿠킴네 집"))
			.body("data.hostName", equalTo("쿠킴"))
			.body("data.reviewCount", equalTo(30))
			.body("data.detailPrice.headCount", equalTo(3));
	}

	@Test
	void 만약_category_tag가_histogram이고_특정_위경도가_주어진_경우_근처의_가격정보를_조회한다() {
		given()
			.accept(MediaType.APPLICATION_JSON_VALUE)

		.when()
			.get("/api/rooms?category_tag=histogram&lat=37.1234&lng=127.1234")

		.then()
			.statusCode(HttpStatus.OK.value())
			.assertThat()
			.body("data.histogram[0].min", equalTo(0));
	}

}
