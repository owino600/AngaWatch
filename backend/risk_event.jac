node RiskEvent {
    has event: str = "";                # drought, flood, heatwave, storm
    has severity: str = "low";          # low, medium, high, critical
    has probability: float = 0.0;       # 0..1
    has area: str = "";                 # area / location tag
    has detected_at: str = "";
    has metadata: str = "";             # summary or explanation
}