import 'package:intl/intl.dart';

class FormatsHelper {

  static String number(double number, int decimalDigits) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
      locale: 'en',
    ).format(number);
    return formattedNumber;
  }
}
