walker set_llm_key(key: str) {
    llm::set_creds(openai_api_key=key);
    report "LLM API key configured successfully";
}

walker set_weather_key(key: str) {
    globals.WEATHER_KEY = key;
    report "Weather API key set";
}