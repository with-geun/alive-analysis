# Hints: ASK Stage

## Level 1 (Direction)
Six things changed in the same week. A hypothesis tree is not optional here — list every plausible cause before touching any data. Think: internal changes, external events, data artifacts.

## Level 2 (Specific)
Your hypothesis tree should have at least three branches: (1) internal product/infra changes (v3.2 app update, push migration, loyalty tier change), (2) external factors (Lunar New Year, competitor launch, snowstorm), (3) data artifacts (bot filter, GA4 migration). Don't collapse these into one or two guesses.

## Level 3 (Near-answer)
Full hypothesis tree with 8+ branches:
```
Main question: "Why did DAU drop 15% WoW starting Feb 3?"
├── Internal factors
│   ├── App update v3.2 (Feb 2) — new navigation may have confused users
│   ├── Push notification system migration (Feb 1-3) — delivery may have broken
│   └── Loyalty tier change (Jan 28) — downgraded users may have churned
├── External factors
│   ├── Lunar New Year (Feb 1-4) — expected seasonal dip
│   ├── QuickBuy competitor launch — user migration to rival app
│   └── Seoul snowstorm — localized usage change
└── Data artifacts
    ├── New bot filtering (Feb 3) — legitimate sessions may have been removed
    └── GA4 migration (Feb 1) — tracking gap may look like a DAU drop
```
Success criteria: Can state what % of the drop is explained and what action is recommended, with confidence levels.
