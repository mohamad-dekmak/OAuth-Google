package m.dekmak;

import org.json.JSONObject;

public class ConfigProperties {

    JSONObject propValues = new JSONObject();

    // @TO-DO: later on, we should read values from config.properties file in resources
    public ConfigProperties() {
        propValues.put("appName", "SMB215 - Google Auth");
        propValues.put("appVersion", "v1.0");

    }

    public String getPropValue(String prop) {
        return propValues.get(prop).toString();
    }
}
