package team13.kuje.airbnb.controller;

import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import team13.kuje.airbnb.controller.model.RoomDetailDto;
import team13.kuje.airbnb.controller.model.RoomHistogramDto;
import team13.kuje.airbnb.controller.model.WrapperDto;
import team13.kuje.airbnb.service.RoomsService;

@RestController
@RequestMapping("/api/rooms")
@RequiredArgsConstructor
public class RoomsController {

	private final RoomsService roomsService;

	@GetMapping("/{id}")
	public WrapperDto<RoomDetailDto> findById(@PathVariable Long id,
		@RequestParam(value = "check_in", required = false) @DateTimeFormat(iso = ISO.DATE_TIME) LocalDateTime checkIn,
		@RequestParam(value = "check_out", required = false) @DateTimeFormat(iso = ISO.DATE_TIME) LocalDateTime checkOut,
		@RequestParam(value = "adults", required = false) Integer adults,
		@RequestParam(value = "children", required = false) Integer children,
		@RequestParam(value = "infants", required = false) Integer infants
	) {
		RoomDetailDto roomsDetailDto = roomsService.findById(id, checkIn, checkOut, adults,
			children, infants);
		return new WrapperDto<>(roomsDetailDto);
	}

	@GetMapping
	public WrapperDto<RoomHistogramDto> findPriceHistogramByPosition(
		@RequestParam(value = "category_tag") String tag,
		@RequestParam(required = false) Double lat,
		@RequestParam(required = false) Double lng
	) {
		RoomHistogramDto roomHistogramDto = roomsService.findPriceHistogramByPosition(tag, lat, lng);

		return new WrapperDto<>(roomHistogramDto);
	}

}
