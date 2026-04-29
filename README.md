# Flight Booking App

A complete Flutter-based Flight Booking Application with search capabilities, advanced filtering, and a unified printable boarding pass view. 

## Steps to Run the Project

1. **Clone the repository**:
   ```bash
   git clone https://github.com/rncgopalgupta-bit/FlightBookingApp.git
   ```
2. **Navigate to the directory**:
   ```bash
   cd flightbookingapp
   ```
3. **Get dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

## Dependencies Used

- **get** (^4.7.3): For simple route management and navigation.
- **provider** (^6.1.5+1): For handling internal state management (e.g. `HomeProvider`, `FlightResultProvider`, `FlightDetailProvider`).
- **dio** (^5.9.2): For robust network requests, structured API fetching, and error handling.
- **flutter_secure_storage** (^10.0.0): For secure storage of tokens and configuration if required.
- **loading_animation_widget** (^1.3.0): Used to render smooth loading indicators.
- **intl** (^0.18.1): Used for formatting dates and text inside the application.
- **flutter_svg** (^2.0.7): For rendering scalable vector graphics like barcodes and SVG icons perfectly.

## Approach and Thought Process

- **State Management**: Chosen `Provider` for separating business logic from the UI. A global `HomeProvider` handles common selections, while screen-specific providers (`FlightResultProvider`, `FlightDetailProvider`) scope logic to their specific contexts. 
- **Networking**: Built a highly scalable networking architecture using `Dio`. API endpoints, models, and JSON serialization are decoupled into `NetworkRepo` and specific model classes (`FlightDetailModel`, `AirlineModel`, etc.).
- **UI Architecture**: Implemented custom visual UI layouts using `PhysicalShape` and custom clipping (`TicketClipper`) to recreate the physical aesthetic of airline tickets natively in Flutter, rather than relying on external image assets.
- **Advanced Filtering**: Leveraged a modal bottom sheet allowing users to perform complex server-side filtering without heavy page transitions, maintaining a smooth UX.
- **Environment Support**: Added isolated environment constants (dev/staging/prod) to allow seamless deployment switches.

## Approximate Time Taken

- Setup, Architecture, and Base Networking: ~2 hours
- Complex UI Views (Custom Clippers, Ticket aesthetics): ~3 hours
- State Management & Advanced Filter Integration: ~1 hours
- Polish and Refactoring: ~1 hours
**Total**: ~7 Hours

## Links

- **GitHub Repository**: https://github.com/rncgopalgupta-bit/FlightBookingApp.git
- **APK File**: The APK file is located in `build/app/outputs/flutter-apk/app-release.apk`
