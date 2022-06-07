package team13.kuje.airbnb.service;

import java.time.LocalDateTime;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import team13.kuje.airbnb.controller.model.RoomDetailDto;
import team13.kuje.airbnb.controller.model.RoomDetailPriceDto;
import team13.kuje.airbnb.domain.ReservationGuest;
import team13.kuje.airbnb.domain.ReservationPeriod;
import team13.kuje.airbnb.domain.Room;
import team13.kuje.airbnb.repository.RoomsRepository;

@Service
@RequiredArgsConstructor
public class RoomsService {

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

}
