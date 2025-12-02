node WeatherUnified {
    has temperature: float = 0.0;
    has humidity: float = 0.0;
    has precipitation: float = 0.0;
    has wind_speed: float = 0.0;
    has condition: str = "unknown";
    has confidence: float = 0.0;        # fusion confidence 0..1
    has updated_at: str = "";
    has sources: list[str] = [];
}