package team13.kuje.airbnb.domain;

import lombok.Getter;

@Getter
public class RoomPrice {

	private ReservationPeriod reservationPeriod;
	private Long totalOriginalPrice;
	private Long savedPrice;
	private Long lodgingTax;
	private Long fixedTotalPrice;
	private Long fixedDailyPrice;
	private ReservationGuest reservationGuest;


	public static RoomPrice of(ReservationPeriod reservationPeriod,
		ReservationGuest reservationGuest, RoomPriceInfo roomPriceInfo) {
		RoomPrice roomPrice = new RoomPrice();
		roomPrice.reservationPeriod = reservationPeriod;
		roomPrice.totalOriginalPrice = roomPriceInfo.getDailyPrice() * reservationPeriod.getDayCount();
		roomPrice.savedPrice = (roomPrice.totalOriginalPrice * roomPriceInfo.getSaleRatio() / 100);
		roomPrice.lodgingTax = (roomPriceInfo.getServiceFee() * roomPriceInfo.getLodgingTaxRatio() / 100);
		roomPrice.fixedTotalPrice = roomPrice.totalOriginalPrice - roomPrice.savedPrice +
			roomPriceInfo.getCleaningFee() + roomPriceInfo.getServiceFee() + roomPrice.lodgingTax;
		roomPrice.fixedDailyPrice = roomPrice.fixedTotalPrice / reservationPeriod.getDayCount();
		roomPrice.reservationGuest = reservationGuest;
		return roomPrice;
	}

}
