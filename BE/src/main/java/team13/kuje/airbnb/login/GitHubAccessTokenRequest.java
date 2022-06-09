package team13.kuje.airbnb.login;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@Getter
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@PropertySource("classpath:oauth_secret.yml")
@Component
@AllArgsConstructor
@NoArgsConstructor
public class GitHubAccessTokenRequest {

	//todo
	// Component를 붙이면 싱글톤으로 관리가 되는데
	// 싱글톤에서 상태를 가지고 있으면 이거.. 공유되면서 멀티쓰레드환경에서 난리날 거 같은데?

	private String code;
	@Value("${secret.github.clientid}")
	private String clientId;
	@Value("${secret.github.secrets}")
	private String clientSecret;

	public void setCode(String code) {
		this.code = code;
	}
}
