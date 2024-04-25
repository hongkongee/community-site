package project.blog.community.project.api;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class OpenWeatherMapAPI {
    private static final String API_KEY = "1847692425e883baf8b34c897b074b6a"; // Replace with your OpenWeatherMap API key

    public static Map<String, String> getWeatherData(String city) {
        Map<String, String> weatherData = new HashMap<>();

        try {
            String apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + API_KEY;

            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();

            JSONParser parser = new JSONParser();
            JSONObject jsonObject = (JSONObject) parser.parse(response.toString());

            JSONObject main = (JSONObject) jsonObject.get("main");
            Double temperature = (Double) main.get("temp");

            JSONArray weatherArray = (JSONArray) jsonObject.get("weather");
            JSONObject weather = (JSONObject) weatherArray.get(0);
            String description = (String) weather.get("description");

            weatherData.put("temperature", String.valueOf(temperature));
            weatherData.put("description", description);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return weatherData;
    }
}