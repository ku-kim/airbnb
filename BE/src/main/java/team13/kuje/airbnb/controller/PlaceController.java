package team13.kuje.airbnb.controller;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import team13.kuje.airbnb.controller.model.PlaceDto;
import team13.kuje.airbnb.controller.model.WrapperDtoList;
import team13.kuje.airbnb.service.PlaceService;

@RestController
@RequestMapping("/api/place")
@RequiredArgsConstructor
public class PlaceController {

	private final PlaceService placeService;

	@GetMapping
	public WrapperDtoList<PlaceDto> findByPosition(
		@RequestParam(value = "category_tag") String tag,
		@RequestParam(required = false) Double lat,
		@RequestParam(required = false) Double lng
		) {
		List<PlaceDto> placeDtos = placeService.findByPosition(tag, lat, lng);
		return new WrapperDtoList<>(placeDtos);
	}

}
