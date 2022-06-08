package team13.kuje.airbnb.domain;

import java.util.DoubleSummaryStatistics;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import lombok.Getter;

import static java.lang.Math.floor;
import static java.util.function.Function.identity;
import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.mapping;
import static java.util.stream.Collectors.summingInt;
import static java.util.stream.Collectors.toMap;
import static java.util.stream.IntStream.range;

/*
// 참고자료
// https://gist.github.com/obatiuk/ca0eb94b1d31310f8c648f506f96e0f8
 */
@Getter
public class RoomsHistogram {

	private static final int BIN_MAX_PRICE = 1000000;
	private static final int BIN_MIN_PRICE = 0;
	public static final int SEPARATE_BINS = 11;

	private List<Double> roomsDailyPrice;
	private Double average;
	private Map<Integer, Integer> histogram;

	private RoomsHistogram(List<Room> rooms) {
		this.roomsDailyPrice = rooms.stream()
			.mapToDouble(r -> r.getRoomPriceInfo().getDailyPrice()).boxed()
			.collect(Collectors.toList());
		this.histogram = histogram();
	}

	private static Integer findBin(Double datum, int bins, double min, double max) {
		final double binWidth = (max - min) / bins;
		if (datum >= max) {
			return bins - 1;
		} else if (datum <= min) {
			return 0;
		}
		return (int) floor((datum - min) / binWidth);
	}

	private Map<Integer, Integer> histogram() {
		final DoubleSummaryStatistics statistics = this.roomsDailyPrice.stream()
			.mapToDouble(x -> x)
			.summaryStatistics();

		this.average = Math.round(statistics.getAverage() * 100) / 100.0;

		// Make sure that all bins are initialized
		final Map<Integer, Integer> histogram = range(0, SEPARATE_BINS).boxed()
			.collect(toMap(identity(), x -> 0));

		histogram.putAll(this.roomsDailyPrice.stream()
			.collect(groupingBy(x -> findBin(x, SEPARATE_BINS, BIN_MIN_PRICE, BIN_MAX_PRICE),
				mapping(x -> 1, summingInt(x -> x)))));

		return histogram;
	}

	public static RoomsHistogram from(List<Room> data) {
		return new RoomsHistogram(data);
	}

}
