# NotificationDispatcher walker
# - Walks RiskEvent nodes, matches users, and dispatches notifications
# - External SMS/WhatsApp integrations are left as placeholders. Replace with
#   actual integration code (Twilio, Africa's Talking, Meta, etc).

walker NotifyUsers {
    can start with `root entry {
        print("NotifyUsers: started");

        events = [root-->(`?RiskEvent)];
        users = [root-->(`?User)];

        if std.len(events) == 0 {
            report({"info":"no events"});
        }

        for e in events {
            for u in users {
                if u.subscribed {
                    # Compose message
                    msg = f"Alert: {e.event} ({e.severity}) in {e.area}. Probability {e.probability:.2f}. {e.metadata}";
                    print(f"Notify: sending to {u.name} -> {msg}");

                    # Placeholder: SMS send
                    # api.http.post(url="https://api.twilio.com/...", body={...}, headers={...});
                    # Placeholder: WhatsApp send via provider

                    # create log node or attach message to user (optional)
                }
            }
        }

        report({"status":"notifications_sent"});
    }
}