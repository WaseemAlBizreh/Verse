# Flutter Development System Prompt (Cursor)

You are working on a Flutter production application.
**All generated code must strictly follow the rules below.**
If a requirement cannot be met, you must explicitly mention it.

Use this document when **creating or editing pages/screens** and any Flutter UI or feature code.

---

## UI & Design Rules

### Responsive Design

- All screens must be **fully responsive**.
- Support different screen sizes and orientations.
- Prefer using:
  - `LayoutBuilder`
  - `MediaQuery (use AppSize.sHeight and AppSize.sWidth)`
  - Existing responsive helpers in `lib/core/ui/extensions/` (e.g. `media_extension.dart`).

### Theme & Text Styling

- **Never hardcode font sizes or text styles.**
- Always use:
  - `Theme.of(context).textTheme`
- Creating custom `TextStyle` inside UI is **not allowed** unless absolutely necessary.

### Colors

- **Never hardcode colors.**
- Do **not** use `Colors.*` or hex values in UI.
- Always use colors from:
  - **`lib/core/ui/resources/color_manager.dart`**

### Assets

- All images, icons, and SVGs must be referenced via:
  - **`lib/core/ui/resources/asset_manger.dart`**
- Direct asset paths inside UI are **forbidden**.

---

## Localization

- The app uses **easy_localization**.
- All user-facing text must be localized using:
  - **`'key_name'.tr()`**
- Hardcoded strings are **strictly forbidden**.
- Add keys to `assets/translations/en.json` (and other locale files) as needed.

---

## Reusable Components

- Any widget used **more than once** must be placed in:
  - **`lib/core/ui/widgets/`**
- UI screens must remain **clean and minimal**.
- Avoid duplicated UI logic across screens.

---

## Utils Usage

- Helper logic (formatters, validators, date helpers, etc.) must be placed in:
  - **`lib/core/utils/`**
- No helper or utility logic is allowed **directly inside UI widgets**.

---

## State Management

### Cubit & Bloc

- State management must use:
  - **Cubit**
  - **BlocProvider**
- Avoid `setState` for business logic.
- Each screen should have its own **Cubit** unless logic is shared intentionally.
- Cubits live in the feature’s **`presentation/cubit/`** folder.

---

## Networking Rules

### Network Service

- All API calls must go through:
  - **`lib/core/services/network_service/api_service.dart`**
- Direct usage of **Dio** or **HTTP** inside UI, Cubit, or Repository is **not allowed**.

### App Response

- All API responses must be wrapped using:
  - **`AppResponse<T>`** from **`lib/core/models/app_response.dart`**
- Handle **success**, **error**, and **loading** states consistently across the app.

---

## Clean Architecture Enforcement

| Layer | Responsibility | Must NOT contain |
|-------|----------------|-------------------|
| **Data Source (DS)** | API calls, response parsing only | Business logic |
| **Repository** | Abstraction over Data Sources; data mapping, error handling; used only by Cubits | — |
| **Presentation** | UI + Cubit only | Network logic, parsing logic, business rules |

- **No layer skipping**: UI must not call Data Source directly (UI → Cubit → Repository → Data Source).

---

## Hard Rules (Do Not Violate)

| Do not | Do instead |
|--------|------------|
| Hardcode colors, text, or assets | Use `ColorManager`, `AssetManager`, `'key'.tr()` |
| Put network calls in UI | Use Cubit → Repository → Data Source |
| Put business logic inside widgets | Use Cubit / utils |
| Skip layers (e.g. UI → Data Source) | Follow Cubit → Repository → Data Source |
| Duplicate widgets | Extract to `lib/core/ui/widgets/` |

---

## Final Goal

All code must be:

- **Clean**
- **Scalable**
- **Secure**
- **Maintainable**
- **Production-ready**

If any generated code violates these rules, it **must be refactored immediately**.

---

## Quick Path Reference

| Purpose | Path |
|--------|------|
| Colors | `lib/core/ui/resources/color_manager.dart` |
| Assets | `lib/core/ui/resources/asset_manger.dart` |
| Theme / text | `lib/core/ui/resources/theme_manager.dart`, `Theme.of(context).textTheme` |
| Reusable widgets | `lib/core/ui/widgets/` |
| Utils | `lib/core/utils/` |
| Network | `lib/core/services/network_service/api_service.dart` |
| Response wrapper | `lib/core/models/app_response.dart` |
| Localization | `'key'.tr()`, `assets/translations/` |
