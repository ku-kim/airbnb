package team13.kuje.airbnb.domain;


import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Host {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "HOST_ID")
	private Long id;

	private String hostName;
	@Column(length = 1000)
	private String hostImageUrl;

	@OneToMany(mappedBy = "host")
	private List<Room> rooms = new ArrayList<>();

	public static Host of(String hostName, String hostImageUrl) {
		Host host = new Host();
		host.setHostName(hostName);
		host.setHostImageUrl(hostImageUrl);
		return host;
	}
}
