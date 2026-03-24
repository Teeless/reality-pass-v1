# Reality Pass v1 Architecture

## Overview

Reality Pass v1 is a cloud control plane for verifying physical proof of execution.

A device performs real-world work, measures electrical input and thermal response, signs that telemetry, and submits it to a cloud verifier. The cloud control plane evaluates whether the measurements are physically consistent and returns a short-lived trust decision.

## Core Idea

Traditional verification relies on inferred trust:
- credentials
- behavioral patterns
- self-declared identity

Reality Pass introduces measured trust:
- device identity bound to hardware
- measured power consumption
- measured thermal response
- time-bounded challenge/response

## High-Level Components

### Device / Edge Node
The physical device:
- receives a challenge
- performs work
- measures electrical input
- measures thermal response
- signs telemetry
- submits proof to the cloud

### Cloud Control Plane
The AWS-hosted verifier:
- issues challenges
- validates signature and attestation
- checks time freshness
- evaluates power/thermal coupling
- stores an audit record
- returns PASS or DENY

### Audit Layer
Stores:
- raw telemetry
- verification result
- reason codes
- policy version used

## AWS Components

- API Gateway: ingress for challenge and verification requests
- Lambda: verification logic
- DynamoDB: challenge registry, device registry, decision records
- S3: telemetry archive and audit artifacts
- CloudWatch: logs, metrics, alarms
- KMS: encryption support

## Verification Flow

1. Device requests challenge
2. Cloud issues nonce and time window
3. Device performs work and collects measurements
4. Device signs telemetry payload
5. Device submits payload to verifier
6. Cloud validates:
   - device identity
   - signature
   - freshness
   - challenge validity
   - power/thermal consistency
7. Cloud returns PASS or DENY
8. Cloud stores audit trail

## Trust Model

Reality Pass does not attempt to prove everything.

It attempts to prove:
- a real device participated
- in a bounded time window
- while consuming measured energy
- and producing a physically consistent response

## Future Expansion

Future versions may include:
- stronger hardware attestation
- multiple thermal probes
- anti-tamper controls
- cross-node validation
- site-bound identity
- physical location signals
