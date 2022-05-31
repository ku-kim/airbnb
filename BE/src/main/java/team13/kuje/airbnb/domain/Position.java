package team13.kuje.airbnb.domain;

import javax.persistence.Embeddable;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Embeddable
@NoArgsConstructor
@Getter
public class Position {

	private static final Double SEOUL_CITY_HALL_LAT = 37.5666805;
	private static final Double SEOUL_CITY_HALL_LNG = 126.9784147;
	private static final Double MAX_LAT = 90.;
	private static final Double MIN_LAT = -90.;
	private static final Double MAX_LNG = 180.;
	private static final Double MIN_LNG = -180.;

	private Double lat;
	private Double lng;

	public Position(Double lat, Double lng) {
		if (lat == null && lng == null) {
			this.lat = SEOUL_CITY_HALL_LAT;
			this.lng = SEOUL_CITY_HALL_LNG;
			return;
		}
		validateRangeOfPosition(lat, lng);

		this.lat = lat;
		this.lng = lng;
	}

	private void validateRangeOfPosition(Double lat, Double lng) {
		if (lat == null || lng == null || lat < MIN_LAT || lat > MAX_LAT || lng < MIN_LNG || lng > MAX_LNG) {
			throw new IllegalArgumentException("lat, lng 데이터가 잘못되었습니다.");
		}
	}

}
