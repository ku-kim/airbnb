package team13.kuje.airbnb.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import team13.kuje.airbnb.controller.model.RoomDetailDto;
import team13.kuje.airbnb.controller.model.WrapperDto;
import team13.kuje.airbnb.service.RoomsService;

@RestController
@RequestMapping("/api/rooms")
@RequiredArgsConstructor
public class RoomsController {

	private final RoomsService roomsService;

	@GetMapping("/{id}")
	public WrapperDto<RoomDetailDto> findById(@PathVariable Long id) {
		RoomDetailDto roomsDetailDto = roomsService.findById(id);
		return new WrapperDto<>(roomsDetailDto);
	}

}
