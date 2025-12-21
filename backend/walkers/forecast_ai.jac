# ForecastAI walker (uses byLLM)
# - This walker takes a WeatherUnified node and asks byLLM to produce
#   a human-friendly forecast and short machine-readable forecast tag.

# NOTE: the byLLM integration depends on your setup. Here we provide a
# small wrapper that calls a llm_response(...) helper. Replace with the
# actual byllm call supported by your jac installation.

walker ForecastAI {
    can start with `root entry {
        # find the latest unified record (simple approach: pick first)
        unifs = [root-->(`?WeatherUnified)];
        if std.len(unifs) == 0 {
            report({"error":"no unified data"});
        }
        u = unifs[0];

        # build prompt
        prompt = f"Weather data:\nTemp: {u.temperature} C\nHumidity: {u.humidity}%\nPrecip:{u.precipitation}mm\nWind:{u.wind_speed}m/s\nCondition:{u.condition}\n\nGive a short (1-2 sentence) forecast for local farmers and a probability (0..1) of heavy rain next 24h.";
        print("ForecastAI: calling byLLM (placeholder)");

        # PSEUDO byLLM call: replace with real byLLM invocation
        # If your Jac supports byLLM or llm_response helper, use it here.
        # summary = llm_response(prompt)
        # For now we create a mock summary:
        summary = f"Expect {u.condition} with a temperature around {u.temperature:.1f}°C. Low chance of heavy rain.";
        rain_prob = 0.05;

        # store forecast text in the unified node (if desired)
        u = u;  # reference
        # create a small metadata string
        u_forecast = f"{summary} (rain_prob={rain_prob})";

        report({"forecast": summary, "rain_probability": rain_prob});
    }
}