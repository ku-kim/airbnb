package team13.kuje.airbnb.login;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import java.sql.Date;
import java.time.Instant;
import java.util.Collections;
import java.util.Map;
import javax.servlet.annotation.WebFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class LoginController {

	@Autowired
	private GitHubAccessTokenRequest gitHubAccessTokenRequest;

	@GetMapping("/afterlogin")
	public ResponseEntity<Void> afterLogin(@RequestParam String code) {
		GitHubAccessToken token = getToken(code);

		User user = getUserAttribute(token);

		//todo 디비에 유저 저장
		// 추후에 구현

		int expiredTime = 604800;

		//jwt 생성
		String publicJwt = getPublicJwt(user, expiredTime);

		System.out.println("publicJwt" + publicJwt);

		//쿠키 세팅
		ResponseCookie cookie = ResponseCookie.from("aribnbJwt", publicJwt)
			.maxAge(expiredTime)
			.path("/")
			.build();

		return ResponseEntity.status(HttpStatus.MOVED_PERMANENTLY)
			.header(HttpHeaders.SET_COOKIE, cookie.toString())
			.header(HttpHeaders.LOCATION, "/")
			.build();
	}

	private String getPublicJwt(User user, int expiredTime) {
		return Jwts.builder()
			.setHeader(Map.of(
				"typ", "JWT",
				"alg", "HS256",
				"regDate", System.currentTimeMillis()))
			//todo
			// user구현하면 userName이 아닌 userId 를 넣는 것이 바람직해 보임
			.setClaims(Map.of("userName", user.getUserName()))
			.setExpiration(Date.from(Instant.now().plusSeconds(expiredTime)))
			.signWith(KeyHolder.secretKey)
			.compact();
	}

	private User getUserAttribute(GitHubAccessToken token) {
		User user = WebClient.create()
			.get()
			.uri("https://api.github.com/user")
			.headers(header ->
				header.setBearerAuth(token.getAccessToken()))
			.retrieve()
			.bodyToMono(User.class)
			.block();

		return user;
	}

	private GitHubAccessToken getToken(String code) {
		gitHubAccessTokenRequest.setCode(code);
		return WebClient.create()
			.post()
			.uri("https://github.com/login/oauth/access_token")
			.headers(header -> {
				header.setContentType(MediaType.APPLICATION_JSON);
				header.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

			})
//			.accept(MediaType.APPLICATION_JSON)
			.bodyValue(gitHubAccessTokenRequest)
			.retrieve()
			.bodyToMono(GitHubAccessToken.class)
			.block();
	}

	private MultiValueMap<String, String> requestAccessToken(String code) {
		MultiValueMap<String, String> oauthInfo = new LinkedMultiValueMap<>();

		//TODO 추가하십쇼 제리
		// 추가 완료!
		oauthInfo.add("client_id", gitHubAccessTokenRequest.getClientId());
		oauthInfo.add("client_secret", gitHubAccessTokenRequest.getClientSecret());
		oauthInfo.add("code", code);
//		oauthInfo.add("redirect_uri", "http://localhost:8080/api/login");

		return oauthInfo;
	}
}
