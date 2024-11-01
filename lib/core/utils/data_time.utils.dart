import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String dataTimeFormatPattern = 'dd/MM/yyyy';

extension DataTimeExtension on DateTime {
  String format({
    String pattern = dataTimeFormatPattern,
    String? locale,
  }) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}
