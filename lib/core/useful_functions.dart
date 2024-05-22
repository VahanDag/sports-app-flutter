import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sports_app/core/enums.dart';
import 'package:sports_app/core/extensions.dart';

String stringCapitalize(String value) {
  if (value.isEmpty) {
    return value;
  }

  final firstLetter = value[0].toUpperCase();
  final remaining = value.substring(1);

  return firstLetter + remaining;
}

List<dynamic> calculateMarketCap(int marketCap) {
  if (marketCap >= pow(10, 9)) {
    double milyarDeger = marketCap / pow(10, 9);
    return [milyarDeger.toStringAsFixed(3), MarketCapEnum.billion];
  } else {
    int milyonDeger = marketCap ~/ pow(10, 6);
    return [milyonDeger.toString(), MarketCapEnum.million];
  }
}

AssetImage randomStadium() {
  final randomNumber = Random().nextInt(3) + 1;
  final randomImage = "assets/stadiums/stadium-$randomNumber.png";
  return AssetImage(randomImage);
}

String extractHour(String utcDateTime) {
  // Convert UTC date and hours string to DateTime
  DateTime parsedDate = DateTime.parse(utcDateTime);

  // get hours and minutes
  int hour = parsedDate.hour;
  int minute = parsedDate.minute;

  // conert hours to 'HH:mm' format
  String formattedHour = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  return formattedHour;
}

LeagueCode findLeague(String league) {
  switch (league) {
    case "bundesliga":
      return LeagueCode.BL1;
    case "premier-league":
      return LeagueCode.PL;
    case "league-1":
      return LeagueCode.FL1;
    case "champions-league":
      return LeagueCode.CL;
    case "serie-a":
      return LeagueCode.SA;
    case "laliga":
      return LeagueCode.PD;
    case "euro-24":
      return LeagueCode.EC;
    default:
      return LeagueCode.CL;
  }
}

Text infoText({required String infoMessage, required BuildContext context, Color? textColor}) {
  return Text(
    infoMessage.toUpperCase(),
    style: context.textTheme.titleLarge?.copyWith(color: textColor ?? Colors.grey.shade700, fontWeight: FontWeight.w700),
  );
}
