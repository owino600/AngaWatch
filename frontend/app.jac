# frontend.jac

##############################
# Bytecode Entry Point
##############################

# Ensure this module produces bytecode on load
def __module_init__() -> None {
    return None;
}

# Execute module init so Jac generates bytecode
with entry {
    __module_init__();
}

##############################
# Client UI (Jac-Client)
##############################

cl import from jac:client_runtime { createState, createEffect }
cl {
    def app() -> any {
        # Mock weekly forecast
        let forecast = [
            {"label": "Day 1", "maxTemp": 30, "minTemp": 22, "precip_mm": 0, "wind_gust_ms": 10, "condition": "Partly Cloudy"},
            {"label": "Day 2", "maxTemp": 32, "minTemp": 23, "precip_mm": 0, "wind_gust_ms": 22, "condition": "Windy"},
            {"label": "Day 3", "maxTemp": 26, "minTemp": 19, "precip_mm": 60, "wind_gust_ms": 8, "condition": "Heavy rain"},
            {"label": "Day 4", "maxTemp": 29, "minTemp": 21, "precip_mm": 5, "wind_gust_ms": 9, "condition": "Cloudy"},
            {"label": "Day 5", "maxTemp": 31, "minTemp": 22, "precip_mm": 10, "wind_gust_ms": 12, "condition": "Sun & Cloud"},
            {"label": "Day 6", "maxTemp": 42, "minTemp": 30, "precip_mm": 0, "wind_gust_ms": 6, "condition": "Extreme heat"},
            {"label": "Day 7", "maxTemp": 28, "minTemp": 20, "precip_mm": 0, "wind_gust_ms": 8, "condition": "Fair"}
        ];

        # Alarm thresholds
        let THRESHOLDS = {"precip_mm": 50, "max_temp_c": 40, "wind_gust_ms": 20};

        # Alarm logic function
        def isAlarming(day: any) -> bool {
            if day.precip_mm >= THRESHOLDS.precip_mm { return True; }
            if day.maxTemp >= THRESHOLDS.max_temp_c { return True; }
            if day.wind_gust_ms >= THRESHOLDS.wind_gust_ms { return True; }
            return False;
        }

        # Build list of forecast cards
        let cards = [];
        let anyAlarm = False;
        for d in forecast {
            if isAlarming(d) {
                anyAlarm = True;
                cards.append(<div class="card alarm">
                    <div class="card-label">{d.label}</div>
                    <div class="card-condition">{d.condition}</div>
                    <div class="card-temp">{d.maxTemp}°C</div>
                    <div class="card-min">Min {d.minTemp}°C</div>
                    <div class="card-metrics">Precip: {d.precip_mm} mm • Wind: {d.wind_gust_ms} m/s</div>
                    <div class="badge">ALARM</div>
                </div>);
            } else {
                cards.append(<div class="card">
                    <div class="card-label">{d.label}</div>
                    <div class="card-condition">{d.condition}</div>
                    <div class="card-temp">{d.maxTemp}°C</div>
                    <div class="card-min">Min {d.minTemp}°C</div>
                    <div class="card-metrics">Precip: {d.precip_mm} mm • Wind: {d.wind_gust_ms} m/s</div>
                </div>);
            }
        }

        # Banner based on any alarm
        let banner = None;
        if anyAlarm {
            banner = <div class="alarmBanner">WARNING: Potential severe conditions this week</div>;
        } else {
            banner = <div class="allClear">All clear</div>;
        }

        # Render UI
        return <div class="root">
            <style>{"\n.root { font-family: Inter, Arial, sans-serif; padding:18px; }\n.card { margin:8px; padding:12px; border-radius:8px; background:#fff; }\n.alarm { border:2px solid #D32F2F; background:#FFEBEE; }\n.alarmBanner { background:#FF5252; color:white; padding:10px; }\n.allClear { color:#2E7D32; padding:10px; }\n"}</style>

            {banner}

            <div class="forecastGrid">{cards}</div>
        </div>;
    }
}
