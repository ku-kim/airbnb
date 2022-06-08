package team13.kuje.airbnb.service;

import java.time.LocalDateTime;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import team13.kuje.airbnb.controller.model.RoomDetailDto;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@DisplayName("RoomsService 클래스")
@SpringBootTest
@Transactional
class RoomsServiceTest {

	@Autowired
	RoomsService roomsService;

	@Test
	void 만약_유효한_숙소ID로_숙소를_조회하면_숙소_디테일_조회_DTO를_반환한다() {
		RoomDetailDto result = roomsService.findById(1L,
			LocalDateTime.of(2022, 6, 1, 0, 0),
			LocalDateTime.of(2022, 6, 3, 0, 0),
			3, 1, 0);

		assertThat(result.getId()).isEqualTo(1L);
	}

	@Test
	void 만약_존재하지않은_ID로_숙소를_조회하면_예외를발생한다() {
		assertThatThrownBy(() -> roomsService.findById(-99999L,
			LocalDateTime.of(2022, 6, 1, 0, 0),
			LocalDateTime.of(2022, 6, 3, 0, 0),
			3, 1, 0)).isInstanceOf(IllegalArgumentException.class);
	}
}
