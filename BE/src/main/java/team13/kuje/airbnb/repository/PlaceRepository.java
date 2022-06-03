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

	/**
	 * northEastPosition : inputPosition 기준 ANGLE_OF_SEARCH_RANGE 를 더한 오른쪽 위 대각선 위치
	 * southWestPosition : inputPosition 기준 ANGLE_OF_SEARCH_RANGE 를 뺀 왼쪽 아래 대각선 위치
	 */
	public List<Place> findByPosition(Position inputPosition, int angleOfSearchRange) {
		Position northEastPosition = new Position(inputPosition.getLat() + angleOfSearchRange, inputPosition.getLng() + angleOfSearchRange);
		Position southWestPosition = new Position(inputPosition.getLat() - angleOfSearchRange, inputPosition.getLng() - angleOfSearchRange);

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
