package team13.kuje.airbnb.controller.model;

import java.time.LocalDateTime;
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
	private final Long dayCount;
	private final Long headCount;
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

	public RoomDetailPriceDto(Room room,
		long headCount) {
		this.checkIn = room.getRoomPrice().getReservationPeriod().getCheckIn();
		this.checkOut = room.getRoomPrice().getReservationPeriod().getCheckOut();
		this.dayCount = room.getRoomPrice().getReservationPeriod().getDayCount();
		this.headCount = headCount;
		this.dailyOriginalPrice = room.getRoomPriceInfo().getDailyPrice();
		this.totalOriginalPrice = room.getRoomPrice().getTotalOriginalPrice();
		this.saleRatio = room.getRoomPriceInfo().getSaleRatio();
		this.savedPrice = room.getRoomPrice().getSavedPrice();
		this.cleanigFee = room.getRoomPriceInfo().getCleaningFee();
		this.serviceFee = room.getRoomPriceInfo().getServiceFee();
		this.lodgingTaxRatio = room.getRoomPriceInfo().getLodgingTaxRatio();
		this.lodgingTax = room.getRoomPrice().getLodgingTax();
		this.fixedTotalPrice = room.getRoomPrice().getFixedTotalPrice();
		this.fixedDailyPrice = room.getRoomPrice().getFixedDailyPrice();
	}
}
