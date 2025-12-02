# Initialize the graph with a sample user and an empty unified node
with entry {
    if !exists(/weather_unified) {
        /weather_unified = root ++> WeatherUnified;
        /weather_unified.temperature = 0.0;
        /weather_unified.updated_at = std.time.now();
    }

    # create a sample user (demo)
    if std.len([root-->(`?User)]) == 0 {
        u = root ++> User;
        u.name = "Demo Farmer";
        u.phone = "+254700000000";
        u.location = "Nairobi";
        u.subscribed = True;
    }
}