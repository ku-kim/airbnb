package team13.kuje.airbnb.domain;

import javax.persistence.Embeddable;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Embeddable
@Getter
@Setter(value = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class RoomPriceInfo {

	private long dailyPrice;
	private long cleaningFee;
	private long serviceFee;
	private long saleRatio;
	private long lodgingTaxRatio;


	public static RoomPriceInfo of(long dailyPrice, long cleaningFee, long serviceFee, long saleRatio,
		long lodgingTaxRatio) {

		RoomPriceInfo roomPriceInfo = new RoomPriceInfo();
		roomPriceInfo.setDailyPrice(dailyPrice);
		roomPriceInfo.setCleaningFee(cleaningFee);
		roomPriceInfo.setServiceFee(serviceFee);
		roomPriceInfo.setSaleRatio(saleRatio);
		roomPriceInfo.setLodgingTaxRatio(lodgingTaxRatio);

		return roomPriceInfo;
	}
}
