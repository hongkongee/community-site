package project.blog.community.project.controller;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import project.blog.community.project.api.OpenWeatherMapAPI;

import java.util.Map;

@SpringBootApplication
@RestController
public class WeatherApp {


    @GetMapping("/weather")
    public Map<String, String> getWeather(@RequestParam String city) {
        return OpenWeatherMapAPI.getWeatherData(city);
    }

    @GetMapping("/weatherView")
    public String weatherView() {
        return "weather"; // weather.jsp 파일을 보여줄 것으로 기대합니다.
    }
}