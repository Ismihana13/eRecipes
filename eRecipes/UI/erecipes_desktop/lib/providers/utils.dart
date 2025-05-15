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

String formatDate(DateTime? date) {
  if (date == null) {
    return '';
  }
  return DateFormat('dd.MM.yyyy').format(date);
}

String formatQuantity(double quantity) {
  if (quantity == quantity.toInt()) {
    return quantity.toInt().toString();
  } else {
    return quantity.toStringAsFixed(1);
  }
}

String formatDateAndHours(DateTime? date) {
  if (date == null) return "";
  return DateFormat('dd.MM.yyyy HH:mm').format(date);
}
