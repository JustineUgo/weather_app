# 🌦️ Flutter Weather App

This Flutter application fetches and displays current weather data for cities in Nigeria using the [OpenWeatherMap API](https://openweathermap.org/current). Users can view weather for selected cities, manage their list, and see weather based on their current location.

---

## 📱 Features

- 📍 Get weather using current device location
- 🏙️ View weather for 15 predefined Nigerian cities (Lagos, Abuja, Port Harcourt, etc.)
- ➕ Add or remove cities to/from your custom weather view
- 💾 Persist selected cities using SharedPreferences
- 🎠 Tab/Carousel UI for browsing weather per city
- 🔒 API key and base URL stored securely using `.env` file

---

## 🛠️ Setup Instructions

### 1. 🔑 Environment Variables (Required)

This project uses **environment variables** to securely manage sensitive data like the API key and base URL.

#### 🔐 Step-by-step to replicate:

1. Create a file named `.env` at the root of the project:
   ```env
   API_KEY=your_openweathermap_api_key
   BASE_URL=https://api.openweathermap.org/data/2.5
    ```
 
✅ Don't forget to add .env to .gitignore so it's not committed to version control.

---

📦 Install Dependencies
    ```env
    flutter pub get
    ```
---

▶️ Run the App
    ```env
    flutter run
    ```

---

🧪 Run Tests
    ```env
    flutter test
    ```
    
---

📂 Assets
The app uses a local JSON file to store the 15 Nigerian cities.

Example snippet from assets/ng.json:

    ```env
    [
    {
        "city": "Lagos",
        "lat": "6.4550",
        "lng": "3.3841",
        "country": "Nigeria"
    }
    ]
    ```

Ensure this file is listed in your pubspec.yaml:

    ```env
    flutter:
    assets:
        - assets/ng.json
    ```
    
    
🛠️ Tech Stack
    * Flutter
    * BLoC (flutter_bloc)
    * Dio for HTTP requests
    * Geolocator for location services
    * Shared Preferences for local persistence
    * flutter_dotenv for secure config handling
    * Mocktail for unit testing
