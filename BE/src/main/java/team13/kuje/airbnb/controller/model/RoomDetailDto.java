package team13.kuje.airbnb.controller.model;

import java.util.List;
import java.util.stream.Collectors;
import lombok.Getter;
import team13.kuje.airbnb.domain.Room;
import team13.kuje.airbnb.domain.RoomImage;

@Getter
public class RoomDetailDto {

	private final Long id;
	private final String title;
	private final List<String> imageUrls;
	private final String address;
	private final String hostName;
	private final String hostImageUrl;
	private final int headCountCapacity;
	private final int bedCount;
	private final int bedroomCount;
	private final int bathroomCount;
	private final String description;
	private final long dailyPrice;
	private final int reviewCount;
	private final float ratingStarScore;
	private RoomDetailPriceDto roomDetailPriceDto;


	public RoomDetailDto(Room room, RoomDetailPriceDto roomDetailPriceDto) {
		this.id = room.getId();
		this.title = room.getTitle();
		this.imageUrls = room.getImages().stream()
			.map(RoomImage::getImageUrl)
			.collect(Collectors.toList());
		this.address = room.getAddress();
		this.hostName = room.getHost().getHostName();
		this.hostImageUrl = room.getHost().getHostImageUrl();
		this.headCountCapacity = room.getHeaderCountCapacity();
		this.bedCount = room.getBedCount();
		this.bedroomCount = room.getBedroomCount();
		this.bathroomCount = room.getBathroomCount();
		this.description = room.getDescription();
		this.dailyPrice = room.getDailyPrice();
		this.reviewCount = room.getReviewCount();
		this.ratingStarScore = room.getRatingStarScore();
		this.roomDetailPriceDto = roomDetailPriceDto;
	}
}
