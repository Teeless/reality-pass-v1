def validate_thermal_response(baseline_c, probe_series_c):
    if not probe_series_c:
        return False
    return max(probe_series_c) > baseline_c
