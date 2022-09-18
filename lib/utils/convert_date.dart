import 'dart:io';

import 'package:intl/intl.dart';

String getLocaleDate(DateTime dateTime) {
  DateFormat format = DateFormat.MMMMEEEEd(Platform.localeName);
  return format.format(dateTime);
}
