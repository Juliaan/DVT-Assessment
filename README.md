# DVT-Assessment Project for iOS (by Juliaan Evenwel)

This repository contains my assessment project for DVT.

### Get Started

1. Clone the project to your local environment using terminal or any git client installed on your computer.
   - URL: https://github.com/Juliaan/DVT-Assessment.git
     - Example: git clone https://github.com/Juliaan/DVT-Assessment.git
> [!NOTE]
> Use the main branch.    

2. After cloning the repo, navigate to the location and open the Assessment.xcodeproj with Xcode.
3. Ensure that you have selected the appropriate team under Signing and Capabilities
4. Preverably run the app on a device otherwise if you run the app in a Simulator ensure that you set the location under:
   - With the simulator in focus, go to Features -> Location -> Custom Location... and set your prefered lat and lon values.
  
### Project Summary

The iOS app is written in swift and uses SwiftUI for its views and displaying data. I tried to stick to the MVVM design or architecture pattern.

As required the app is a Weather app that gets it's information from the OpenWeather API and also uses your current location.

#### The app requires location access:

1. The Info.plist contains the Privacy Permission for the While using the app option. This means you will get a alert asking you to enable location when the app runs for the first time.
2.  Without location access the app will display a view asking you to grant access. A settings button is provided and when testing on an actuall device it will open the settings app and show the apps settings. Location can be enabled there if it was not granted on first launch.
3.  When making calls to OpenWeather, we require an API key. The API_Key is stored as a custom build setting and is retrieved from the Info.plist file at runtime.

#### The app makes two API calls:

1. Current Weather
   - https://api.openweathermap.org/data/2.5/weather?lat={latitude}&lon={longitude}&units=metric&appid={my_apiKey}
2. Forecast
   - https://api.openweathermap.org/data/3.0/onecall?lat={latitude}&lon={longitude}&exclude=minutely,hourly&units=metric&appid={my_apiKey}

> [!NOTE]
> For current weather, it seems like the OpenWeather API returns the same value for min and max tempratures.
