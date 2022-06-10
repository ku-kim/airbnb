package team13.kuje.airbnb.repository;

import java.util.List;
import javax.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import team13.kuje.airbnb.domain.Event;

@Repository
@RequiredArgsConstructor
public class EventRepository {

	private final EntityManager entityManager;

	public List<Event> findByCategoryTag(String tag) {
		if (tag.equals("main")) {
			return entityManager.createQuery(
				"select e from Event e where e.isMain = true", Event.class).getResultList();
		}
		return entityManager.createQuery(
			"select e from Event e where e.isMain = false", Event.class).getResultList();
	}
}
