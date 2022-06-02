package team13.kuje.airbnb.domain;

import lombok.Getter;

@Getter
public class ReservationGuest {

	private final Integer adults;
	private final Integer children;
	private final Integer infants;
	private final Long headCount;

	public ReservationGuest(Integer adults, Integer children, Integer infants) {
		this.adults = initAdults(adults);
		this.children = initKids(children);
		this.infants = initKids(infants);
		this.headCount = Long.valueOf(this.adults + this.children);
	}

	private int initAdults(Integer adults) {
		validateAdults(adults);
		return adults;
	}

	private int initKids(Integer kids) {
		int numberOfKids = validateKids(kids);
		validatePositiveNumber(numberOfKids);
		return numberOfKids;
	}

	private void validateAdults(Integer adults) {
		if (adults == null || adults < 1) {
			throw new IllegalArgumentException("adults가 유효하지 않습니다.");
		}
	}

	private int validateKids(Integer kids) {
		if (kids == null) {
			return 0;
		}
		return kids;
	}

	private void validatePositiveNumber(Integer guest) {
		if (guest < 0) {
			throw new IllegalArgumentException("Guest 멤버는 음수 값이 불가능합니다.");
		}
	}

}
