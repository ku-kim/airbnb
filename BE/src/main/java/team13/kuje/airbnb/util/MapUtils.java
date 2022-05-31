package team13.kuje.airbnb.util;

public class MapUtils {

	private MapUtils() {
	}

	/**
	 * 두 점의 위경도에 사이의 거리 (단위, km)
	 */
	// reference http://www.geodatasource.com/developers/
	public static double calculateDistance(double lat1, double lng1, double lat2, double lng2) {

		double theta = lng1 - lng2;
		double dist =
			Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(
				deg2rad(lat2)) * Math.cos(deg2rad(theta));

		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515;
		dist = dist * 1.609344;

		return (dist);
	}

	// This function converts decimal degrees to radians
	private static double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	// This function converts radians to decimal degrees
	private static double rad2deg(double rad) {
		return (rad * 180 / Math.PI);
	}

}
