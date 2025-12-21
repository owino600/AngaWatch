# FetchExternalWeather walker
# - This walker demonstrates how to create WeatherRaw nodes.
# - Replace the pseudo-http blocks with real API calls and keys.
# - If you don't have API keys yet, this walker will create mocked data.

walker FetchWeather {
    can start with `root entry {
        print("FetchWeather: started");

        # --- EXAMPLE 1: mocked data (safe to run immediately) ---
        now = std.time.now();
        w1 = root ++> WeatherRaw;
        w1.source = "mock_api_1";
        w1.temperature = 24.2;
        w1.humidity = 56.0;
        w1.precipitation = 0.0;
        w1.wind_speed = 6.5;
        w1.condition = "Partly cloudy";
        w1.timestamp = now;

        w2 = root ++> WeatherRaw;
        w2.source = "mock_api_2";
        w2.temperature = 24.0;
        w2.humidity = 57.0;
        w2.precipitation = 0.0;
        w2.wind_speed = 6.0;
        w2.condition = "Partly cloudy";
        w2.timestamp = now;

        print("FetchWeather: created mock WeatherRaw nodes");

        # --- OPTIONAL: Real API example (replace with working call) ---
        # Uncomment and replace with your API call code if your Jac supports http:
        # resp = api.http.get(url="https://api.openweathermap.org/data/2.5/weather",
        #                     query={"q":"Nairobi","appid": globals.OPENWEATHER_KEY, "units":"metric"});
        # if resp and resp.main {
        #     w = root ++> WeatherRaw;
        #     w.source = "openweather";
        #     w.temperature = resp.main.temp;
        #     w.humidity = resp.main.humidity;
        #     w.precipitation = resp.rain ? resp.rain["1h"] : 0.0;
        #     w.wind_speed = resp.wind.speed;
        #     w.condition = resp.weather[0].description;
        #     w.timestamp = std.time.now();
        # }

        report({"status":"ok","message":"fetch completed"});
    }
}