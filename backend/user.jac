node User {
    has name: str = "";
    has phone: str = "";                # +2547...
    has whatsapp: str = "";             # optional
    has email: str = "";
    has device_id: str = "";            # for push notifications
    has location: str = "";             # e.g. "Nairobi"
    has preferences: str = "";          # json string for preferences
    has subscribed: bool = true;
}