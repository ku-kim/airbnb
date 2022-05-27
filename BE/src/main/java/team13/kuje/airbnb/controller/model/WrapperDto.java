package team13.kuje.airbnb.controller.model;

import java.util.List;

public class WrapperDto<T> {

	private final List<T> data;

	public WrapperDto(List<T> dtos) {
		this.data = dtos;
	}
}