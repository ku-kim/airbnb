package team13.kuje.airbnb.service;

import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import team13.kuje.airbnb.controller.model.PlaceDto;
import team13.kuje.airbnb.domain.Place;
import team13.kuje.airbnb.domain.Position;
import team13.kuje.airbnb.repository.PlaceRepository;

import static team13.kuje.airbnb.domain.Position.TWO_DEGREE;

@Service
@RequiredArgsConstructor
public class PlaceService {

	private final PlaceRepository placeRepository;

	@Transactional(readOnly = true)
	public List<PlaceDto> findByPosition(String tag, Double lat, Double lng) {
		validateTag(tag);

		Position inputPosition = new Position(lat, lng);

		List<Place> places = placeRepository.findByPosition(inputPosition, TWO_DEGREE);

		return places.stream()
			.map(p -> new PlaceDto(p, inputPosition))
			.collect(Collectors.toList());
	}

	private void validateTag(String tag) {
		if (tag.equals("map")) {
			return;
		}
		throw new IllegalArgumentException("유효하지 않은 category_tag 입니다.");
	}
}
