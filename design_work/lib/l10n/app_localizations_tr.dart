// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get pizzatitle => 'Etli Peynirli';

  @override
  String get cheeseText => 'Peynir';

  @override
  String get sausageText => 'Sosis';

  @override
  String get oliveText => 'Zeytin';

  @override
  String get pepperText => 'Biber';

  @override
  String get deliverTime => '20 dk';

  @override
  String get deliveryTitle => 'Teslimat';

  @override
  String get pizzaExplanation =>
      'Et severler, pizzanızla tanışmaya hazır olun!';

  @override
  String get price => '₺ 5.98';

  @override
  String get buttonText => 'SEPETE EKLE';
}
