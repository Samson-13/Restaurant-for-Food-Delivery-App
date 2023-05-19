import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_for_fooddelivery/models/hotel.dart';

class RestaurentAddPage extends StatefulWidget {
  final HotelModel? hotel;
  const RestaurentAddPage({super.key, required this.hotel});

  @override
  State<RestaurentAddPage> createState() => _RestaurentAddPageState();
}

class _RestaurentAddPageState extends State<RestaurentAddPage> {
  final hotelNameController = TextEditingController();
  final hotelDescriptionController = TextEditingController();
  final hotelPhoneController = TextEditingController();
  final hotelLocationController = TextEditingController();
  final hotelEmailController = TextEditingController();
  final hotelDelailsController = TextEditingController();
  final amenitiesController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final checkInPolicyController = TextEditingController();

  bool complete = false;
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;
  bool uploading = false;

  //
  @override
  void initState() {
    super.initState();
    checkPassedData();
  }

  void checkPassedData() {
    if (widget.hotel != null) {
      hotelNameController.text = widget.hotel!.hotelName;
      hotelDescriptionController.text = widget.hotel!.hotelDescription;
      hotelPhoneController.text = widget.hotel!.hotelPhone;
      hotelLocationController.text = widget.hotel!.hotelLocation;
      amenitiesController.text = widget.hotel!.amenities;
      checkInController.text = widget.hotel!.checkIn;
      checkOutController.text = widget.hotel!.checkOut;
      checkInPolicyController.text = widget.hotel!.checkInPolicy;
      imageUrl = widget.hotel!.hotelImage;
    }
  }

  void pickImage() async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Row(
            children: [
              Expanded(
                  child: MaterialButton(
                onPressed: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    uploadImage(image);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      height: 15,
                    ),
                    Icon(
                      Icons.camera_alt,
                      size: 35,
                    ),
                    Text('Camera'),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              )),
              Expanded(
                  child: MaterialButton(
                onPressed: () async {
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    uploadImage(image);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      height: 15,
                    ),
                    Icon(
                      Icons.photo_album,
                      size: 35,
                    ),
                    Text('Gallery'),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              )),
            ],
          );
        });
    // final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    // if (image != null) {
    //   uploadImage(image);

    // }
  }

  void uploadImage(XFile file) async {
    UploadTask uploadTask;
    var newId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child('$newId.jpg');
    uploadTask = ref.putFile(File(file.path));
    uploading = true;

    setState(() {});
    uploadTask.then((p0) async {
      if (p0.state == TaskState.success) {
        final url = await ref.getDownloadURL();
        imageUrl = url;
        uploading = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Add a Restaurant',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                if (imageUrl != null)
                  Image.network(
                    imageUrl!,
                    height: 150,
                  )
                else
                  SizedBox(
                    height: 150,
                    child: uploading
                        ? const CupertinoActivityIndicator()
                        : IconButton(
                            onPressed: () {
                              pickImage();
                            },
                            icon: const Icon(Icons.add_a_photo_outlined),
                          ),
                  ),
                TextField(
                  controller: hotelNameController,
                  decoration: const InputDecoration(labelText: "Hotel Name"),
                ),
                TextField(
                  controller: hotelDescriptionController,
                  decoration:
                      const InputDecoration(labelText: "Hotel Description"),
                ),
                TextField(
                  controller: hotelDelailsController,
                  decoration:
                      const InputDecoration(labelText: "Hotel Details: "),
                ),
                TextField(
                  controller: hotelPhoneController,
                  decoration:
                      const InputDecoration(labelText: "Hotel Phone Number: "),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  controller: hotelLocationController,
                  decoration:
                      const InputDecoration(labelText: "Hotel Location"),
                ),
                TextField(
                  controller: amenitiesController,
                  decoration: const InputDecoration(labelText: "Amenities: "),
                ),
                TextField(
                  controller: checkInController,
                  decoration: const InputDecoration(
                      labelText: "Check In Time (In AM): "),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  controller: checkOutController,
                  decoration: const InputDecoration(
                      labelText: "Check Out Time (In PM): "),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  controller: checkInPolicyController,
                  decoration:
                      const InputDecoration(labelText: "Check In Policy: "),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (uploading) {
                      return;
                    }
                    var newhotelId =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    if (widget.hotel != null) {
                      newhotelId = widget.hotel!.hotelId;
                    }
                    HotelModel newItem = HotelModel(
                      hotelId: newhotelId,
                      hotelName: hotelNameController.text,
                      hotelDescription: hotelDescriptionController.text,
                      hotelPhone: hotelPhoneController.text,
                      hotelLocation: hotelLocationController.text,
                      amenities: amenitiesController.text,
                      checkIn: checkInController.text,
                      checkOut: checkOutController.text,
                      checkInPolicy: checkInPolicyController.text,
                      hotelImage: imageUrl,
                      hotelEmail: hotelEmailController.text,
                      hotelDetails: hotelDelailsController.text,
                    );
                    hotelNameController.text = "";
                    hotelDescriptionController.text = "";
                    hotelPhoneController.text = "";
                    hotelLocationController.text = "";
                    amenitiesController.text = "";
                    checkInController.text = "";
                    checkOutController.text = "";
                    checkInPolicyController.text = "";
                    hotelEmailController.text = "";
                    hotelDelailsController.text = "";
                    Navigator.of(context).pop(newItem);
                  },
                  child: uploading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        )
                      : Text(widget.hotel == null ? "Add a Hotel" : "Update"),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
