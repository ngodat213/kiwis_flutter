import 'package:kiwis_flutter/core/app_export.dart';
import 'package:kiwis_flutter/localization/en_us/en_us_translations.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
      };
}
