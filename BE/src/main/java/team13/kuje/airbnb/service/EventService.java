package team13.kuje.airbnb.service;

import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import team13.kuje.airbnb.controller.model.EventDto;
import team13.kuje.airbnb.domain.Event;
import team13.kuje.airbnb.repository.EventRepository;

@Service
@RequiredArgsConstructor
public class EventService {

	private final EventRepository eventRepository;

	@Transactional(readOnly = true)
	public List<EventDto> findByCategoryTag(String tag) {
		validateTag(tag);

		List<Event> events = eventRepository.findByCategoryTag(tag);

		return events.stream().map(EventDto::new)
			.collect(Collectors.toList());
	}

	private void validateTag(String tag) {
		if (tag.equals("main") || tag.equals("list")) {
			return;
		}

		throw new IllegalArgumentException("유효하지 않은 category_tag 입니다.");
	}

}
