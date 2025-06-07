# 📘 CBNU Planner

CBNU Planner is a Flutter-based campus schedule and navigation assistant app for students of Chungbuk National University.  
It allows users to input their daily plans, view campus locations, and get real walking route guidance based on GPS location.

---

## ✨ Features

- 📅 **Schedule Management**  
  - Add, edit, and delete schedule items with zone, place, and time input.  
  - User-friendly and intuitive interface.

- 🗺️ **Map View**  
  - Display the current GPS location with a blue marker.  
  - Show schedule locations with red markers on the map.

- 🧭 **Route Guidance**  
  - Calculate walking routes from the current location to each scheduled place.  
  - Display total walking distance and estimated travel time.  
  - Uses real walking paths via OpenRouteService.

- 🌙 **Dark Mode Support**  
  - Easily switch between light and dark modes with a toggle button.

---

## 🗂️ Project Structure

```
lib/
├── main.dart                      # App entry point
├── pages/
│   ├── schedule_input_page.dart   # Schedule input UI
│   ├── map_page.dart              # Map with current and schedule locations
│   └── map_route_page.dart        # Route guidance view
├── features/
│   ├── schedule/                  # Schedule models and storage
│   └── map/
│       ├── data/                  # Building coordinates
│       └── services/              # Location & routing logic
├── secrets/
│   └── api_keys.dart              # OpenRouteService API key storage
```

---

## 🛠️ Installation

1. Install Flutter SDK (>= 3.10.0) and Dart (>= 3.0.0).
2. Clone the repository:

```bash
git clone https://github.com/JustWSJ/cbnu_planner.git
cd cbnu_planner
flutter pub get
```

3. Create the file `lib/secrets/api_keys.dart` and insert your OpenRouteService API key:

```dart
const openRouteServiceApiKey = 'YOUR_API_KEY_HERE';
```

4. Run the app:

```bash
flutter run   # or flutter run -d chrome for web
```

> **Note:** On iOS, navigate to `ios/` and run `pod install` before launching.

---

## 📦 Dependencies

- Flutter SDK >= 3.10.0  
- Dart >= 3.0.0  
- [flutter_map](https://pub.dev/packages/flutter_map) ^6.1.0  
- [geolocator](https://pub.dev/packages/geolocator) ^10.0.1  
- [latlong2](https://pub.dev/packages/latlong2) ^0.9.0  
- [table_calendar](https://pub.dev/packages/table_calendar) ^3.0.9  
- [http](https://pub.dev/packages/http) ^1.2.1  
- [shared_preferences](https://pub.dev/packages/shared_preferences) ^2.2.2  

> Note: OpenRouteService API key is required. [Get one here](https://openrouteservice.org/dev/#/signup).

---

## ▶️ Usage

- Input schedules on the Schedule Input page.
- View your current location and schedule destinations on the map.
- Follow walking routes to each destination.
- Use the calendar view to track your daily schedule.

---

## ⚠️ Notes

- Real-time location syncing is disabled due to lack of backend.
- Webhook testing is removed to avoid errors.

---

## 💡 Future Ideas

- [ ] Building search bar  
- [ ] Push notifications before schedule time  
- [ ] Weekly/monthly calendar view  
- [ ] Export/share schedules  
- [ ] Firebase or Supabase integration

---

## 👨‍💻 Contributors & Contact

| Name           | Role                      | GitHub                                 |
|----------------|---------------------------|----------------------------------------|
| Junhyeong Lim  | Development & Maintenance | [@0l2jh](https://github.com/0l2jh)     |
| Seungje Woo    | Development & Maintenance | [@JustWSJ](https://github.com/JustWSJ) |
| Minjeong Kim   | UI Design                 | [@minjungE](https://github.com/minjungE) |
| Ahryeong Jang   | UI Design                 | [@ahryeong](https://github.com/ahryeong) |

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🧠 Development Notes

- Follows **PEP8** coding conventions.
- Key classes, functions, and logic blocks include comments.
- Uses logger instead of `print()` for easier debugging.
- Branch management: `main` (stable), `dev` (development).

---
