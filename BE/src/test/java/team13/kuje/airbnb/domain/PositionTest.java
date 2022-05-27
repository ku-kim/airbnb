package team13.kuje.airbnb.domain;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

@DisplayName("PositionTest 클래스")
class PositionTest {

	@Nested
	@DisplayName("생성자")
	class Describe_constructor {

	    @Nested
	    @DisplayName("만약 정상적인 위경도가 주어진다면")
	    class Context_with_normal_lat_lng {

	        @Test
	        @DisplayName("위경도를 가지고 있는 객체를 반환한다")
	        void It_return_object() {
				Position position = new Position(36.12341234, 127.12341234);

				assertThat(position.getLat()).isEqualTo(36.12341234);
				assertThat(position.getLng()).isEqualTo(127.12341234);
			}
	    }

		@Nested
		@DisplayName("만약 위경도가 모두 주어지지 않는다면")
		class Context_with_empty_lat_and_lng {

			@Test
			@DisplayName("서울 시청 위경도를 가지고 있는 객체를 반환한다")
			void It_return_object() {
				Position position = new Position(null, null);

				assertThat(position.getLat()).isEqualTo(37.5666805);
				assertThat(position.getLng()).isEqualTo(126.9784147);
			}
		}

		@Nested
		@DisplayName("만약 위경도가 하나만 주어지지 않는다면")
		class Context_with_empty_lat_or_lng {

			@Test
			@DisplayName("예외를 발생시킨다.")
			void It_return_object() {
				assertThatThrownBy(() -> new Position(null, 127.1))
					.isInstanceOf(IllegalArgumentException.class);
			}
		}

		@Nested
		@DisplayName("만약 유효하지 않은 위경도가 주어진다면")
		class Context_with_invalid_lat_lng {

			@Test
			@DisplayName("예외를 발생시킨다.")
			void It_throw_Exception() {
				assertThatThrownBy(() -> new Position(-120.123, 300.))
					.isInstanceOf(IllegalArgumentException.class);
			}
		}

	}
}
