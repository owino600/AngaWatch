node LocationNode {
    has name: str;
    has lat: float;
    has lon: float;
    has last_updated: datetime;
}

node WeatherNode {
    has temperature: float;
    has condition: str;
    has forecast_text: str;
    has timestamp: datetime;
}
walker fetch_weather(location: str) {
    api_key = globals.WEATHER_KEY;

    # Example: Nairobi coordinates
    lat = -1.2863;
    lon = 36.8172;

    response = api.http.get(
        url="https://api.open-meteo.com/v1/forecast",
        query={
            "latitude": lat,
            "longitude": lon,
            "current_weather": "true"
        }
    );

    temp = response.current_weather.temperature;
    cond = response.current_weather.weathercode;

    # Create or update location
    loc = spawn here ++ LocationNode(
        name=location, lat=lat, lon=lon,
        last_updated=datetime.now()
    );

    # Create new weather record
    weather = spawn here ++ WeatherNode(
        temperature=temp,
        condition=str(cond),
        timestamp=datetime.now()
    );

    loc --> location_to_weather --> weather;

    report {
        "temperature": temp,
        "condition": cond
    };
}

walker forecast_summary(location: str) {
    latest = spawn get_latest_weather(location=location);

    temp = latest.report.temperature;
    cond = latest.report.condition;

    summary = spawn ai_weather_summary(temp=temp, condition=cond);

    report summary.report;
}

walker auto_update(location: str) {
    every 30m {
        spawn fetch_weather(location=location);
    }
}
