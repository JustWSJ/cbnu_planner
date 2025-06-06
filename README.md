# CBNU Planner

A Flutter app for managing campus schedules at Chungbuk National University. It lets you record daily plans, view them on a campus map and get walking routes between locations.

## Features

- **Schedule Management** – add, edit and delete schedule items using `ScheduleInputPage` with inputs for time and building.
- **Map View** – see current location and schedule markers on the map via `MapPage`.
- **Route Planner** – calculate walking directions for a sequence of schedule stops with `MapRoutePage` and `RouteService`.
- **Local Storage** – schedules are persisted using `SharedPreferences` through `ScheduleStorage`.

## Project Structure

- `lib/main.dart` – app entry point.
- `lib/pages/home_page.dart` – bottom navigation between schedule and map tabs.
- `lib/features/schedule` – models, widgets and services for schedule input and list UI.
- `lib/features/map` – building data, map/route pages and location utilities.
- `lib/secrets/api_keys.dart` – contains the OpenRouteService API key.

## Getting Started

1. Install Flutter (>= 3.0). Run `flutter pub get` to fetch packages.
2. Supply your OpenRouteService API key in `lib/secrets/api_keys.dart`.
3. Launch with `flutter run` on your preferred device or emulator.

> **Note**: The branch `branch_Demo` is an early test branch and should never be merged.