package team13.kuje.airbnb.repository;

import static team13.kuje.airbnb.domain.Position.ONE_DEGREE;
import static team13.kuje.airbnb.domain.QRoom.room;
import static team13.kuje.airbnb.domain.QRoomImage.roomImage;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import javax.persistence.EntityManager;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import team13.kuje.airbnb.controller.model.RoomDto;
import team13.kuje.airbnb.domain.Position;
import team13.kuje.airbnb.domain.ReservationGuest;
import team13.kuje.airbnb.domain.ReservationPeriod;
import team13.kuje.airbnb.domain.Room;

@Repository
public class RoomsRepository {

	private final EntityManager entityManager;
	private final JPAQueryFactory queryFactory;

	public RoomsRepository(EntityManager entityManager) {
		this.entityManager = entityManager;
		this.queryFactory = new JPAQueryFactory(entityManager);
	}

	public Optional<Room> findById(Long id) {
		return Optional.ofNullable(entityManager.find(Room.class, id));
	}

	public List<Room> findPriceHistogramByPosition(Position inputPosition, int angleOfSearchRange) {
		Position northEastPosition = new Position(inputPosition.getLat() + angleOfSearchRange,
			inputPosition.getLng() + angleOfSearchRange);
		Position southWestPosition = new Position(inputPosition.getLat() - angleOfSearchRange,
			inputPosition.getLng() - angleOfSearchRange);

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

	public Page<RoomDto> findRoomsBy(Position inputPosition,
		ReservationPeriod inputReservationPeriod, ReservationGuest inputReservationGuest,
		Long minDailyPrice, Long maxDailyPrice, Pageable pageable,
		Integer cachedCount) {

		double maxLat = inputPosition.getLat() + ONE_DEGREE;
		double minLat = inputPosition.getLat() - ONE_DEGREE;
		double maxLng = inputPosition.getLng() + ONE_DEGREE;
		double minLng = inputPosition.getLng() - ONE_DEGREE;

		List<Room> rooms = queryFactory.selectDistinct(room)
			.from(room)
			.where(
				room.position.lat.between(minLat, maxLat),
				room.position.lng.between(minLng, maxLng),
				headCountGoe(inputReservationGuest.getHeadCount()),
				dailyPriceGoe(minDailyPrice),
				dailyPriceLoe(maxDailyPrice))
			.leftJoin(room.images, roomImage).fetchJoin()
			.offset(pageable.getOffset())
			.limit(pageable.getPageSize())
			.fetch();

		List<RoomDto> contents = rooms.stream()
			.map(RoomDto::new)
			.collect(Collectors.toList());

		long totalCount = cachedCount != null ? cachedCount : countOf(inputPosition, inputReservationGuest, minDailyPrice, maxDailyPrice);

		return new PageImpl<>(contents, pageable, totalCount);
	}

	private long countOf(Position inputPosition,
		ReservationGuest inputReservationGuest, Long minDailyPrice, Long maxDailyPrice) {
		double maxLat = inputPosition.getLat() + ONE_DEGREE;
		double minLat = inputPosition.getLat() - ONE_DEGREE;
		double maxLng = inputPosition.getLng() + ONE_DEGREE;
		double minLng = inputPosition.getLng() - ONE_DEGREE;

		return queryFactory.select(room.count())
			.from(room)
			.where(
				room.position.lat.between(minLat, maxLat),
				room.position.lng.between(minLng, maxLng),
				headCountGoe(inputReservationGuest.getHeadCount()),
				dailyPriceGoe(minDailyPrice),
				dailyPriceLoe(maxDailyPrice))
			.fetchOne();
	}


	private BooleanExpression dailyPriceGoe(Long minDailyPrice) {
		if (minDailyPrice != null) {
			return room.roomPriceInfo.dailyPrice.goe(minDailyPrice);
		}
		return null;
	}

	private BooleanExpression dailyPriceLoe(Long maxDailyPrice) {
		if (maxDailyPrice != null) {
			return room.roomPriceInfo.dailyPrice.loe(maxDailyPrice);
		}
		return null;
	}

	private BooleanExpression headCountGoe(Long headCount) {
		if (headCount != null) {
			return room.headcountCapacity.goe(headCount);
		}
		return null;
	}
}
