package team13.kuje.airbnb.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import team13.kuje.airbnb.controller.model.RoomDetailDto;
import team13.kuje.airbnb.controller.model.RoomDetailPriceDto;
import team13.kuje.airbnb.controller.model.RoomDto;
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

		return new RoomDetailDto(room, new RoomDetailPriceDto(room, reservationPeriod, reservationGuest));
	}

	public RoomHistogramDto findPriceHistogramByPosition(String tag, Double lat, Double lng) {
		validateTag(tag);

		Position inputPosition = new Position(lat, lng);

		List<Room> rooms = roomsRepository.findPriceHistogramByPosition(inputPosition, ANGLE_OF_SEARCH_RANGE);

		return new RoomHistogramDto(RoomsHistogram.from(rooms));
	}

	//todo 현재 이 메서드는 역할이 없음
	// controller에서 처리중임
	private void validateTag(String tag) {
		if (tag.equals("histogram")) {
			return;
		}
		throw new IllegalArgumentException("유효하지 않은 category_tag 입니다.");
	}

	public Page<RoomDto> findRoomsBy(Double lat, Double lng, LocalDateTime checkIn, LocalDateTime checkOut, Integer adults, Integer children, Integer infants, Long minDailyPrice,
		Long maxDailyPrice, Integer page, Integer limit, Integer cachedCount) {

		validatePageAndLimit(page, limit);
		Position inputPosition = new Position(lat, lng);
		ReservationPeriod inputReservationPeriod = new ReservationPeriod(checkIn, checkOut);
		ReservationGuest inputReservationGuest = new ReservationGuest(adults, children, infants);
		PageRequest pageable = PageRequest.of(page, limit);

		return roomsRepository.findRoomsBy(inputPosition, inputReservationPeriod, inputReservationGuest, minDailyPrice, maxDailyPrice, pageable, cachedCount);

	}

	private void validatePageAndLimit(Integer page, Integer limit) {
		if (page == null || limit == null) {
			throw new IllegalArgumentException("page, limit은 필수로 입력해야 합니다.");
		}
	}
}
