class TripsModel {
  final String pickupLocation;
  final String destinationLocation;
  String? driver;
  final bool driverAccepted;
  final bool driverArrive;
  final bool paid;
  final bool paymentConfirmed;
  final double price;
  final bool tripEnded;
  final String user;

  TripsModel({
    required this.pickupLocation,
    required this.destinationLocation,
    this.driver,
    required this.driverAccepted,
    required this.driverArrive,
    required this.paymentConfirmed,
    required this.paid,
    required this.tripEnded,
    required this.user,
    required this.price,
  });

  factory TripsModel.fromJSON(Map<String, dynamic> json){
    return TripsModel(
      pickupLocation: json['pickup_location'], 
      destinationLocation: json['destination_location'], 
      driver: json['driver'], 
      driverAccepted: json['driver_accepted'], 
      driverArrive: json['driver_arrive'], 
      paymentConfirmed: json['payment_confirmed'], 
      paid: json['paid'], 
      tripEnded: json['trip_ended'], 
      user: json['user'], 
      price: json['price'],
    );
  }
}