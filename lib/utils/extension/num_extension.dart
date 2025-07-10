import 'package:intl/intl.dart';

extension NumExtensions on num? {
  String get toDate {
    if(this == null) return '';
    int unixTimestamp = this!.toInt();

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      unixTimestamp * 1000,
      isUtc: true,
    );
    String formatted = DateFormat('EEEE h:mm a').format(dateTime).toUpperCase();
    return formatted;
  }


  String get toTime {
    if(this == null) return '';
  int unixTimestamp = 1752126834;

  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000, isUtc: true);
  String timeOnly = DateFormat('HH:mm').format(dateTime);

    return timeOnly;
  }
}
