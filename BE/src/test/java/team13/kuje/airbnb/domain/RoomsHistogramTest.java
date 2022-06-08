package team13.kuje.airbnb.domain;

import java.util.List;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("RoomsHistogram 클래스")
class RoomsHistogramTest {

	@Nested
	@DisplayName("생성자")
	class Describe_constructor {

		@Nested
		@DisplayName("만약 N개의 숙소리스트가 주어진다면")
		class Context_with_room_list {

			@Test
			@DisplayName("Histogram 정보를 가진 객체를 반환한다")
			void It_return_object() {
				List<Room> rooms = createRooms();

				RoomsHistogram roomsHistogram = RoomsHistogram.from(rooms);

				assertThat(roomsHistogram.getRoomsDailyPrice()).hasSize(3);
				assertThat(roomsHistogram.getAverage()).isEqualTo(426666.67);
			}
		}

	}

	private List<Room> createRooms() {
		List<RoomImage> roomImages = List.of(RoomImage.createBy("http://test1.com"),
			RoomImage.createBy("http://test2.com"));
		Host host = Host.of("쿠킴", "http://testHost1.com");
		Position position = new Position(37.1234, 127.1234);
		RoomPriceInfo roomPriceInfo = RoomPriceInfo.of(50000, 5000, 3000, 10, 10);
		Room room1 = Room.of("숙소A", "설명A", "서울시 송파구 A xx-xx", position, 3, 3, 3, 3,
			roomPriceInfo, roomImages, host, 10, 3.5f);

		List<RoomImage> roomImages2 = List.of(RoomImage.createBy("http://test3.com"),
			RoomImage.createBy("http://test4.com"));
		Host host2 = Host.of("제리", "http://testHost2.com");
		Position position2 = new Position(37.4321, 127.4321);
		RoomPriceInfo roomPriceInfo2 = RoomPriceInfo.of(30000, 3000, 1000, 10, 10);
		Room room2 = Room.of("숙소B", "설명B", "서울시 송파구 B xx-xx", position2, 3, 3, 3, 3,
			roomPriceInfo2, roomImages2, host2, 20, 3.7f);

		List<RoomImage> roomImages3 = List.of(RoomImage.createBy("http://test3.com"),
			RoomImage.createBy("http://test4.com"));
		Host host3 = Host.of("제리", "http://testHost2.com");
		Position position3 = new Position(37.4321, 127.4321);
		RoomPriceInfo roomPriceInfo3 = RoomPriceInfo.of(1200000, 3000, 1000, 10, 10);
		Room room3 = Room.of("숙소B", "설명B", "서울시 송파구 B xx-xx", position3, 3, 3, 3, 3,
			roomPriceInfo3, roomImages3, host3, 20, 3.7f);

		return List.of(room1, room2, room3);
	}

}
