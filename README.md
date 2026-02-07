# Verse

A Flutter application for movies and entertainment content.

---

## How to Run the Project

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.10.4 or higher)
- Dart 3.10.4+

### Setup & Run

```bash
# Clone the repository (if not already done)
git clone <repository-url>
cd verse

# Install dependencies
flutter pub get

# Generate route and dependency injection code (auto_route, injectable)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

For a specific device:

```bash
flutter devices          # List available devices
flutter run -d <device>  # Run on selected device
```

### Build for Release

```bash
flutter build apk        # Android APK
flutter build ios        # iOS (requires macOS)
flutter build web        # Web
```

---

## Architectural Choices

The project follows **Clean Architecture** with clear separation of concerns:

### Layered Structure

| Layer | Location | Responsibility |
|-------|----------|----------------|
| **Presentation** | `lib/features/*/presentation/` | UI (pages, widgets) + Cubit (state) |
| **Domain** | `lib/features/*/domain/` | Repository contracts (abstract interfaces) |
| **Data** | `lib/features/*/data/` | Data sources (API), repository implementations, feature models |

**Data flow:** UI → Cubit → Repository → Data Source → API

- **No layer skipping** — the UI never calls data sources directly.
- **Data Source** — handles API calls and response parsing only.
- **Repository** — maps data, handles errors, returns `Either<Failure, T>` via `dartz`.
- **Cubit** — business logic, emits states, orchestrates repository calls.

### Key Technologies

- **State management:** Flutter Bloc / Cubit (one Cubit per screen/feature)
- **Dependency injection:** `get_it` + `injectable` (code generation)
- **Routing:** `auto_route` (declarative, type-safe routing)
- **Networking:** `dio` via centralized `ApiService`; all responses wrapped in `AppResponse<T>`
- **Localization:** `easy_localization`; all user-facing text via `'key'.tr()`
- **Theme & styling:** Centralized `ColorManager`, `AssetManager`, `Theme.of(context).textTheme` — no hardcoded colors, assets, or font sizes in UI

### API Implementation Workflow

1. Add endpoint in `lib/core/services/network_service/end_points.dart`
2. Implement API call in feature's `data/data_source/*_remote_ds.dart` using `ApiService`
3. Implement repository in `data/repositories/*_repo_imp.dart`; map to domain models, return `Either`
4. Add Cubit methods and state; handle loading, success, empty, and error

---

## Responsive Layout

The app supports different screen sizes and orientations using:

### 1. `AppSize` (Adaptive Sizing)

`lib/core/ui/resources/values_manager.dart` provides adaptive values:

- **`AppSize.sWidth`** / **`AppSize.sHeight`** — full screen dimensions
- **`AppSize.s8`**, **`AppSize.s16`**, etc. — spacing and sizes that scale with screen width

Sizing is based on a reference width of 375px, with a scale factor clamped between 0.8 and 1.4 to avoid extreme scaling.

### 2. MediaQuery

- **`MediaQuery.sizeOf(context).width`** / **`MediaQuery.sizeOf(context).height`** for layout logic (e.g. carousel width, breakpoints)
- **`MediaQuery.of(context).viewInsets.bottom`** for keyboard-aware layouts (e.g. bottom sheets, toasts)

### 3. LayoutBuilder

Used where layout depends on available constraints (e.g. `custom_drop_down_field.dart` for flexible dropdown sizing).

### 4. Breakpoints

- `root_page.dart` uses `MediaQuery.sizeOf(context).width >= _kWebBreakpoint` to switch between mobile and web layouts (e.g. drawer vs navigation bar).

### 5. Text Scaling

- `TextScaler.linear(1.0)` in `main.dart` to keep text size consistent regardless of system accessibility settings (can be adjusted if needed).

---

## Optimistic UI Logic & Loading States

The app uses **per-API loading states** and **shimmer placeholders** to keep the UI responsive and give immediate feedback.

### Per-API Loading States

Instead of a single global loading flag, each API has its own loading state:

- **Example:** `slidersLoadingState`, `moviesLoadingState` in `HomeState`
- Each API has its own Cubit method (`getSliders()`, `getMovies()`)
- `getHomeData()` runs both in parallel via `Future.wait()`, but each section updates independently

This provides:

- **Progressive loading** — sliders can appear while movies are still loading
- **Targeted error handling** — one failing API does not block the whole screen
- **More accurate UI** — each section shows its own loading, content, empty, or error state

### Shimmer Instead of Blocking Spinners

When `loadingState == LoadingState.loading` (or `idle`), the UI shows:

- **Shimmer placeholders** (e.g. `SliderShimmerWidget`, `TopMoviesShimmerWidget`) that mirror the final layout
- Colors from `ColorManager.shimmerBaseColor` and `ColorManager.shimmerHighlightColor`

This gives immediate visual feedback instead of a blocking spinner.

### Per-Section BlocBuilder

Each section uses its own `BlocBuilder` that switches on that section’s loading state:

```dart
// Sliders section
BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    switch (state.slidersLoadingState) {
      case LoadingState.loading: return SliderShimmerWidget();
      case LoadingState.doneWithData: return SliderCarouselWidget(...);
      // ...
    }
  },
),
// Movies section (independent)
BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    switch (state.moviesLoadingState) {
      case LoadingState.loading: return TopMoviesShimmerWidget();
      case LoadingState.doneWithData: return TopMoviesSectionWidget(...);
      // ...
    }
  },
),
```

### Pull-to-Refresh

`RefreshIndicator` calls `getHomeData()`, which reloads both sliders and movies. Each section still updates based on its own loading state.

---

## Development Rules

When creating or editing pages/features, follow the rules in **[docs/FLUTTER_DEVELOPMENT_RULES.md](docs/FLUTTER_DEVELOPMENT_RULES.md)** and the Cursor rules in `.cursor/rules/`:

- Responsive layout, theme, colors, assets
- Localization (no hardcoded strings)
- Clean architecture (no layer skipping)
- Per-API loading states and shimmer for loading

---

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── config/          # DI, app config
│   ├── error/           # Error types & helpers
│   ├── models/          # Shared models (AppResponse, LoadingState, etc.)
│   ├── services/        # Network, cache, permissions
│   └── ui/              # Extensions, resources, routes, reusable widgets
└── features/
    └── home/
        ├── data/        # Data sources, repositories, models
        ├── domain/      # Repository contracts
        └── presentation/
            ├── cubit/
            ├── pages/
            └── widgets/
```
