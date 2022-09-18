import 'dart:math';

DateTime getRandomDate({int years = 5}) {
  Random gen = Random();
  int range = years * 365;
  return DateTime.now().subtract(
    Duration(
      days: gen.nextInt(range),
    ),
  );
}
