package team13.kuje.airbnb.service;

import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import team13.kuje.airbnb.controller.model.RoomDetailDto;
import team13.kuje.airbnb.domain.Room;
import team13.kuje.airbnb.repository.RoomsRepository;

@Service
@RequiredArgsConstructor
public class RoomsService {

	private final RoomsRepository roomsRepository;

	public RoomDetailDto findById(Long id) {
		// id에 해당하는 숙소 검사

		// 조회
		Optional<Room> findRoom = roomsRepository.findById(id);


		// dto 변환
		return new RoomDetailDto(findRoom.get()); // TODO 수정해야함
	}
}
