import 'package:location/location.dart' as lc;

Future<void> checkPermission() async {
  lc.Location location = lc.Location();
  lc.PermissionStatus permissionStatus = await location.hasPermission();
  bool enabled = await location.serviceEnabled();
  if(!enabled){
    await location.requestService();
    checkPermission();
  } else {
    if(permissionStatus == lc.PermissionStatus.granted || permissionStatus == lc.PermissionStatus.grantedLimited){
      return;
    } else {
      await location.requestPermission();
      checkPermission();
    }
  }
}