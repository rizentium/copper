import 'package:intl/intl.dart';

extension DateTimeExtended on DateTime {
  String toBasicFormat({bool noHour = false}) {
    return DateFormat('EEE, dd MMM yyyy ${noHour ? '' : 'HH:mm'}').format(this);
  }
}
