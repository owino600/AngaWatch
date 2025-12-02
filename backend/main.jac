# main.jac - imports and a small entry walker
include "weather_raw.jac";
include "weather_unified.jac";
include "risk_event.jac";
include "user.jac";

include "walkers/fetch_weather.jac";
include "walkers/merge_weather.jac";
include "walkers/forecast_ai.jac";
include "walkers/disaster_predictor.jac";
include "walkers/notify_user.jac";

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