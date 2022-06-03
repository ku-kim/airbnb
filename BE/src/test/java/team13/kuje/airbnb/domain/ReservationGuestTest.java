package team13.kuje.airbnb.domain;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("ReservationGuest 클래스")
class ReservationGuestTest {

	@Nested
	@DisplayName("생성자")
	class Describe_constructor {

		@Nested
		@DisplayName("만약 성인:2, 아이:null, 신생아:null 주어진 경우")
		class Context_with_two_adults {

			@Test
			@DisplayName("성인:2, 아이:0, 신생아:0 객체를 반환한다.")
			void It_return_object() {
				ReservationGuest result = new ReservationGuest(2, null, null);

				assertThat(result.getAdults()).isEqualTo(2);
				assertThat(result.getChildren()).isEqualTo(0);
				assertThat(result.getInfants()).isEqualTo(0);

			}
		}

		@Nested
		@DisplayName("만약 성인:2, 아이:1, 신생아:1 주어진 경우")
		class Context_with_two_adults_and_one_child_one_infant {

			@Test
			@DisplayName("성인:2, 아이:1, 신생아:1 객체를 반환한다.")
			void It_return_object() {
				ReservationGuest result = new ReservationGuest(2, 1, 1);

				assertThat(result.getAdults()).isEqualTo(2);
				assertThat(result.getChildren()).isEqualTo(1);
				assertThat(result.getInfants()).isEqualTo(1);

			}
		}

		@Nested
		@DisplayName("만약 성인:2, 아이:-1, 신생아:1 주어진 경우")
		class Context_with_two_adults_and_minus_one_child_one_infant {

			@Test
			@DisplayName("예외를 반환한다.")
			void It_throw_exception() {
				assertThatThrownBy(() -> new ReservationGuest(2, -1, 1))
					.isInstanceOf(IllegalArgumentException.class);
			}
		}

		@Nested
		@DisplayName("만약 성인:0, 아이:2, 신생아:2 주어진 경우")
		class Context_with_zero_adults_and_two_children_two_infant {

			@Test
			@DisplayName("예외를 반환한다.")
			void It_throw_exception() {
				assertThatThrownBy(() -> new ReservationGuest(0, 2, 2))
					.isInstanceOf(IllegalArgumentException.class);
			}
		}

		@Nested
		@DisplayName("만약 성인:null, 아이:2, 신생아:2 주어진 경우")
		class Context_with_empty_adults_and_two_children_two_infant {

			@Test
			@DisplayName("예외를 반환한다.")
			void it_return_object() {
				ReservationGuest result = new ReservationGuest(null, 2, 2);

				assertThat(result.isEmptyAdults()).isTrue();

			}
		}
	}

}
