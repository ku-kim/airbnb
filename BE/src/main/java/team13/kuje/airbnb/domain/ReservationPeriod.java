package team13.kuje.airbnb.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import lombok.Getter;

@Getter
public class ReservationPeriod {

	private LocalDateTime checkIn;
	private LocalDateTime checkOut;
	private long dayCount;
	private boolean isEmpty;

	public ReservationPeriod(LocalDateTime checkIn, LocalDateTime checkOut) {
		validateNull(checkIn, checkOut);
		if (isEmpty) {
			return;
		}
		validateCheckInAndCheckOut(checkIn, checkOut);

		this.checkIn = checkIn;
		this.checkOut = checkOut;
		this.dayCount = ChronoUnit.DAYS.between(checkIn, checkOut);
	}

	private void validateNull(LocalDateTime checkIn, LocalDateTime checkOut) {
		if (checkIn == null || checkOut == null) {
			this.isEmpty = true;
			return;
		}
		this.isEmpty = false;
	}

	private void validateCheckInAndCheckOut(LocalDateTime checkIn, LocalDateTime checkOut) {
		LocalDate checkInDate = checkIn.toLocalDate();
		LocalDate checkOutDate = checkOut.toLocalDate();

		if (checkInDate.isAfter(checkOutDate) || checkInDate.isEqual(checkOutDate)) {
			throw new IllegalArgumentException("checkIn & checkOut이 유효하지 않은 입니다.");
		}
	}
}
