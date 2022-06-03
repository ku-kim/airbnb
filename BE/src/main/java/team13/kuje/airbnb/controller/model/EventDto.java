package team13.kuje.airbnb.controller.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import team13.kuje.airbnb.domain.Event;

@AllArgsConstructor
@Getter
public class EventDto {

	private String title;
	private String description;
	private String imageUrl;

	public EventDto(Event event) {
		title = event.getTitle().replace("\\n", "\n");
		description = event.getDescription().replace("\\n", "\n");
		imageUrl = event.getImageUrl();
	}
}

