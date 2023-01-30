class RestaurantModel {
  late String restaurantId;
  late String restaurantName;
  late String restaurantDescription;
  late String restaurantPhone;
  late String restaurantDetails;
  late String restaurantLocation;
  late String ownerId;
  String? restauranImage;
  late String ownerEmail;
  late String menu1;
  late String menu2;
  late String menu3;
  late String menu4;
  late String menu5;

  RestaurantModel({
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantDescription,
    required this.restauranImage,
    required this.ownerId,
    required this.ownerEmail,
    required this.restaurantPhone,
    required this.restaurantDetails,
    required this.restaurantLocation,
    required this.menu1,
    required this.menu2,
    required this.menu3,
    required this.menu4,
    required this.menu5,
  });

  RestaurantModel.fromMap(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    restaurantDescription = json['restaurantDescription'];
    restauranImage = json['restauranImage'];
    ownerId = json['ownerId'];
    ownerEmail = json['ownerEmail'];
    restaurantPhone = json['restaurantPhone'];
    restaurantDetails = json['restaurantDetails'];
    restaurantLocation = json['restaurantLocation'];
    menu1 = json['menu1'];
    menu2 = json['menu2'];
    menu3 = json['menu3'];
    menu4 = json['menu4'];
    menu5 = json['menu5'];
  }

  Map<String, dynamic> toMap() {
    return {
      "restaurantId": restaurantId,
      "restaurantName": restaurantName,
      "restaurantDescription": restaurantDescription,
      "restauranImage": restauranImage,
      "ownerId": ownerId,
      "ownerEmail": ownerEmail,
      "restaurantPhone": restaurantPhone,
      "restaurantDetails": restaurantDetails,
      "restaurantLocation": restaurantLocation,
      "menu1": menu1,
      "menu2": menu2,
      "menu3": menu3,
      "menu4": menu4,
      "menu5": menu5,
    };
  }
}
