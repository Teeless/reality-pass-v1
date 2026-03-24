# Reality Pass v1 Threat Model

## Purpose

This document outlines the main threats considered in Reality Pass v1.

## Security Goal

Reality Pass v1 aims to reduce trust in self-declared software assertions by requiring evidence of physical proof of execution.

## In-Scope Threats

### 1. Replay Attacks
An attacker reuses an old signed payload.

Mitigation:
- short-lived challenge
- nonce binding
- timestamp validation
- replay detection in challenge table

### 2. Software-Only Spoofing
An attacker sends fabricated telemetry without real physical execution.

Mitigation:
- device attestation
- signature validation
- power and thermal consistency checks

### 3. Stale Measurements
An attacker submits valid but outdated measurements.

Mitigation:
- freshness window
- challenge expiration
- time validation

### 4. Single-Sensor Manipulation
An attacker attempts to spoof one measurement point.

Mitigation:
- multiple measurements
- coupling analysis between power and thermal response
- anomaly detection

## Not Fully Solved in v1

### 1. Local Thermal Spoofing
An attacker heats a probe using an external source.

### 2. Current Sensor Spoofing
An attacker manipulates the power measurement path.

### 3. Hardware Theft
A trusted device is stolen and reused elsewhere.

### 4. Relay Bypass
A physical control output is bypassed.

### 5. Colluding Operator
A local trusted operator intentionally defeats the system.

## Assumptions

- the verifier runs in a trusted cloud environment
- device registration is controlled
- cryptographic keys are protected
- network transport is secured

## Future Hardening

- secure element backed signing
- multi-probe thermal maps
- tamper evidence
- hardware-sealed metering
- site-bound node identity
