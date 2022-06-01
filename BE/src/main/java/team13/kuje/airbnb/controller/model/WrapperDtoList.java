package team13.kuje.airbnb.controller.model;

import java.util.List;
import lombok.Getter;

@Getter
public class WrapperDtoList<T> {

	private final List<T> data;

	public WrapperDtoList(List<T> dtos) {
		this.data = dtos;
	}
}
