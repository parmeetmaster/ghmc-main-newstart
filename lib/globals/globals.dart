import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/model/dashboard/drawer_authority.dart';
enum RESIDENT_OPR { update, insert }
class Globals {
  static CredentialsModel? userData;

  static DrawerAuthority? authority;

  static CredentialsModel? getUserData() {
    return userData!;
  }
  static DrawerAuthority? getAuthority() {
    return authority!;
  }

  static checkAppOnTest(){
    return false;
  }

  void getuser() {}
}
