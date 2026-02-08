// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get pizzatitle => 'Beef Cheese';

  @override
  String get cheeseText => 'Cheese';

  @override
  String get sausageText => 'Sausage';

  @override
  String get oliveText => 'Olive';

  @override
  String get pepperText => 'Pepper';

  @override
  String get deliverTime => '20 min';

  @override
  String get deliveryTitle => 'Delivery';

  @override
  String get pizzaExplanation => 'Meat lover, get ready to meet your pizza !';

  @override
  String get price => '\$ 5.98';

  @override
  String get buttonText => 'ADD TO CART';
}
