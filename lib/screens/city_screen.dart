import 'package:clima/services/weather.dart';
import 'package:clima/utilities/basic_alert.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  WeatherModel weatherModel = WeatherModel();
  String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (cityName != null && cityName.isNotEmpty) {
                    var weatherData =
                        await weatherModel.getCityWeather(cityName);

                    if (weatherData == null) {
                      BasicAlert(
                              context: context,
                              desc:
                                  "Nothing found. Control place name that you entered.")
                          .show();
                    } else
                      Navigator.pop(context, weatherData);
                  } else {
                    BasicAlert(
                            context: context,
                            desc: "You didn't enter anything in the search bar")
                        .show();
                  }
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
