/// بيقرا رقم من حقل إدخال، ويقبل الأرقام العربية (٠-٩) والفاصلة (, ، ٫).
double? parseDecimal(String text) {
  const arabic = '٠١٢٣٤٥٦٧٨٩';
  var s = text.trim().replaceAll('٫', '.').replaceAll('،', '.').replaceAll(',', '.');
  for (var i = 0; i < arabic.length; i++) {
    s = s.replaceAll(arabic[i], '$i');
  }
  return double.tryParse(s);
}

/// 2.0 تتعرض "2"، و2.5 تتعرض "2.5".
String formatCartons(double v) =>
    v == v.roundToDouble() ? v.toInt().toString() : v.toString();