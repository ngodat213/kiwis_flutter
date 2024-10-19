import 'package:intl/date_symbol_data_local.dart';

const String dataTimeFormatPattern = 'dd/MM/yyyy';

extension DataTimeExtension on DataTime {
  String format({
    String pattern = dataTimeFormatPattern,
    String? locale,
  }) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DataFormat(pattern, locale).format(this);
  }
}
