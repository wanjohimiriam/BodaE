import 'package:drivers/views/authentication/authentication_view_model.dart';
import 'package:drivers/views/homepage/drawer_screen.dart';
import 'package:drivers/views/homepage/homepage_view_model.dart';
import 'package:drivers/views/homepage/main_screen/main_screen_view_model.dart';
import 'package:drivers/widgets/colors.dart';
import 'package:drivers/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final HomepageViewModel homepageViewModel = Get.find<HomepageViewModel>();
  final MainScreenViewModel mainScreenViewModel = Get.find<MainScreenViewModel>();
  final AuthenticationViewModel authenticationViewModel = Get.find<AuthenticationViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainScreenViewModel.scaffoldState,
      backgroundColor: AppColor.white,
      drawer: DrawerScreen(authenticationViewModel: authenticationViewModel),
      body: Stack(
        children: [
          Obx(
            () => Opacity(
              opacity: homepageViewModel.loading ? .35 : 1,
              child: GestureDetector(
                onTap: () {
                  if(!homepageViewModel.loading){
                    mainScreenViewModel.formFocus.unfocus();
                  }
                },
                child: Obx(
                  () => GoogleMap(
                    style: homepageViewModel.styleString,
                    padding: EdgeInsets.only(top: 30),
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: homepageViewModel.currentLocation,
                      zoom: homepageViewModel.zoom,
                    ),
                    markers: {
                      // Current Position Marker
                      Marker(
                        markerId: MarkerId("Current Location"),
                        icon: AssetMapBitmap('assets/icons/motorbike.png', width: 50, height: 50),
                        position: homepageViewModel.currentLocation,
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      homepageViewModel.completer.complete(controller);
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: verticalSpace(context, .065),
            left: 16,
            child: GestureDetector(
              onTap: (){
                if(!homepageViewModel.loading){
                  mainScreenViewModel.scaffoldState.currentState!.openDrawer();
                }
              },
              child: Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.blue,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-3, -3),
                          blurRadius: 12,
                          color: Colors.white
                        ),
                        BoxShadow(
                          offset: Offset(3, 3),
                          blurRadius: 12,
                          color: Colors.grey.shade300
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.menu,
                      color: Colors.grey.shade900,
                      size: 25,
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: homepageViewModel.hasPending,
                      child: Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 5.5,
                            backgroundColor: Colors.orange.shade900,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: verticalSpace(context, .065),
            right: 16,
            child: GestureDetector(
              onTap: (){
                if(!homepageViewModel.loading){
                  homepageViewModel.setZoom(15);
                  homepageViewModel.animateToPosition(homepageViewModel.currentLocation);
                }
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-3, -3),
                      blurRadius: 12,
                      color: Colors.white,
                    ),
                    BoxShadow(
                      offset: Offset(3, 3),
                      blurRadius: 12,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.my_location,
                  color: Colors.grey.shade900,
                  size: 25,
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: homepageViewModel.loading,
              child: Center(
                child: Transform.scale(
                  scale: 1.5,
                  child: CupertinoActivityIndicator(
                    color: AppColor.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
