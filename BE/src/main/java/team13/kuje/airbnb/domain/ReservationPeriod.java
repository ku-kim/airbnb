package team13.kuje.airbnb.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import lombok.Getter;

@Getter
public class ReservationPeriod {

	private final LocalDateTime checkIn;
	private final LocalDateTime checkOut;
	private final long dayCount;

	public ReservationPeriod(LocalDateTime checkIn, LocalDateTime checkOut) {
		validateNull(checkIn, checkOut);
		validateCheckInAndCheckOut(checkIn, checkOut);

		this.checkIn = checkIn;
		this.checkOut = checkOut;
		this.dayCount = ChronoUnit.DAYS.between(checkIn, checkOut);
	}

	private void validateNull(LocalDateTime checkIn, LocalDateTime checkOut) {
		if (checkIn == null || checkOut == null) {
			throw new IllegalArgumentException("checkIn & checkOut이 유효하지 않은 입니다.");
		}
	}

	private void validateCheckInAndCheckOut(LocalDateTime checkIn, LocalDateTime checkOut) {
		LocalDate checkInDate = checkIn.toLocalDate();
		LocalDate checkOutDate = checkOut.toLocalDate();

		if (checkInDate.isAfter(checkOutDate) || checkInDate.isEqual(checkOutDate)) {
			throw new IllegalArgumentException("checkIn & checkOut이 유효하지 않은 입니다.");
		}
	}

	public long getDayCount() {
		return dayCount;
	}
}
