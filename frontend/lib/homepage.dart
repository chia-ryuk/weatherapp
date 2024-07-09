import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/prefapi.dart';
import 'package:frontend/prefmodel.dart';
import 'package:frontend/weathermodel.dart';

/// The [Homepage] widget is a stateful widget that displays the main interface of the weather application.
/// It allows users to search for weather information by entering a city name.

class Homepage extends StatefulWidget {
  /// Creates a [Homepage] widget.
  /// The [super.key] parameter is passed to the [StatefulWidget] constructor.

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

/// The [_HomepageState] class manages the state for the [Homepage] widget.
/// It handles user input, fetches weather data, and displays it.

class _HomepageState extends State<Homepage> {
  /// Stores the weather response from the API.
  WeatherResponse? response;

  /// Indicates whether a weather data fetch is in progress.
  bool inProgress = false;

  /// Stores the current location.
  String _location = "NA1";

  /// Message to be displayed when no weather data is available.
  String message = "Enter city name to get the weather details";

  @override
  Widget build(BuildContext context) {
    _getLastLocation();
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchWidget(),
            const SizedBox(
              height: 20,
            ),
            if (inProgress)
              CircularProgressIndicator()
            else
              Expanded(
                  child: SingleChildScrollView(child: _getWeatherWidget())),
          ],
        ),
      ),
    ));
  }

  /// Builds the search widget for entering a city name.
  /// The [SearchBar] widget takes user input and triggers the weather data fetch.

  Widget _buildSearchWidget() {
    return SearchBar(
      hintText: "Enter city name",
      onSubmitted: (value) {
        setState(() {
          _location = value;
        });
        _updateLastLocation();
        _getWeatherData();
      },
    );
  }

  /// Builds the weather widget to display weather information.
  /// If no weather data is available, it displays a message. Otherwise, it shows the weather details including location, temperature, condition, and additional weather information.

  Widget _getWeatherWidget() {
    if (response == null) {
      return Text(message);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.location_on,
                size: 50,
                color: Colors.black,
              ),
              Text(
                response?.location?.name ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${response?.current?.tempC.toString() ?? ""} °c",
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                response?.current?.condition?.text.toString() ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Center(
            child: SizedBox(
              height: 200,
              child: Image.network(
                "https:${response?.current?.condition?.icon}"
                    .replaceAll("64*64", "128*128"),
                scale: 0.7,
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("Humidity",
                        response?.current?.humidity?.toString() ?? ""),
                    _dataAndTitleWidget("Wind Speed",
                        "${response?.current?.windKph?.toString() ?? ""}km/hr"),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      color: Colors.black,
                      onPressed: () {
                        _getWeatherData();
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    }
  }

  /// Fetches weather data for the specified [location].
  /// This method updates the [inProgress] flag, sends a request to the weather API, and updates the [response] and [message] based on the result.
  /// If the request fails, it sets an error message.

  _getWeatherData() async {
    setState(() {
      inProgress = true;
    });
    try {
      response = await WeatherAppApi().getCurrentWeather(_location);
    } catch (e) {
      setState(() {
        message =
            "Whoops, we failed to get the weather details. Please try again.";
        response = null;
      });
      throw Exception("");
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }

  /// Fetches the last opened location from a backend API

  _getLastLocation() async {
    if (_location == 'NA1') {
      print("Initial -1 ");
      try {
        PreferredLocationResponse? wl =
            await WeatherAppLocationApi().getPreferredLocation();
        print("Initial -2 ");
        _location = wl.data?.toString() ?? "NA";
      } catch (e) {
        //throw Exception("");
        _location = 'NA';
      } finally {
        if (_location != 'NA') {
          _getWeatherData();
        }
      }
    }
  }

  _updateLastLocation() async {
    WeatherAppLocationApi().updatePreferredLocation(_location);
  }

  /// Builds a widget to display a title and its corresponding data.
  /// The [title] parameter specifies the title of the data (e.g., "Humidity").
  /// The [data] parameter specifies the actual data to be displayed.
  ///
  Widget _dataAndTitleWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            data,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
