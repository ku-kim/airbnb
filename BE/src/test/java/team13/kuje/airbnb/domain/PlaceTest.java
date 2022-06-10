package team13.kuje.airbnb.domain;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("Place 클래스")
class PlaceTest {


	@Test
	void 현재위치부터_현재위치까지의_도착시간_계산() {
		Place place = new Place(null, "서울", "url", new Position(37.5666805, 126.9784147));
		Position position = new Position(37.5666805, 126.9784147);

		int result = place.calculateTime(position);
		assertThat(result).isZero();
	}

	@Test
	void 서울시청부터_부산시청까지의_직선거리_도착시간_계산() {
		Place place = new Place(null, "서울", "url", new Position(37.5666805, 126.9784147));
		Position position = new Position(35.1799755, 129.0747944);

		int result = place.calculateTime(position);
		assertThat(result).isEqualTo(243);
	}

}
