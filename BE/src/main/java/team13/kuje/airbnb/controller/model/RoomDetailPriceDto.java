package team13.kuje.airbnb.controller.model;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import team13.kuje.airbnb.domain.Room;

@AllArgsConstructor
@Getter
@Setter
public class RoomDetailPriceDto {

	private final LocalDateTime checkIn;
	private final LocalDateTime checkOut;
	private final Integer dayCount;
	private final Integer headCount;
	private final Long totalOriginalPrice;
	private final Long dailyOriginalPrice;
	private final Long saleRatio;
	private final Long savedPrice;
	private final Long cleanigFee;
	private final Long serviceFee;
	private final Long lodgingTaxRatio;
	private final Long lodgingTax;
	private final Long fixedDailyPrice;
	private final Long fixedTotalPrice;

	public RoomDetailPriceDto(Room room, LocalDateTime checkIn, LocalDateTime checkOut, int headCount) {
		this.checkIn = checkIn;
		this.checkOut = checkOut;
		this.dayCount = (int) ChronoUnit.DAYS.between(checkIn, checkOut);
		this.headCount = headCount;
		this.dailyOriginalPrice = room.getDailyPrice();
		this.totalOriginalPrice = dailyOriginalPrice * dayCount;
		this.saleRatio = room.getSaleRatio();
		this.savedPrice = (long) (totalOriginalPrice * saleRatio / 100f);
		this.cleanigFee = room.getCleaningFee();
		this.serviceFee = room.getServiceFee();
		this.lodgingTaxRatio = room.getLodgingTaxRatio();
		this.lodgingTax = (long) (serviceFee * lodgingTaxRatio / 100f);
		this.fixedTotalPrice = totalOriginalPrice - savedPrice + cleanigFee + serviceFee + lodgingTax;
		this.fixedDailyPrice = (long) (fixedTotalPrice / (float) dayCount);
	}
}
