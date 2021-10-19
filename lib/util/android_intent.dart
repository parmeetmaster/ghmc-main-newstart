import 'package:intent/intent.dart' as android_intent;
import 'package:intent/extra.dart' as android_extra;
import 'package:intent/typedExtra.dart' as android_typedExtra;
import 'package:intent/action.dart' as android_action;

class Intents {
  callwhatsapp() {
    android_intent.Intent()
      ..setAction(android_action.Action.ACTION_SHOW_APP_INFO)
      ..putExtra(android_extra.Extra.EXTRA_PACKAGE_NAME, "com.whatsapp",
          type: android_typedExtra.TypedExtra.stringExtra)
      ..startActivity().catchError((e) => print(e));
  }
}
