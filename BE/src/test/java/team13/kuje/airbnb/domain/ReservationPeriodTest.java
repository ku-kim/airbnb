package team13.kuje.airbnb.domain;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.time.LocalDateTime;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

@DisplayName("ReservationPeriod 클래스")
class ReservationPeriodTest {

	@Nested
	@DisplayName("생성자")
	class Describe_constructor {

		@Nested
		@DisplayName("만약 정상적인 체크인, 체크아웃 날짜가 주어졌을 때")
		class Context_with_normal_checkIn_checkOut {

			@Test
			@DisplayName("체크인, 체크아웃, dayCount를 가진 객체를 반환한다.")
			void It_return_object() {
				ReservationPeriod result = new ReservationPeriod(
					LocalDateTime.of(2022, 6, 1, 0, 0),
					LocalDateTime.of(2022, 6, 3, 0, 0));

				assertThat(result.getDayCount()).isEqualTo(2);
			}
		}

		@Nested
		@DisplayName("만약 동일한 날짜(day)의 체크인, 체크아웃 날짜가 주어졌을 때")
		class Context_with_checkIn_equal_to_checkOut {
			@Test
			@DisplayName("예외를 반환한다.")
			void It_throw_exception() {

				assertThatThrownBy(() -> new ReservationPeriod(
					LocalDateTime.of(2022, 6, 1, 0, 0),
					LocalDateTime.of(2022, 6, 1, 12, 0)))
					.isInstanceOf(IllegalArgumentException.class);
			}
		}

		@Nested
		@DisplayName("만약 체크인 또는 체크아웃이 널인 데이터가 주어졌을 때")
		class Context_with_null_checkIn_or_checkOut {

			@Test
			@DisplayName("예외를 반환한다.")
			void It_throw_exception1() {
				assertThatThrownBy(() -> new ReservationPeriod(
					null,
					LocalDateTime.of(2022, 6, 1, 0, 0)))
					.isInstanceOf(IllegalArgumentException.class);
			}

			@Test
			@DisplayName("예외를 반환한다.")
			void It_throw_exception2() {
				assertThatThrownBy(() -> new ReservationPeriod(
					LocalDateTime.of(2022, 6, 1, 0, 0),
					null))
					.isInstanceOf(IllegalArgumentException.class);
			}

			@Test
			@DisplayName("예외를 반환한다.")
			void It_throw_exception3() {
				assertThatThrownBy(() -> new ReservationPeriod(
					null,
					null))
					.isInstanceOf(IllegalArgumentException.class);
			}
		}

		@Nested
		@DisplayName("만약 체크인이 체크아웃 날짜보다 이른 데이터가 주어졌을 때")
		class Context_with_nonnormal_checkIn_checkOut {

			@Test
			@DisplayName("예외를 반환한다.")
			void It_throw_exception() {
				assertThatThrownBy(() -> new ReservationPeriod(
					LocalDateTime.of(2022, 6, 3, 0, 0),
					LocalDateTime.of(2022, 6, 1, 0, 0)))
					.isInstanceOf(IllegalArgumentException.class);
			}
		}

	}

}
