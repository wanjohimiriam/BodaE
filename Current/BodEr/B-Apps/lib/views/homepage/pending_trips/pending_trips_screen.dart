import 'package:drivers/models/trips_model.dart';
import 'package:drivers/views/homepage/homepage_view_model.dart';
import 'package:drivers/views/homepage/pending_trips/pending_trips_view_model.dart';
import 'package:drivers/widgets/colors.dart';
import 'package:drivers/widgets/space.dart';
import 'package:drivers/widgets/spacing.dart';
import 'package:drivers/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingTripsScreen extends StatelessWidget {
  PendingTripsScreen({super.key});
  final PendingTripsViewModel pendingTripsViewModel = Get.find<PendingTripsViewModel>();
  final HomepageViewModel homepageViewModel = Get.find<HomepageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.lightGrey,
        title: CustomText(
          text: "Pending Trips",
          fontSize: 30,
          textColor: AppColor.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Obx(
        () => pendingTripsViewModel.availableTrips.isNotEmpty ? ListView.builder(
          itemCount: pendingTripsViewModel.availableTrips.length,
          itemBuilder: (context, index) {
            List<TripsModel> trips = pendingTripsViewModel.availableTrips;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: horizontalSpace(context, 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColor.lightGrey.withOpacity(.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('assets/icons/person.png'),
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                        CustomSpacing(width: .01),
                        SizedBox(
                          width: horizontalSpace(context, .75),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: trips[index].pickupLocation,
                                fontSize: 16,
                                textColor: AppColor.black,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomSpacing(height: .005),
                              CustomText(
                                text: trips[index].destinationLocation,
                                fontSize: 16,
                                textColor: AppColor.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomSpacing(height: .012),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 12, bottom: 12,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: (){
                            homepageViewModel.acceptTrip(trips[index].user);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.blue,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8
                              ),
                              child: CustomText(
                                text: "Pick Client",
                                fontSize: 16,
                                textColor: AppColor.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ) : Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalSpace(context, .05),
          ),
          child: Center(
            child: CustomText(
              text: "There are no pending trips at the moment, hang on, if something pops up, you will be the first to know.", 
              fontSize: 16,
              textColor: AppColor.darkGrey,
              centerText: true,
            ),
          ),
        ),
      ),
    );
  }
}