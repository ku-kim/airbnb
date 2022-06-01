package team13.kuje.airbnb.controller.model;

import java.util.List;
import lombok.Getter;
import team13.kuje.airbnb.domain.Room;

@Getter
public class RoomDetailDto {

	private final Long id;
	private final String title;
	private final List<String> imageUrls;
	private final String address;
	private final String hostName;
	private final String hostImageUrl;
	private final int headerCountCapacity;
	private final int bedCount;
	private final int bedroomCount;
	private final int bathroomCount;
	private final String description;
	private final long dailyPrice;
	private final long totalPrice;
	private final int reviewCount ;
	private final int ratingStarScore;

	public RoomDetailDto(Room room) {
		throw new UnsupportedOperationException("RoomDetailDto#RoomDetailDto 아직 구현하지 않음 :)");
	}
}
