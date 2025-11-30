walker ai_weather_summary(temp: float, condition: str) {
    summary = byllm::gen(
        prompt=f"Generate a simple weather summary for a Kenyan user. Temperature is {temp}°C and condition code is {condition}."
    );
    report summary;
}