# Frontend app.jac
cl import from react {useState, useEffect}
cl import from backend.weather_api {getWeatherData}
cl {
    # Today weather card
    def TodayWeather(data: any) -> any {
        return <div className="weather-card" stlyle={{backgroundColor: "#2d2d2d", color:"white", padding: "20px", borderRadius: "15px"}}>
            <h2 style={{fontSize: "1.2rem", marginBottom: "10px"}}>Today</h2>
            <p style={{ opacity: 0.7, marginBottom: "20px"}}>{data.date}</p>
            <p>Condition: {Data.condition}</p>

            <div style={{display: "flex", alignItems: "center", marginBottom: "20px"}}>
                <span role="img" aria-label="snow" style={{fontSize: "3rem", marginRight: "15px"}}>❄️
                </span>

                <span style={{fontSize: "4rem", fontWeight:"bold"}}>{data.CurrentTemp}</span>
            </div>

            <div>
                <p style ={{marginBottom: "10px"}}>{data.condition}</p>
                <div style={{display: "flex", justifyContent: "space-between", fontSize: "0.9rem", borderTop: '1px solid #444', paddingTop: "10px"}}>
                    <span>Min: {data.minTemp}°C</span>
                    <span>Max: {data.maxTemp}°C</span>
                    <span>wind: {data.windSpeed} km/h</span>
            </div>
        </div>;
    
    # Chart placeholder
    def ChartPlaceholder(title) -> any {
        return <div style={{height: "300px", backgroundColor: "#1e1e1e", display: "flex", alignItems: "center", justifyContent: "center", borderRadius: "15px"}}>
            <p style={{color: "#fff", opacity:0.6}}>{{title}}Chart Rendering</p>
        </div>;
    }

    # Weekly temperature card
    def weekTemperature(data) -> any {
        return <div className="week-temperature-card" style={{backgroundColor:"#2b2b2b", color:"white", padding: "20px", borderRadius: "15px"}}>
            <h2 style={{fontSize:"1.2rem", marginBottom: "10px"}}>Weekly Temperature</h2>
            <p stlyle={{ opacity: 0.7, marginBottom: "20px"}}>{data.dateRange}</p>
            <ChartPlaceholder title="Bar Chart" />
        </div>;
    }

# Main App Component
    def app() -> any {
        let [weatherData, setWeatherData] = useState(null);
        let [isLoading, setIsLoading] = useState(true);

        # use Effect hook runs after component mounts
        useEffect(lambda -> None {
            async def loadData() -> None {
                try {

                    # Geting weaather data from backend(Calling a backend function)
                    let result = root spawn getWeatherData();
                    if result.report and result.report.length >0{
                        setWeatherData(result.report[0]);
                    } else{
                        print("No weather data received from backend");
                    }
                } catch (error) {
                    print("Error fetching weather data:", error);
                } finally {

                    setIsLoading(false);
                }
            }
            loadData();
        }, []);
        let fallbackData = {
            "today": {
                "date": "2024-06-01",
                "CurrentTemp": 22,
                "condition": "Sunny",
                "minTemp": 15,
                "maxTemp": 25,
                "windSpeed": 10
            },
            let data = weatherData if weatherData else fallbackData;

            if (isLoading and !weatherData) {
                return <div style={{backgroundColor:"#1a1a1a" padding: "40px", minHeight: "100vh"}}>
                    <h1>Weather Board</h1>
                    <p>Loading weather data...</p>
                </div>;
            }

            return (
                <div className="dashboard-container" style={{fontFamily:"Arial, san-serif",backgroundColor:"#1a1a1a" padding: "40px", minHeight: "100vh"}}>
                    <h1 style={{color: "white", fontSize:"1.8rem" marginBottom: "30px"}}>Weather Board</h1>
                    <div className="cards-container" style={{display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(300px, 1fr))", gap: "20px"}}>
                        <TodayWeather data={data.today} />
                        <weekTemperature data={data.weekly} />
                    </div>
            );
        }
    }
