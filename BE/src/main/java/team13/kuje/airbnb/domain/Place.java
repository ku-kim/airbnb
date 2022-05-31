package team13.kuje.airbnb.domain;

import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import team13.kuje.airbnb.util.MapUtils;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Place {

	public static final double AVERAGE_SPEED = 80.;
	public static final int HOUR_TO_MIN = 60;
	@Id
	@GeneratedValue
	private Long id;

	private String title;
	private String imageUrl;

	@Embedded
	private Position position;


	public int calculateTime(Position inputPosition) {
		double distance = MapUtils.calculateDistance(this.position.getLat(), this.position.getLng(),
			inputPosition.getLat(), inputPosition.getLng());

		return (int) ((distance / AVERAGE_SPEED) * HOUR_TO_MIN);
	}

}
