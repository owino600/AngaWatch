# MergeWeatherData walker
# - Read all WeatherRaw nodes created recently and produce a WeatherUnified node

walker MergeWeather {
    can start with root entry {
        print("MergeWeather: started");

        # collect raw nodes (simple: all WeatherRaw under root)
        raws = [root-->(`?WeatherRaw)];

        if std.len(raws) == 0 {
            report({"error":"no raw data"});
        }

        # compute simple aggregated stats (mean)
        temps = [];
        hums = [];
        precs = [];
        winds = [];
        sources = [];

        for r in raws {
            temps += [r.temperature];
            hums += [r.humidity];
            precs += [r.precipitation];
            winds += [r.wind_speed];
            sources += [r.source];
        }

        avg_temp = std.math.mean(temps);
        avg_hum = std.math.mean(hums);
        avg_prec = std.math.mean(precs);
        avg_wind = std.math.mean(winds);

        # basic condition pick (majority vote)
        cond_counts = {};
        for r in raws {
            cond = r.condition;
            if cond in cond_counts {
                cond_counts[cond] = cond_counts[cond] + 1;
            } else {
                cond_counts[cond] = 1;
            }
        }
        # pick max
        best_cond = "";
        best_count = 0;
        for k : v in cond_counts {
            if v > best_count {
                best_count = v;
                best_cond = k;
            }
        }

        # create unified node
        now = std.time.now();
        u = root ++> WeatherUnified;
        u.temperature = avg_temp;
        u.humidity = avg_hum;
        u.precipitation = avg_prec;
        u.wind_speed = avg_wind;
        u.condition = best_cond;
        u.confidence = std.clip( (best_count / std.len(raws)), 0.0, 1.0 );
        u.updated_at = now;
        u.sources = sources;

        print(f"MergeWeather: created unified record {u.temperature}°C, {u.condition}");
        report({"status":"ok","temperature":u.temperature,"condition":u.condition});
    }
}
