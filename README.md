# Spring Boot3 Web MVC 학습!

## 프로젝트 초기 설정시 추가할 문법
- build.gradle 파일에 jsp 설정 추가
```
    implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
    implementation 'jakarta.servlet:jakarta.servlet-api'
    implementation 'jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api'
    implementation 'org.glassfish.web:jakarta.servlet.jsp.jstl'
```

- application.properties 파일에 추가
```
# server port change
server.port=8181

# jsp view resolver setting
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp
```

- 자바프로그램과 MySQL을 연동해주는 커넥터 추가
```
https://mvnrepository.com/artifact/mysql/mysql-connector-java

implementation 'mysql:mysql-connector-java:8.0.33'
```

- Spring Boot Starter JDBC 추가
```
https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-jdbc

implementation 'org.springframework.boot:spring-boot-starter-jdbc:3.2.4'

```

- MyBatis Spring Boot Starter 추가
```
	// Spring Boot 3에서는 mybatis 3.x 버전으로 진행하세요.
	// https://mvnrepository.com/artifact/org.mybatis.spring.boot/mybatis-spring-boot-starter
	implementation 'org.mybatis.spring.boot:mybatis-spring-boot-starter:3.0.3'
```
- 입력값 검증 라이브러리
```
    // 입력값 검증 라이브러리
    implementation 'org.springframework.boot:spring-boot-starter-validation'
```
- 스프링 시큐리티 모듈
```
    //스프링 시큐리티 모듈
    implementation 'org.springframework.boot:spring-boot-starter-security'
```
- JSON-SIMPLE
```
	// json-simple: 문자열 JSON 데이터를 진짜 JSON으로 변환 및 데이터 취득을 도와주는 라이브러리
	// https://mvnrepository.com/artifact/com.googlecode.json-simple/json-simple
	implementation 'com.googlecode.json-simple:json-simple:1.1.1'
```







