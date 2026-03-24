# Reality Pass v1 Test Rig

## Purpose

The Reality Pass v1 test rig is the physical validation layer used to simulate and measure proof of execution.

Its role is to generate a simple but observable relationship between:

- electrical input
- device activity
- thermal response
- cloud verification logic

## v1 Test Rig Goals

The first version is not intended to prove full geographic location.

It is intended to demonstrate a narrower idea:

A device can perform real work, consume measurable energy, generate measurable thermal output, and submit that evidence to a cloud verifier.

## Planned Components

### Physical Components
- small compute device or microcontroller
- controllable electrical load
- current or watt measurement sensor
- one or more temperature probes
- optional relay or interlock output

### Cloud Components
- API endpoint for verification requests
- Lambda-based verifier
- DynamoDB tables for challenge and results
- audit storage for telemetry and decisions

## Test Flow

1. Device receives challenge
2. Device energizes load or performs work
3. Power draw is measured
4. Thermal response is measured
5. Payload is signed and submitted
6. Cloud verifier evaluates consistency
7. System returns PASS or DENY

## What v1 Demonstrates

- cloud can evaluate physical telemetry
- power and heat can be treated as evidence
- trust can move from inferred behavior to measured consequence

## Current Status

Scaffolding in progress:
- repository structure created
- initial verifier logic created
- Terraform environment started
- test rig architecture being defined

## Next Build Targets

- define exact sensor stack
- create simulator payload generator
- wire first challenge/verify loop
- connect test rig readings to cloud-side policy evaluation
