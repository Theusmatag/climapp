import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/weather_api.dart';

class DayDetails extends StatefulWidget {
  final List day;

  const DayDetails({Key? key, required this.day}) : super(key: key);

  @override
  State<DayDetails> createState() => _DayDetailsState();
}

class _DayDetailsState extends State<DayDetails> {
  int count = 0;

  List day = [];

  Widget _weatherInfoBuilder(
      String header, String body, String icon, double size) {
    return Container(
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: Colors.white24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/$icon.gif'),
                ),
              ),
              height: 30,
              width: 30,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  body,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
              FittedBox(
                child: Text(
                  header,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<WeatherProvider>(context).sevenDays[0];
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _weatherInfoBuilder(
                      'Umidade',
                      widget.day.isEmpty
                          ? '${data.humidity}%'
                          : ' ${widget.day[0]['humidity']}%',
                      'icon-weathe',
                      size.width * 0.42),
                  _weatherInfoBuilder(
                      'UV',
                      widget.day.isEmpty
                          ? '${data.uvi}'
                          : ' ${widget.day[0]['uvi']}',
                      'sol',
                      size.width * 0.42),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _weatherInfoBuilder(
                      'Vento',
                      widget.day.isEmpty
                          ? '${data.windSpeed} km/h'
                          : ((widget.day[0]['wind_speed'] as num) * 3.6)
                                  .toStringAsFixed(0) +
                              ' km/h',
                      'icon-wind',
                      size.width * 0.42),
                  _weatherInfoBuilder(
                      'Sensação\nTérmica',
                      widget.day.isEmpty
                          ? '${data.feelsLike}' + '°'
                          : (widget.day[0]['rain'] as num)
                                  .toStringAsFixed(0) +
                              '%',
                      'chuva_icon',
                      size.width * 0.42),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
