package team13.kuje.airbnb.login;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.SignatureException;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.naming.spi.ObjectFactory;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

@WebFilter(urlPatterns = "/api/*")
public class LoginFilter implements Filter {

	private static final Set<String> ALLOWED_PATHS = Collections.unmodifiableSet(new HashSet<>(
		Arrays.asList("", "/api/afterlogin")));

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		Filter.super.init(filterConfig);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;

		String path = httpRequest.getRequestURI();

		String originPath = path.substring(httpRequest.getContextPath().length()).replaceAll("[/]+$", "");

		System.out.println("originPath : " + originPath);
		if (ALLOWED_PATHS.contains(originPath)) {
			chain.doFilter(request, response);
			return;
		}

		String authorization = httpRequest.getHeader("Authorization");
		System.out.println(authorization);

		try {
			if (authorization == null || !authorization.startsWith("Bearer ")) {
				throw new IllegalStateException("토큰을 찾을 수 없습니다.");
			}

			String token = getToken(authorization);

			Claims claims = Jwts.parserBuilder()
				.setSigningKey(KeyHolder.secretKey)
				.build()
				.parseClaimsJws(token)
				.getBody();

			String userName = claims.get("userName", String.class);

			//todo
			// DB에서 존재하는 회원인지 확인하는 작업 필요

			System.out.println("claims userName : " + userName);
		} catch (JwtException | IllegalStateException e) {
			e.printStackTrace();

			HttpServletResponse httpResponse = (HttpServletResponse) response;
			httpResponse.setStatus(HttpStatus.UNAUTHORIZED.value());
			return;
		}

		chain.doFilter(request, response);
	}

	private String getToken(String authorization) {
		String[] split = authorization.split(" ");

		if (split.length !=2) {
			throw new IllegalStateException("유효한 Authorization 헤더가 아닙니다.");
		}

		return split[1];
	}

	@Override
	public void destroy() {
		Filter.super.destroy();
	}
}
