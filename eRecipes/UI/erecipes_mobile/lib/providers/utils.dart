import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');
  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}

Image imageFromString(String input) {
  return Image.memory(base64Decode(input));
}

Image imageFromStringDetails(String input) {
  return Image.memory(
    base64Decode(input),
    fit: BoxFit.cover,
  );
}
<<<<<<< Updated upstream
<<<<<<< Updated upstream
String formatDateWithTime(DateTime date) => DateFormat("dd/MM/yyyy HH:mm").format(date);
String formatDate(DateTime date) => DateFormat("dd/MM/yyyy ").format(date);
=======


String formatDate(DateTime date)=> DateFormat('dd.MM.yyyy').format(date);
>>>>>>> Stashed changes
=======


String formatDate(DateTime date)=> DateFormat('dd.MM.yyyy').format(date);
>>>>>>> Stashed changes
