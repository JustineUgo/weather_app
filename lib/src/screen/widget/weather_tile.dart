import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/src/screen/widget/weather_footer.dart';

class WeatherTile extends StatelessWidget {
  const WeatherTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Color(0xFFe6edf5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Lagos",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "MONDAY  7:00 AM",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CachedNetworkImage(
                    imageUrl: "https://openweathermap.org/img/wn/04d@2x.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "23.06°c",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
                Text(
                  "overcast clouds",
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
                  value: "7:00",
                ),
              ),
              Expanded(
                child: TempFooter(
                  icon: CupertinoIcons.wind,
                  title: 'WIND',
                  value: "2.26m/s",
                ),
              ),

              Expanded(
                child: TempFooter(
                  icon: CupertinoIcons.drop,
                  title: 'HUMIDITY',
                  value: "96%",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
