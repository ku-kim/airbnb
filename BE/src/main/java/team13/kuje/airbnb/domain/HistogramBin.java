package team13.kuje.airbnb.domain;

import lombok.Getter;

@Getter
public class HistogramBin {

	private final int min;
	private final Integer max;
	private final int count;

	public HistogramBin(int min, Integer max, int count) {
		this.min = min;
		this.max = max;
		this.count = count;
	}
}
