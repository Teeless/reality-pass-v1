import json
import time

def lambda_handler(event, context):
    try:
        body = json.loads(event.get("body", "{}"))

        power = body.get("power", {})
        thermal = body.get("thermal", {})

        watts_series = power.get("watts_series", [])
        temp_series = thermal.get("probe_series_c", [])
        baseline = thermal.get("baseline_c", 0)

        if not watts_series or not temp_series:
            return _response("DENY", "MISSING_DATA")

        power_ok = max(watts_series) > 100
        thermal_ok = max(temp_series) > baseline + 2

        if power_ok and thermal_ok:
            return _response("PASS", "PHYSICAL_CONSISTENCY")
        else:
            return _response("DENY", "FAILED_PHYSICAL_CHECK")

    except Exception as e:
        return _response("ERROR", str(e))


def _response(decision, reason):
    return {
        "statusCode": 200,
        "body": json.dumps({
            "decision": decision,
            "reason": reason,
            "timestamp": int(time.time())
        })
    }
