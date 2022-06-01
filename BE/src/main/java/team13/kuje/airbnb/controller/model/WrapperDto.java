package team13.kuje.airbnb.controller.model;

import lombok.Getter;

@Getter
public class WrapperDto<T> {

	private final T data;

	public WrapperDto(T dto) {
		this.data = dto;
	}
}
