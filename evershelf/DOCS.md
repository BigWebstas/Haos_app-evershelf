# EverShelf

Runs the [EverShelf](https://github.com/dadaloop82/EverShelf) pantry server inside Home Assistant.

1. Start the add-on and open the web UI (port 8080).
2. Configure API keys and the settings token in the app's Settings page.
3. Install the [ha-evershelf](https://github.com/dadaloop82/ha-evershelf) integration and point it at `http://<ha-host>:8080`.

Data (database, backups) lives in the add-on's persistent `/data` and is included in HA backups.
