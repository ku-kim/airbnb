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

	private LocalDateTime checkIn;
	private LocalDateTime checkOut;
	private Long dayCount;
	private Long headCount;
	private Long totalOriginalPrice;
	private Long dailyOriginalPrice;
	private Long saleRatio;
	private Long savedPrice;
	private Long cleanigFee;
	private Long serviceFee;
	private Long lodgingTaxRatio;
	private Long lodgingTax;
	private Long fixedDailyPrice;
	private Long fixedTotalPrice;

	public RoomDetailPriceDto(Room room) {
		if (room.getRoomPrice() == null) {
			return;
		}

		this.checkIn = room.getRoomPrice().getReservationPeriod().getCheckIn();
		this.checkOut = room.getRoomPrice().getReservationPeriod().getCheckOut();
		this.dayCount = room.getRoomPrice().getReservationPeriod().getDayCount();
		this.headCount = room.getRoomPrice().getReservationGuest().getHeadCount();
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
