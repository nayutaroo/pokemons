import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

L10n useL10n() {
  final context = useContext();
  return L10n.of(context);
}
