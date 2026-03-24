# Reality Pass v1 API Contract

## Overview

Reality Pass v1 exposes a minimal API for challenge issuance and proof verification.

## Endpoints

### POST /challenge

Requests a short-lived verification challenge.

#### Request Body

```json
{
  "device_id": "device-001"
}
Response Body
{
  "challenge_id": "chlg_12345",
  "nonce": "abc123xyz",
  "issued_at": "2026-03-24T20:00:00Z",
  "expires_at": "2026-03-24T20:00:30Z",
  "measurement_window_seconds": 30
}

Request Body
{
  "challenge_id": "chlg_12345",
  "device_id": "device-001",
  "timestamp": "2026-03-24T20:00:10Z",
  "device_attestation": {
    "type": "tpm",
    "evidence": "base64-attestation-data"
  },
  "power": {
    "voltage": 120.4,
    "current": 1.82,
    "watts_series": [180, 189, 192, 188, 191]
  },
  "thermal": {
    "baseline_c": 24.3,
    "probe_series_c": [24.3, 24.8, 25.7, 26.9, 28.1]
  },
  "signature": "base64-signature"
}
Response Body

{
  "decision": "PASS",
  "pass_id": "rp_0001",
  "expires_in_seconds": 300,
  "policy_version": "v1.0.0",
  "reason_codes": [
    "DEVICE_ATTESTED",
    "CHALLENGE_VALID",
    "POWER_PROFILE_VALID",
    "THERMAL_RESPONSE_VALID",
    "TIME_WINDOW_VALID"
  ]
}
GET /status/{pass_id}
Response Body
{
  "pass_id": "rp_0001",
  "decision": "PASS",
  "issued_at": "2026-03-24T20:00:12Z",
  "policy_version": "v1.0.0"
}
Response Codes
200: request accepted
400: invalid payload
401: invalid signature or attestation
403: verification denied
404: pass record not found
409: replayed or expired challenge

Notes

## Commit message
```text
Add API contract document
