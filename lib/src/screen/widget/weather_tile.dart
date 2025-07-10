import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/src/model/weather_response.dart';
import 'package:weather/src/screen/widget/weather_footer.dart';
import 'package:weather/utils/extension/num_extension.dart';

class WeatherTile extends StatelessWidget {
  const WeatherTile({super.key, required this.weather});
  final WeatherResponse weather;
  @override
  Widget build(BuildContext context) {
    Weather? weatherSummary = weather.weather?.first;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Color(0xFFeeeee4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            weather.name ?? '',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w300),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (weather.dt ?? 0).toDate,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black87,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://openweathermap.org/img/wn/${weatherSummary?.icon ?? ''}@2x.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "${weather.main?.temp ?? 0}°c",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
                Text(
                  weatherSummary?.description ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TempFooter(
                  icon: CupertinoIcons.sunset,
                  title: 'SUNSET',
                  value: weather.sys?.sunset?.toTime ?? '',
                ),
              ),
              Expanded(
                child: TempFooter(
                  icon: CupertinoIcons.wind,
                  title: 'WIND',
                  value: "${weather.wind?.speed ?? 0}m/s",
                ),
              ),
    
              Expanded(
                child: TempFooter(
                  icon: CupertinoIcons.drop,
                  title: 'HUMIDITY',
                  value: "${weather.main?.humidity ?? 0}%",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
