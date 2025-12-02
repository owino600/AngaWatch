node WeatherRaw {
    has source: str = "unknown";        # e.g. "openweather", "meteostat"
    has station_id: str = "";
    has temperature: float = 0.0;
    has humidity: float = 0.0;
    has precipitation: float = 0.0;
    has wind_speed: float = 0.0;
    has condition: str = "unknown";
    has timestamp: str = "";
}