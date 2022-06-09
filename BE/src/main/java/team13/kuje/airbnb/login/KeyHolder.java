package team13.kuje.airbnb.login;

import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import java.security.Key;

public class KeyHolder {

	public static final Key secretKey = Keys.secretKeyFor(SignatureAlgorithm.HS256);

	private KeyHolder() {

	}

}
