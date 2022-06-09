package team13.kuje.airbnb.login;

import com.fasterxml.jackson.annotation.JsonProperty;
import javax.persistence.Embedded;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.jetbrains.annotations.Nullable;

@Getter
@Setter
@ToString
public class User {

	@JsonProperty("login")
	private String userName;

	@JsonProperty("avatar_url")
	private String avatarImageURL;

	@JsonProperty("email")
	private String email;

	@Nullable
	private GitHubAccessToken accessToken;

	public void setAccessToken(GitHubAccessToken accessToken) {
		this.accessToken = accessToken;
	}
}
