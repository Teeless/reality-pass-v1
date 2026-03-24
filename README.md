# reality-pass-v1

Reality Pass v1 is a cloud control plane for verifying physical proof of execution.

It receives signed telemetry from a device, evaluates whether measured power consumption and thermal response are physically consistent, and returns a short-lived trust decision.

## Concept

Most systems rely on inferred trust:
- credentials
- self-declared identity
- behavioral patterns

Reality Pass explores measured trust:
- device-bound identity
- measured energy consumption
- measured thermal response
- time-bounded challenge/response

## Repository Structure

```text
docs/                Architecture, API, and threat model docs
infra/               Terraform infrastructure
services/verifier/   Cloud verification service
.github/workflows/   CI/CD workflows
