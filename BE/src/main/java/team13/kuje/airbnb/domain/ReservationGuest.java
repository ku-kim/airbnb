package team13.kuje.airbnb.domain;

import lombok.Getter;

@Getter
public class ReservationGuest {

	private final Integer adults;
	private Integer children;
	private Integer infants;
	private Long headCount;
	private boolean isEmptyAdults;

	public ReservationGuest(Integer adults, Integer children, Integer infants) {
		this.adults = initAdults(adults);
		if (isEmptyAdults) {
			return;
		}
		this.children = initKids(children);
		this.infants = initKids(infants);
		this.headCount = (long) (this.adults + this.children);
	}

	private int initAdults(Integer adults) {
		return validateAdults(adults);
	}

	private int initKids(Integer kids) {
		int numberOfKids = validateKids(kids);
		validatePositiveNumber(numberOfKids);
		return numberOfKids;
	}

	private int validateAdults(Integer adults) {
		if (adults == null) {
			this.isEmptyAdults = true;
			return 0;
		}

		if (adults < 1) {
			throw new IllegalArgumentException("adults가 유효하지 않습니다.");
		}
		this.isEmptyAdults = false;
		return adults;
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
