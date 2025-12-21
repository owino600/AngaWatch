# DisasterPredictor walker
# - Evaluate unified weather and recent history to generate RiskEvent nodes

walker DisasterPredictor {
    can start with `root entry {
        print("DisasterPredictor: started");

        unifs = [root-->(`?WeatherUnified)];
        if std.len(unifs) == 0 {
            report({"error":"no unified data"});
        }
        u = unifs[0];

        # simple rules (MVP). Replace/tune with better logic.
        if u.precipitation >= 100.0 {
            r = root ++> RiskEvent;
            r.event = "flood";
            r.severity = "high";
            r.probability = 0.9;
            r.area = "region-default";
            r.detected_at = std.time.now();
            r.metadata = "High accumulated precipitation";
        }

        if u.temperature >= 38.0 {
            r2 = root ++> RiskEvent;
            r2.event = "heatwave";
            r2.severity = "medium";
            r2.probability = 0.6;
            r2.area = "region-default";
            r2.detected_at = std.time.now();
            r2.metadata = "High temperatures detected";
        }

        # example drought rule: requires history (not implemented here)
        # more advanced predictors would look at time series of unified nodes.

        report({"status":"ok","events": [ [x.event,x.severity] for x in [root-->(`?RiskEvent)] ]});
    }
}