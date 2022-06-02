package team13.kuje.airbnb.domain;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Room {

	@Id
	@GeneratedValue
	@Column(name = "ROOM_ID")
	private Long id;

	private String title;
	private String description;
	private String address;
	private int headerCountCapacity;
	private int bedCount;
	private int bedroomCount;
	private int bathroomCount;

	@Embedded
	private RoomPriceInfo roomPriceInfo;

	@Transient
	private RoomPrice roomPrice;

	@OneToMany(mappedBy = "room")
	private List<RoomImage> images = new ArrayList<>();

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "HOST_ID")
	private Host host;

	private int reviewCount ;
	private float ratingStarScore;

	public static Room of(String title, String description, String address, int headerCountCapacity,
		int bedCount, int bedroomCount, int bathroomCount, long dailyPrice, long cleaningFee,
		long serviceFee, long saleRatio, long lodgingTaxRatio,
		int reviewCount, float ratingStarScore) {
		Room room = new Room();

		room.setTitle(title);
		room.setDescription(description);
		room.setAddress(address);
		room.setHeaderCountCapacity(headerCountCapacity);
		room.setBedCount(bedCount);
		room.setBedroomCount(bedroomCount);
		room.setBathroomCount(bathroomCount);
		room.roomPriceInfo = RoomPriceInfo.of(dailyPrice, cleaningFee, serviceFee, saleRatio,
			lodgingTaxRatio);
		room.setReviewCount(reviewCount);
		room.setRatingStarScore(ratingStarScore);
		return room;
	}

	public void updateImages(RoomImage... roomImages) {
		this.images = List.of(roomImages);

		for (RoomImage roomImage : roomImages) {
			roomImage.updateRoom(this);
		}
	}

	public void updateHost(Host host) {
		this.host = host;
		host.getRooms().add(this);
	}

	public void calculatePrice(ReservationPeriod reservationPeriod) {
		roomPrice = RoomPrice.of(reservationPeriod, roomPriceInfo);
	}
}
