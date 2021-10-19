import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/model/dashboard/drawer_authority.dart';

class Globals {
  static CredentialsModel? userData;

  static DrawerAuthority? authority;

  static CredentialsModel? getUserData() {
    return userData!;
  }
  static DrawerAuthority? getAuthority() {
    return authority!;
  }

  void getuser() {}
}
