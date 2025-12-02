# main.jac - imports and a small entry walker
import weather_raw;
import weather_unified;
import risk_event;
import user;

import walkers.fetch_weather;
import walkers.merge_weather;
import walkers.forecast_ai;
import walkers.disaster_predictor;
import walkers.notify_user;


walker Root {
    can start with root entry {
        print("AngaWatch backend ready");
    }
}

# convenience walker that runs a full pipeline once
walker RunPipeline {
    can start with root entry {
        root spawn FetchWeather;
        root spawn MergeWeather;
        root spawn ForecastAI;
        root spawn DisasterPredictor;
        root spawn NotifyUsers;
        print("RunPipeline: full pipeline executed");
    }
}