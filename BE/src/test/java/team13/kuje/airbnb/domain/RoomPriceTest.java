package team13.kuje.airbnb.domain;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.time.LocalDateTime;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

@DisplayName("RoomPrice 클래스")
class RoomPriceTest {


	@Nested
	@DisplayName("생성자")
	class Describe_constructor {

		@Nested
		@DisplayName("만약 정상적인 ReservationPeriod와 RoomPriceInfo가 주어졌을 때")
		class Context_with_normal_lat_lng {

			@Test
			@DisplayName("요금을 계산한 상태를 가진 객체를 반환한다.")
			void It_return_object() {
				ReservationPeriod reservationPeriod = new ReservationPeriod(
					LocalDateTime.of(2022, 6, 1, 0, 0),
					LocalDateTime.of(2022, 6, 3, 0, 0));
				RoomPriceInfo roomPriceInfo = RoomPriceInfo.of(50000, 5000, 3000, 10, 10);

				RoomPrice roomPrice = RoomPrice.of(reservationPeriod, roomPriceInfo);

				SoftAssertions softAssertions = new SoftAssertions();
				softAssertions.assertThat(roomPrice.getTotalOriginalPrice()).isEqualTo(100000L);
				softAssertions.assertThat(roomPrice.getSavedPrice()).isEqualTo(10000L);
				softAssertions.assertThat(roomPrice.getLodgingTax()).isEqualTo(300L);
				softAssertions.assertThat(roomPrice.getFixedTotalPrice()).isEqualTo(98300L);
				softAssertions.assertThat(roomPrice.getFixedDailyPrice()).isEqualTo(49150L);
				softAssertions.assertAll();
			}
		}

		@Test
		@DisplayName("요금을 계산한 상태를 가진 객체를 반환한다.")
		void It_return_object2() {
			ReservationPeriod reservationPeriod = new ReservationPeriod(
				LocalDateTime.of(2022, 6, 1, 0, 0),
				LocalDateTime.of(2022, 6, 4, 0, 0));
			RoomPriceInfo roomPriceInfo = RoomPriceInfo.of(123456, 2000, 1000, 13, 12);

			RoomPrice roomPrice = RoomPrice.of(reservationPeriod, roomPriceInfo);

			SoftAssertions softAssertions = new SoftAssertions();
			softAssertions.assertThat(roomPrice.getTotalOriginalPrice()).isEqualTo(370368L);
			softAssertions.assertThat(roomPrice.getSavedPrice()).isEqualTo(48147L);
			softAssertions.assertThat(roomPrice.getLodgingTax()).isEqualTo(120L);
			softAssertions.assertThat(roomPrice.getFixedTotalPrice()).isEqualTo(325341L);
			softAssertions.assertThat(roomPrice.getFixedDailyPrice()).isEqualTo(108447L);
			softAssertions.assertAll();
		}
	}
}
