cl import ".styles.css";

def app()  -> any {

    response = root spawn weatherUnified.getWeather("Garissa, Kenya");
    
    return  
    <div class="translator-container">
    <div class="translator-card">
      <div class="translator-header">
        <div class="translator-icon">📍</div>
        <h1 class="translator-title">Garissa County</h1>
        <p class="translator-subtitle">Garissa County, Kenya — Map & Weather</p>
      </div>


      <div class="textarea-wrapper">
        <div class="info-box">
          <p class="info-text">
            Garissa County is located in northeastern Kenya. Its capital and largest town is Garissa. The county has a predominantly semi-arid climate and is traversed by the Tana River.
          </p>
        </div>
      </div>
        <div class="weather-section">
            <h2 class="weather-title">Current Weather</h2>
            <p class="weather-info">Temperature: 32°C</p>
            <p class="weather-info">Humidity: 45%</p>
            <p class="weather-info">Condition: Sunny</p>
        </div>
    </div>
  </div>;
}
