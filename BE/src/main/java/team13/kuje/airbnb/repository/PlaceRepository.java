package team13.kuje.airbnb.repository;


import java.util.List;
import javax.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import team13.kuje.airbnb.domain.Place;
import team13.kuje.airbnb.domain.Position;

@Repository
@RequiredArgsConstructor
public class PlaceRepository {

	private final EntityManager entityManager;

//	public List<Place> findByPosition(Position inputPosition) {
//		return entityManager.createQuery("select p from Place p", Place.class)
//			.getResultList();
//	}

	public List<Place> findByPosition(double minLat, double minLng, double maxLat, double maxLng) {
		return entityManager.createQuery(
				"select p from Place p "
					+ "where p.position.lat between :minLat and :maxLat "
					+ "and p.position.lng between :minLng and :maxLng", Place.class)
			.setParameter("minLat", minLat)
			.setParameter("maxLat", maxLat)
			.setParameter("minLng", minLng)
			.setParameter("maxLng", maxLng)
			.getResultList();
	}

	public List<Place> findByPosition(Position southWestPosition, Position northEastPosition) {
		return entityManager.createQuery(
				"select p from Place p "
					+ "where p.position.lat between :minLat and :maxLat "
					+ "and p.position.lng between :minLng and :maxLng", Place.class)
			.setParameter("minLat", southWestPosition.getLat())
			.setParameter("maxLat", northEastPosition.getLat())
			.setParameter("minLng", southWestPosition.getLng())
			.setParameter("maxLng", northEastPosition.getLng())
			.getResultList();
	}
}
