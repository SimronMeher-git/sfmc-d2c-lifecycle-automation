# Validation and QA

This portfolio intentionally distinguishes simulation from native SFMC execution.

## Current evidence model

- **Data-check pass:** source rows and SQL output can be reproduced locally.
- **Formula-simulation pass:** spreadsheet formulas reproduce the expected logical branch.
- **Manual walkthrough:** timestamps and state transitions are documented coherently but are not an executable journey engine.
- **Design example:** demonstrates the proposed rule but does not independently calculate or enforce it.
- **Live UAT pending:** requires a configured Salesforce Marketing Cloud tenant.

## Representative cases

| Case | Evidence | Expected behavior |
|---|---|---|
| First-purchase eligible prospect | Data check | Included in current Journey 1 audience |
| Opted-out prospect | Data check | Excluded |
| Frequency-capped prospect | Data check | Excluded |
| Opt-out during Journey 2 two-hour wait | Formula simulation | Reminder 1 suppressed |
| Exact EventID matches unconverted current event | Formula simulation | Continue |
| EventID mismatch | Formula simulation | Fail closed / suppress |
| Same customer + same nonblank CartID + later COMPLETED order | Formula simulation | Convert |
| Same customer + unrelated CartID | Formula simulation | Do not convert |
| Cancelled matching-cart order | Formula simulation | Do not convert |
| Cross-journey final slot reservation | Design simulation | Higher-priority abandonment send wins |
| Full Journey 1 → Journey 2 lifecycle | Manual timestamped walkthrough | Coherent lifecycle, not native execution |
| Invalid EventDefinitionKey | Live UAT pending | Must be verified in a real SFMC tenant |
| Payload/schema rejection | Live UAT pending | Must be verified in a real SFMC tenant |

The working project contains a larger internal QA matrix. This public repo avoids presenting local spreadsheet checks as proof of native Journey Builder or API behavior.
