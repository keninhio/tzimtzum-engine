# The Immutable Settings Line

## The string

```
This app cannot protect your time. Only you can do that. We tried to at least not make it worse.
```

This is the canonical English string. It is verbatim. It does not change.

---

## Location in the product

Settings > About > version screen.

Found when looking. Not pushed. Not surfaced on first launch. Not shown in onboarding. Not in tooltips. Not in marketing. Not in loading screens. Not in empty states.

This is the only honest-admission mechanism in the product. There is no second fourth-wall break.

---

## Three-layer enforcement

### Layer 1: String resource key

```
settings_about_immutable_statement
```

The word "immutable" is in the key name. This is intentional — it signals to any future engineer that this string has a different status than normal copy.

### Layer 2: ImmutableStatement component

```typescript
// ImmutableStatement.tsx
//
// This component renders a single string that is load-bearing to the product's
// honesty. It has no text prop by design. The string is not configurable.
// Do not add a text prop. Do not accept children. Do not make this flexible.
//
// Origin: the product's one honest-admission mechanism. See immutable_string.md
// in the product spec. Changing this string requires product lead sign-off.
//
// This is not boilerplate. The component's inflexibility is the point.

import { CANONICAL_SETTINGS_STATEMENT } from '../constants/immutableStrings';

export function ImmutableStatement() {
  return (
    <Text style={styles.statement}>
      {CANONICAL_SETTINGS_STATEMENT}
    </Text>
  );
}

// No props. No variants. No overrides. This component renders one thing.
```

### Layer 3: CI assertion

```typescript
// immutableStrings.constants.ts
//
// DO NOT MODIFY WITHOUT PRODUCT LEAD SIGN-OFF
// These strings are asserted in CI. Drift fails the build.

export const CANONICAL_SETTINGS_STATEMENT =
  "This app cannot protect your time. Only you can do that. We tried to at least not make it worse.";
```

```typescript
// immutableStrings.test.ts

import { CANONICAL_SETTINGS_STATEMENT } from '../constants/immutableStrings';
import { getLocalizedString } from '../i18n';

describe('Immutable settings statement', () => {
  it('English canonical string is exact', () => {
    expect(getLocalizedString('settings_about_immutable_statement', 'en'))
      .toBe(CANONICAL_SETTINGS_STATEMENT);
  });

  // Per-locale assertions. Each locale has its own canonical string.
  // These must be written at translation time and committed to this test file.
  // The test for each locale must be approved by a human who reads that language.
  
  it('Polish translation does not soften make-it-worse', () => {
    const polish = getLocalizedString('settings_about_immutable_statement', 'pl');
    // Canonical Polish string set at translation time. Add it here.
    expect(polish).toBe(CANONICAL_POLISH_SETTINGS_STATEMENT);
  });

  // Add one assertion per locale as translations are added.
  // No locale may drift from its canonical string without updating this test,
  // which requires product lead sign-off.
});
```

---

## Translation guidance

Human-translated per locale. Each translation receives a brief explaining:

1. This is the product's one honest statement about itself.
2. The self-deprecation is the point. "Make it worse" does not soften to "make it harder" or "make it more difficult."
3. The tone is flat, not warm. Not resigned. Not funny. Flat.
4. The phrase "at least" must carry the same weight in the target language — the sense of a low bar proudly held.

Each locale's translation is locked as a constant and CI-asserted. The translator's first version becomes canonical. It does not drift through future localization passes.

---

## What does not exist

- A second honest-admission line anywhere else in the product.
- A version of this line in marketing, onboarding, or loading screens.
- A tooltip that says something similar.
- An A/B test of this line. It is not tested for conversion. It is not optimized.
- A softer version for any audience.
