# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
flutter pub get

# Run locally in Chrome (primary target platform)
flutter run -d chrome

# Production build for GitHub Pages (base-href must match repo name)
flutter build web --release --base-href "/portfolio/"

# Copy build output to docs/ for manual GitHub Pages deployment
cp -r build/web/* docs/

# Lint
flutter analyze

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart
```

## Architecture

This is a **Flutter Web** portfolio — a single-screen, single-route app. There is no routing library; navigation is purely in-page scroll via `GlobalKey` + `Scrollable.ensureVisible`.

### Content data

All portfolio data (bio, experience, projects, skills, education, certifications, achievements) lives in one place: **`lib/utils/constants.dart`** (`AppConstants`). To update any portfolio content, edit that file — the widgets render directly from its static lists.

Two fields in `AppConstants` need attention:
- `resumeUrl` is currently empty — the Resume and "Download Resume" buttons fall back to `mailto:` until a hosted PDF URL is added.
- `githubUrl` is `"https://github.com/"` with no username path — update it to a real profile URL.

### Screen structure (`lib/screens/portfolio_home.dart`)

`PortfolioHome` is the only screen. It owns a `ScrollController` and a `GlobalKey` per section. The `_navigateTo(String)` method maps nav label strings to their keys.

**Nav label → scroll target quirks** (non-obvious, easy to get wrong):
- `'Projects'` in the navbar scrolls to `_achievementsKey` (the Key Achievements section), not a separate projects section.
- `'About'` and `'Education'` sections exist in the scroll column but have **no navbar entry** — they are only reachable by scrolling.
- Scroll column order: Hero → About → Skills → Experience → Achievements → Certifications → Education → Contact. This differs from the navbar order.

The layout is a `Stack` with:
- Decorative background layers (`_DotPainter`, `_GlowOrb`) rendered with `IgnorePointer`
- A `SingleChildScrollView` containing a `Column` of private section widgets, all constrained to `maxWidth: 1100` and centered
- A sticky navbar overlay using `BackdropFilter` blur

**Responsive breakpoints**: `w > 1024` = desktop (side-by-side layouts), `w < 600` = mobile (stacked layouts). The range 600–1024 falls back to tablet/desktop-style padding.

The hero section's code widget (`_CodeSnippet`) is **hardcoded Java** — to change its content, edit that private class directly in `portfolio_home.dart`. The avatar is also hardcoded as the text "AJ" with no image asset.

The contact form (`_ContactForm`) has **no backend** — clicking "Send Message" opens the user's email client via `mailto:` with the form fields pre-filled as the body.

### Animation system

Two libraries serve different purposes:
- **`flutter_animate`**: Initial page-load animations (`.animate().fadeIn().slideX()` etc.) chained on widgets in the Hero/Navbar
- **`animate_do` + `visibility_detector`**: Scroll-triggered entrance animations — wrap any widget in `Entrance(id: 'unique-id', child: ...)` from `components.dart`; it fires `FadeInUp` once when the widget first enters the viewport. **Each `id` must be globally unique** — duplicate ids cause `VisibilityDetector` to behave incorrectly across the page.
- **`animated_text_kit`**: Typewriter cycling through `AppConstants.heroRoles` in the hero section

### Theme and styling

- **Colors**: `lib/theme/app_colors.dart` — `primary` is Electric Indigo `#6C63FF`, `accent` is Cyan `#00D4FF`. Skill category colors are named `catBackend`, `catMobile`, etc.
- **Theme**: `lib/theme/app_theme.dart` — dark-only `ThemeData`; headings use Google Fonts *Space Grotesk*, body text uses *Inter*, monospace labels use *DM Mono*.
- **Reusable widgets** (`lib/widgets/components.dart`): `GlassCard` (primary content container with `BackdropFilter` blur), `SectionTitle`, `SkillChip`, `PrimaryButton`, `OutlineBtn`, `SocialButton`, `AnimatedCounter`, `Entrance`

### Web-only dependency

`lib/widgets/linkedin_embed.dart` uses `dart:html` and `dart:ui_web` to render LinkedIn post iframes. It **only compiles for the web target**, is not currently used in the main screen, and will fail on mobile/desktop builds if imported.

`flutter_svg` is declared in `pubspec.yaml` but is not currently used anywhere in the source.

### Deployment

- **CI/CD**: Push to `master` triggers `.github/workflows/gh-pages.yml`, which builds with `--base-href "/portfolio/"` and deploys to the `gh-pages` branch.
- **Manual**: Build web, then run `cp -r build/web/* docs/` — the `docs/` directory is a committed snapshot used for alternate GitHub Pages hosting from `master`.
