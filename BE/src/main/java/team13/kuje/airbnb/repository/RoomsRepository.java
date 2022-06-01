package team13.kuje.airbnb.repository;

import java.util.Optional;
import org.springframework.stereotype.Repository;
import team13.kuje.airbnb.domain.Room;

@Repository
public class RoomsRepository {

	public Optional<Room> findById(Long id) {
		throw new UnsupportedOperationException("RoomsRepository#findById 아직 구현하지 않음 :)");
	}
}
