# Flutter Weather ⛅️

This is a simple Flutter application used as a basis to build upon in a pair programming session.

## Current architecture

We have a running app that grabs your current location and presents the local weather. Nice, things are lookin' bright ☀️

## Goals

We'd like to be able to see the forecast for the next 6 days. But when we navigate to our forecast screen, we no longer have our location data.

Things just became a little cloudy ☁️

Objectives:

- [ ] Fix the WeatherModel issue on Forecast Page
- [ ] Fix the layout issue on ForecastPage

Extra:

- [ ] The forecast response data is a list of hourly results; we need to convert it into **1 per day**.

## Info

Getting current weather data

### Current weather

[Current weather data resource](https://openweathermap.org/current)

```
POST: https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

Response:
200
{
  "coord": {
    "lon": -122.08,
    "lat": 37.39
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 282.55,
    "feels_like": 281.86,
    "temp_min": 280.37,
    "temp_max": 284.26,
    "pressure": 1023,
    "humidity": 100
  },
  "visibility": 10000,
  "wind": {
    "speed": 1.5,
    "deg": 350
  },
  "clouds": {
    "all": 1
  },
  "dt": 1560350645,
  "sys": {
    "type": 1,
    "id": 5122,
    "message": 0.0139,
    "country": "US",
    "sunrise": 1560343627,
    "sunset": 1560396563
  },
  "timezone": -25200,
  "id": 420006353,
  "name": "Mountain View",
  "cod": 200
}
```

### Forecast

[5 day / 3 hour forecast resource](https://openweathermap.org/forecast5)

```
GET: https://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}

Response:
200
{
  "cod": "200",
  "message": 0,
  "cnt": 40,
  "list": [
    {
      "dt": 1647345600,
      "main": {
        "temp": 286.88,
        "feels_like": 285.93,
        "temp_min": 286.74,
        "temp_max": 286.88,
        "pressure": 1021,
        "sea_level": 1021,
        "grnd_level": 1018,
        "humidity": 62,
        "temp_kf": 0.14
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "overcast clouds",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 85
      },
      "wind": {
        "speed": 3.25,
        "deg": 134,
        "gust": 4.45
      },
      "visibility": 10000,
      "pop": 0,
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2022-03-15 12:00:00"
    },
    {
      "dt": 1647356400,
      "main": {
        "temp": 286.71,
        "feels_like": 285.77,
        "temp_min": 286.38,
        "temp_max": 286.71,
        "pressure": 1021,
        "sea_level": 1021,
        "grnd_level": 1017,
        "humidity": 63,
        "temp_kf": 0.33
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "overcast clouds",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 90
      },
      "wind": {
        "speed": 3.34,
        "deg": 172,
        "gust": 4.03
      },
      "visibility": 10000,
      "pop": 0,
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2022-03-15 15:00:00"
    },

    ...

 ],
  "city": {
    "id": 2643743,
    "name": "London",
    "coord": {
      "lat": 51.5073,
      "lon": -0.1277
    },
    "country": "GB",
    "population": 1000000,
    "timezone": 0,
    "sunrise": 1647324903,
    "sunset": 1647367441
  }
}
```

## Retro

What would you do differently given infinitely more time?

How would you improve the project structure?

What do you think could be improved?

