# /create-feature Workflow

## Trigger
Use this workflow when asked to create a new feature.

## Pre-flight
- [ ] Read lib/features/ — find similar feature as reference
- [ ] Read lib/core/locator/ — understand DI pattern
- [ ] Read lib/core/Router/app_router.dart — understand routes
- [ ] Check lib/core/common/widgets/ for reusables
- [ ] Confirm feature name (PascalCase) and folder (snake_case)

## Steps (in order)

### Step 1 — Folder Structure
Create under lib/features/{{feature_folder}}/:
  cubit/, data/model/, data/repo/, data/data_source/,
  di/, router/, presentation/views/, presentation/sections/, presentation/widgets/

### Step 2 — Data Layer
1. Model (fromJson, toJson, copyWith)
2. Abstract Repo interface
3. RemoteDataSource — ApiConsumer injection, MOCK data + // TODO: real API
4. Repo implementation — calls DataSource only

### Step 3 — Cubit
1. States (sealed/abstract, Initial/Loading/Success/Error)
2. Cubit (injects Repo, uses ApiResult fold pattern)

### Step 4 — DI
1. feature_di.dart with GetIt registrations
2. Import and call it in lib/core/locator/

### Step 5 — Router
1. feature_router.dart with GoRoute entries
2. Register in lib/core/Router/app_router.dart

### Step 6 — Presentation (stub only)
1. Views: empty Scaffold + BlocProvider
2. Sections: empty stubs
3. Widgets: empty stubs

### Step 7 — Verify
- dart analyze → zero errors
- dart format .
- Confirm DI registered, routes reachable

## Architecture Rules
- View: sections only, no logic, no styling
- Section: logic bridge, BlocBuilder+buildWhen, no styling
- Widget: pure UI, const constructor, data via params only