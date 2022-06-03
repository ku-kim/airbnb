package team13.kuje.airbnb.repository;

import java.util.Optional;
import javax.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import team13.kuje.airbnb.domain.Room;

@Repository
@RequiredArgsConstructor
public class RoomsRepository {

	private final EntityManager entityManager;

	public Optional<Room> findById(Long id) {
		return Optional.ofNullable(entityManager.find(Room.class, id));
	}
}
