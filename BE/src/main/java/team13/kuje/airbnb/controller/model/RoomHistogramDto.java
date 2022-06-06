package team13.kuje.airbnb.controller.model;

import java.util.List;
import java.util.stream.Collectors;
import lombok.Getter;
import team13.kuje.airbnb.domain.HistogramBin;
import team13.kuje.airbnb.domain.RoomsHistogram;

@Getter
public class RoomHistogramDto {

	private Double average;

	private List<HistogramBin> histogramBins;

	public RoomHistogramDto(RoomsHistogram roomsHistogram) {
		this.average = roomsHistogram.getAverage();
		this.histogramBins = initHistogramBins(roomsHistogram);
	}

	private List<HistogramBin> initHistogramBins(RoomsHistogram roomsHistogram) {
		List<HistogramBin> histogramBins = roomsHistogram.getHistogram().entrySet().stream().map(
				m -> new HistogramBin(m.getKey() * 100000, m.getKey() * 100000 + 100000, m.getValue()))
			.collect(Collectors.toList());
		histogramBins.set(10, new HistogramBin(1000000, null, roomsHistogram.getHistogram().get(10)));
		return histogramBins;
	}
}
