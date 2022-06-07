package team13.kuje.airbnb.controller.model;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Embedded;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import lombok.Getter;
import team13.kuje.airbnb.domain.Host;
import team13.kuje.airbnb.domain.Position;
import team13.kuje.airbnb.domain.Room;
import team13.kuje.airbnb.domain.RoomImage;
import team13.kuje.airbnb.domain.RoomPriceInfo;

@Getter
public class RoomDto {

	private Long id;
	private String title;
	private String imageUrl;

	private Double lat;
	private Double lng;

	private Long dailyPrice;
	private int reviewCount ;
	private float ratingStarScore;

	public RoomDto(Room room) {
		this.id = room.getId();
		this.title = room.getTitle();
		this.imageUrl = initImageUrl(room);

		this.lat = room.getPosition().getLat();
		this.lng = room.getPosition().getLng();
		this.dailyPrice = room.getRoomPriceInfo().getDailyPrice();
		this.reviewCount = room.getReviewCount();
		this.ratingStarScore = room.getRatingStarScore();
	}

	private String initImageUrl(Room room) {
		List<RoomImage> images = room.getImages();
		if (images.size() == 0) {
			return null;
		}
		return images.get(0).getImageUrl();
	}
}
