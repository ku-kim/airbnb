package team13.kuje.airbnb.controller.model;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import team13.kuje.airbnb.domain.ReservationGuest;
import team13.kuje.airbnb.domain.ReservationPeriod;
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

	public RoomDetailPriceDto(Room room,
		ReservationPeriod reservationPeriod,
		ReservationGuest reservationGuest) {

		if (reservationPeriod.isEmpty() || reservationGuest.isEmptyAdults()) {
			return;
		}

		this.checkIn = reservationPeriod.getCheckIn();
		this.checkOut = reservationPeriod.getCheckOut();
		this.dayCount = reservationPeriod.getDayCount();
		this.headCount = reservationGuest.getHeadCount();
		this.dailyOriginalPrice = room.getRoomPriceInfo().getDailyPrice();
		this.totalOriginalPrice =
			room.getRoomPriceInfo().getDailyPrice() * reservationPeriod.getDayCount();
		this.saleRatio = room.getRoomPriceInfo().getSaleRatio();
		this.savedPrice = (totalOriginalPrice * room.getRoomPriceInfo().getSaleRatio() / 100);
		this.cleanigFee = room.getRoomPriceInfo().getCleaningFee();
		this.serviceFee = room.getRoomPriceInfo().getServiceFee();
		this.lodgingTaxRatio = room.getRoomPriceInfo().getLodgingTaxRatio();
		this.lodgingTax = (
			room.getRoomPriceInfo().getServiceFee() * room.getRoomPriceInfo().getLodgingTaxRatio()
				/ 100);
		this.fixedTotalPrice = totalOriginalPrice - savedPrice +
			room.getRoomPriceInfo().getCleaningFee() + room.getRoomPriceInfo().getServiceFee()
			+ lodgingTax;
		this.fixedDailyPrice = fixedTotalPrice / reservationPeriod.getDayCount();
	}
}
