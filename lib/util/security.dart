import 'package:root_access/root_access.dart';

class Security {
  Future<bool> check_is_device_rooted() async {
    bool rootStatus = await RootAccess.requestRootAccess;
    //  print("is rooted ${rootStatus}");
    return rootStatus;
  }
}
