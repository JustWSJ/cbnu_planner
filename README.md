# 📘 CBNU Planner

CBNU Planner is a Flutter-based campus schedule management app designed for students at Chungbuk National University.  
It allows users to input their daily plans, view locations on a campus map, and get walking routes based on real positions.

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
│   └── home_page.dart             # Theme toggle & bottom navigation
├── features/
│   ├── schedule/                  # Schedule models, storage, UI
│   └── map/
│       ├── pages/                 # Map view & route pages
│       ├── data/                  # Building coordinates
│       └── services/              # Location & route services
├── secrets/
│   └── api_keys.dart              # Contains OpenRouteService API key
```

---

## 🚀 Getting Started

1. Install Flutter SDK (version >= 3.0).
2. Run:

```bash
flutter pub get
```

3. Create the file `lib/secrets/api_keys.dart` and add your API key:

```dart
const openRouteServiceApiKey = 'YOUR_API_KEY_HERE';
```

4. Launch the app:

```bash
flutter run
```

---

## ⚠️ Notes

- The real-time location transmission feature has been **disabled** due to the lack of backend support.
- Webhook testing has been removed to prevent errors.

---

## 💡 Future Ideas

- [ ] Building search bar  
- [ ] Push notifications before schedule time  
- [ ] Weekly/monthly calendar view  
- [ ] Export/share schedules  
- [ ] Firebase or Supabase integration

---

## 👨‍💻 Developer

- JustWSJ @ Chungbuk National University, Computer Engineering 
- 0l2jh @ Chungbuk National University, Computer Engineering 
- minjungE @ Chungbuk National University, Computer Engineering 
- jsr128989 @ Chungbuk National University, Computer Engineering 
- Developed as part of an open-source project course  
- Feedback and contributions are welcome!