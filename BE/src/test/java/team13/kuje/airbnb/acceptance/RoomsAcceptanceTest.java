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
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlGroup;


/**
 * 특정 id의 숙소에 대한 디테일 정보를 조회할 수 있게 해주세요
 * GET /rooms/{id}
 *
 * case 1 : 성공
 * 200 OK
 * JSON 타입
 * - 숙소 디테일 정보
 *
 * case 2 : 실패 - id가 유효하지 않은 경우
 * 400 BAD REQUEST
 */
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

}
