package team13.kuje.airbnb.domain;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDateTime;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

@DisplayName("RoomTest 클래스")
class RoomTest {

	@Test
	void name() {
		Room room = Room.of("숙소A", "설명A", "서울시 송파구 xx-xx", 3, 3, 3, 3, 10000, 5000, 3000,
			10, 10, 10, 4.5f);

		ReservationPeriod reservationPeriod = new ReservationPeriod(
			LocalDateTime.of(2022, 6, 1, 0, 0),
			LocalDateTime.of(2022, 6, 3, 0, 0));

		room.calculatePrice(reservationPeriod);



	}
}
