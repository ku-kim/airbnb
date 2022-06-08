package team13.kuje.airbnb.controller;

import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import team13.kuje.airbnb.controller.model.RoomDetailDto;
import team13.kuje.airbnb.controller.model.RoomDto;
import team13.kuje.airbnb.controller.model.RoomHistogramDto;
import team13.kuje.airbnb.controller.model.WrapperDto;
import team13.kuje.airbnb.service.RoomsService;

@RestController
@RequestMapping("/api/rooms")
@RequiredArgsConstructor
public class RoomsController {

	private final RoomsService roomsService;

	@GetMapping("/{id}")
	public WrapperDto<RoomDetailDto> findById(
		@PathVariable Long id,
		@RequestParam(value = "check_in", required = false) @DateTimeFormat(iso = ISO.DATE_TIME) LocalDateTime checkIn,
		@RequestParam(value = "check_out", required = false) @DateTimeFormat(iso = ISO.DATE_TIME) LocalDateTime checkOut,
		@RequestParam(value = "adults", required = false) Integer adults,
		@RequestParam(value = "children", required = false) Integer children,
		@RequestParam(value = "infants", required = false) Integer infants
	) {
		RoomDetailDto roomsDetailDto = roomsService.findById(id, checkIn, checkOut, adults,	children, infants);
		return new WrapperDto<>(roomsDetailDto);
	}

	@GetMapping
	public WrapperDto findPriceHistogramByPosition(
		@RequestParam(value = "category_tag") String tag,
		@RequestParam(value = "lat", required = false) Double lat,
		@RequestParam(value = "lng", required = false) Double lng,
		@RequestParam(value = "check_in", required = false) @DateTimeFormat(iso = ISO.DATE_TIME) LocalDateTime checkIn,
		@RequestParam(value = "check_out", required = false) @DateTimeFormat(iso = ISO.DATE_TIME) LocalDateTime checkOut,
		@RequestParam(value = "adults", required = false) Integer adults,
		@RequestParam(value = "children", required = false) Integer children,
		@RequestParam(value = "infants", required = false) Integer infants,
		@RequestParam(value = "price_min", required = false) Long minDailyPrice,
		@RequestParam(value = "price_max", required = false) Long maxDailyPrice,
		@RequestParam(value = "page", required = false) Integer page,
		@RequestParam(value = "limit", required = false) Integer limit,
		@RequestParam(value = "total_room", required = false) Integer cachedCount
	) {
		if (tag.equals("histogram")) {
			RoomHistogramDto roomHistogramDto = roomsService.findPriceHistogramByPosition(tag, lat,	lng);
			return new WrapperDto<>(roomHistogramDto);
		}

		if (tag.equals("list")) {
			Page<RoomDto> roomDtos = roomsService.findRoomsBy(lat, lng, checkIn, checkOut, adults, children, infants, minDailyPrice, maxDailyPrice,
				page, limit, cachedCount);
			return new WrapperDto<>(roomDtos);
		}

		throw new IllegalStateException();
	}

}
