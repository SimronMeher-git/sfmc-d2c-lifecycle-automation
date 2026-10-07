# Case Study

## Context

This project was built as a self-initiated learning portfolio to close a Salesforce Marketing Cloud capability gap for marketing-technology / functional-consulting roles.

The use case is inspired by common D2C lifecycle patterns: converting new prospects and recovering high-intent abandonment.

## Journey 1

The first-purchase journey begins from a current SQL-generated audience. The audience query filters for identifiable, opted-in contacts with zero orders, below the communication cap, within a recent signup window.

The journey does not treat the entry snapshot as permanent truth. Before marketing sends and after waits, current customer state is re-evaluated. A first purchase is acted on at the next configured decision point after refreshed transaction data is available.

## Journey 2

The canonical design is event driven. An Add_To_Cart or Checkout_Started event is modeled through the Journey Builder REST API. Immutable event context is used for product/cart personalization, while mutable current status is used for consent, frequency and conversion decisions.

Conversion attribution requires:

- same customer
- nonblank matching CartID
- valid event and order timestamps
- order after the triggering event
- COMPLETED order status

A separate current-status structure prevents an older converted event from incorrectly closing a newer unconverted event.

## Governance

The portfolio models a combined send condition across custom consent, platform subscriber/publication state, global suppression, frequency cap and conversion status.

A send ledger and reservation structure illustrate how a strict cross-journey frequency cap would need centralized coordination. The portfolio does not claim that independent Journey Builder splits provide atomic concurrency control.

## API

The Postman collection contains:

1. Server-to-server OAuth token request
2. Journey Builder event request

It uses placeholder credentials only. The collection includes token clearing, response validation, expiry tracking and an event pre-request guard.

## Measurement

The framework separates:

- eligibility from journey admission
- observed conversion from causal incrementality
- event recovery from historical customer purchases
- primary revenue attribution from assisted influence

Causal lift would require a randomized holdout/control design in production.
