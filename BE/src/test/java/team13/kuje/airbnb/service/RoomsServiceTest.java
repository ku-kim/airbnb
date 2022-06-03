package team13.kuje.airbnb.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import javax.persistence.EntityManager;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlGroup;
import org.springframework.transaction.annotation.Transactional;
import team13.kuje.airbnb.controller.model.RoomDetailDto;
import team13.kuje.airbnb.domain.Host;
import team13.kuje.airbnb.domain.Room;
import team13.kuje.airbnb.domain.RoomImage;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("EventService 클래스")
@SpringBootTest
@Transactional
class RoomsServiceTest {

	@Autowired
	RoomsService roomsService;

	@Autowired
	EntityManager em;

	@Test
	void 유효한_숙소ID로_숙소를_조회하면_숙소_디테일_조회_DTO를_반환한다() {
		Room saveRoom = initSaveRoom();

		RoomDetailDto result = roomsService.findById(saveRoom.getId(),
			LocalDateTime.of(2022, 6, 1, 0, 0),
			LocalDateTime.of(2022, 6, 3, 0, 0),
			3, 1, 0);

		assertThat(result.getId()).isEqualTo(saveRoom.getId());
	}

	private Room initSaveRoom() {

		RoomImage roomImage1 = RoomImage.createBy("http://test1.com");
		RoomImage roomImage2 = RoomImage.createBy("http://test2.com");
		Host host = Host.of("쿠킴", "http://test.com");
		Room room = Room.of("숙소A", "설명A", "서울시 송파구 xx-xx", 3, 3, 3, 3, 10000, 5000, 3000,
			10, 10, 10, 4.5f);

		room.updateHost(host);
		em.persist(roomImage1);
		em.persist(roomImage2);

		room.updateImages(roomImage1, roomImage2);
		em.persist(room);

		em.flush();
		em.clear();

		return room;
	}
}
