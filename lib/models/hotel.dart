class HotelModel {
  late String hotelId;
  late String hotelName;
  late String hotelDescription;
  String? hotelImage;
  late String hotelEmail;
  late String hotelPhone;
  late String hotelDetails;
  late String hotelLocation;
  late String amenities;
  late String checkIn;
  late String checkOut;
  late String checkInPolicy;

  HotelModel({
    required this.hotelId,
    required this.hotelName,
    required this.hotelDescription,
    required this.hotelImage,
    required this.hotelEmail,
    required this.hotelPhone,
    required this.hotelDetails,
    required this.hotelLocation,
    required this.amenities,
    required this.checkIn,
    required this.checkOut,
    required this.checkInPolicy,
  });

  HotelModel.fromMap(Map<String, dynamic> json) {
    hotelId = json['hotelId'];
    hotelName = json['hotelName'];
    hotelDescription = json['hotelDescription'];
    hotelImage = json['hotelImage'];
    hotelEmail = json['hotelEmail'];
    hotelPhone = json['hotelPhone'];
    hotelDetails = json['hotelDetails'];
    hotelLocation = json['hotelLocation'];
    amenities = json['amenities'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    checkInPolicy = json['checkInPolicy'];
  }

  Map<String, dynamic> toMap() {
    return {
      "hotelId": hotelId,
      "hotelName": hotelName,
      "hotelDescription": hotelDescription,
      "hotelImage": hotelImage,
      "hotelEmail": hotelEmail,
      "hotelPhone": hotelPhone,
      "hotelDetails": hotelDetails,
      "hotelLocation": hotelLocation,
      "amenities": amenities,
      "checkIn": checkIn,
      "checkOut": checkOut,
      "checkInPolicy": checkInPolicy,
    };
  }
}
