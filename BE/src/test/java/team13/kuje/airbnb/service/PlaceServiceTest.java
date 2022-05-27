package team13.kuje.airbnb.service;

import java.util.List;
import javax.persistence.EntityManager;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import team13.kuje.airbnb.controller.model.PlaceDto;
import team13.kuje.airbnb.domain.Place;
import team13.kuje.airbnb.domain.Position;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@DisplayName("PlaceService 클래스")
@SpringBootTest
@Transactional
class PlaceServiceTest {

	@Autowired
	PlaceService placeService;

	@Autowired
	private EntityManager em;

	@BeforeEach
	void setUp() {
		em.persist(new Place(null, "서울1", "url", new Position(37.5666805, 126.9784147)));
		em.persist(new Place(null, "서울2", "url", new Position(37.6666805, 126.7784147)));
		em.persist(new Place(null, "서울3", "url", new Position(37.8666805, 127.9784147)));
		em.persist(new Place(null, "독도", "url", new Position(35., 125.)));
		em.persist(new Place(null, "중국", "url", new Position(35., 123.)));
		em.persist(new Place(null, "뉴욕", "url", new Position(-37.8666805, -127.9784147)));


		em.flush();
		em.clear();
	}

	@Test
	void 만약_유효하지_않은_태그가_요청되면_예외가_반환된다() {
		assertThatThrownBy(() -> placeService.findByPosition("error_tag", 36., 127.))
			.isInstanceOf(IllegalArgumentException.class);
	}

	@Test
	void 정상적인_요청이_들어오면_현재위치_기준_인기여행지리스트가_반환된다() {
		List<PlaceDto> result = placeService.findByPosition("map", 37., 127.);

		assertThat(result).hasSize(4);
	}

}
