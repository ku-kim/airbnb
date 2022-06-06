package team13.kuje.airbnb.repository;

import java.util.List;
import java.util.Optional;
import javax.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import team13.kuje.airbnb.domain.Position;
import team13.kuje.airbnb.domain.Room;

@Repository
@RequiredArgsConstructor
public class RoomsRepository {

	private final EntityManager entityManager;

	public Optional<Room> findById(Long id) {
		return Optional.ofNullable(entityManager.find(Room.class, id));
	}

	public List<Room> findPriceHistogramByPosition(Position inputPosition, int angleOfSearchRange) {
		Position northEastPosition = new Position(inputPosition.getLat() + angleOfSearchRange, inputPosition.getLng() + angleOfSearchRange);
		Position southWestPosition = new Position(inputPosition.getLat() - angleOfSearchRange, inputPosition.getLng() - angleOfSearchRange);

		return entityManager.createQuery(
				"select r from Room r "
					+ "where r.position.lat between :minLat and :maxLat "
					+ "and r.position.lng between :minLng and :maxLng", Room.class)
			.setParameter("minLat", southWestPosition.getLat())
			.setParameter("maxLat", northEastPosition.getLat())
			.setParameter("minLng", southWestPosition.getLng())
			.setParameter("maxLng", northEastPosition.getLng())
			.getResultList();
	}
}
