package com.ryu.goodchoose.common.util;

/**
 * @author ryuDumpling
 * @version 2023/10/12 9:39
 */
import io.jsonwebtoken.*;
import org.springframework.util.StringUtils;
import java.util.Date;

public class JwtHelper {

    private static long tokenExpiration = 365*24*60*60*1000;//过期时间
    private static String tokenSignKey = "goodchoose";//密钥

    //根据userId和username生成token字符串
    public static String createToken(Long userId, String userName) {
        String token = Jwts.builder()
                .setSubject("goodchoose-USER")
                .setExpiration(new Date(System.currentTimeMillis() + tokenExpiration))//设置过期时间
                .claim("userId", userId)
                .claim("userName", userName)
                .signWith(SignatureAlgorithm.HS512, tokenSignKey)
                .compressWith(CompressionCodecs.GZIP)//压缩字符串
                .compact();
        return token;
    }

    //得到用户id
    public static Long getUserId(String token) {
        if(StringUtils.isEmpty(token)) return null;

        Jws<Claims> claimsJws = Jwts.parser().setSigningKey(tokenSignKey).parseClaimsJws(token);
        Claims claims = claimsJws.getBody();
        Integer userId = (Integer)claims.get("userId");
        return userId.longValue();
        // return 1L;
    }

    //得到用户名称
    public static String getUserName(String token) {
        if(StringUtils.isEmpty(token)) return "";

        Jws<Claims> claimsJws = Jwts.parser().setSigningKey(tokenSignKey).parseClaimsJws(token);
        Claims claims = claimsJws.getBody();
        return (String)claims.get("userName");
    }

    public static void removeToken(String token) {
        //jwttoken无需删除，客户端扔掉即可。
    }

    public static void main(String[] args) {
        String token = JwtHelper.createToken(1L, "admin");
        System.out.println(token);
        System.out.println(JwtHelper.getUserId(token));
        System.out.println(JwtHelper.getUserName(token));
    }
}