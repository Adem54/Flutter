// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get pizzatitle => 'Biff og Ost';

  @override
  String get cheeseText => 'Ost';

  @override
  String get sausageText => 'Pølse';

  @override
  String get oliveText => 'Oliven';

  @override
  String get pepperText => 'Paprika';

  @override
  String get deliverTime => '20 min';

  @override
  String get deliveryTitle => 'Levering';

  @override
  String get pizzaExplanation =>
      'Kjøttelskere, gjør dere klare for å møte pizzaen deres!';

  @override
  String get price => 'kr 5.98';

  @override
  String get buttonText => 'LEGG I HANDLEKURV';
}
