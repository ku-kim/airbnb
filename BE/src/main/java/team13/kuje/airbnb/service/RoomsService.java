package team13.kuje.airbnb.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import team13.kuje.airbnb.controller.model.RoomDetailDto;
import team13.kuje.airbnb.controller.model.RoomDetailPriceDto;
import team13.kuje.airbnb.controller.model.RoomHistogramDto;
import team13.kuje.airbnb.domain.Position;
import team13.kuje.airbnb.domain.ReservationGuest;
import team13.kuje.airbnb.domain.ReservationPeriod;
import team13.kuje.airbnb.domain.Room;
import team13.kuje.airbnb.domain.RoomsHistogram;
import team13.kuje.airbnb.repository.RoomsRepository;

@Service
@RequiredArgsConstructor
public class RoomsService {

	private static final int ANGLE_OF_SEARCH_RANGE = 2;

	private final RoomsRepository roomsRepository;

	public RoomDetailDto findById(Long id, LocalDateTime checkIn, LocalDateTime checkOut,
		Integer adults,	Integer children, Integer infants) {
		ReservationPeriod reservationPeriod = new ReservationPeriod(checkIn, checkOut);
		ReservationGuest reservationGuest = new ReservationGuest(adults, children, infants);

		Optional<Room> findRoom = roomsRepository.findById(id);
		Room room = findRoom.orElseThrow(
			() -> new IllegalArgumentException("조회한 Room ID는 존재하지 않습니다."));

		room.calculatePrice(reservationPeriod, reservationGuest);
		return new RoomDetailDto(room, new RoomDetailPriceDto(room));
	}

	public RoomHistogramDto findPriceHistogramByPosition(String tag, Double lat, Double lng) {
		validateTag(tag);

		Position inputPosition = new Position(lat, lng);

		List<Room> rooms = roomsRepository.findPriceHistogramByPosition(inputPosition, ANGLE_OF_SEARCH_RANGE);

		return new RoomHistogramDto(RoomsHistogram.from(rooms));
	}

	private void validateTag(String tag) {
		if (tag.equals("histogram")) {
			return;
		}
		throw new IllegalArgumentException("유효하지 않은 category_tag 입니다.");
	}
}
