import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_for_fooddelivery/models/restaurant.dart';

class RestaurentAddPage extends StatefulWidget {
  final RestaurantModel? restaurant;
  const RestaurentAddPage({super.key, required this.restaurant});

  @override
  State<RestaurentAddPage> createState() => _RestaurentAddPageState();
}

class _RestaurentAddPageState extends State<RestaurentAddPage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final detailsController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final owneridController = TextEditingController();
  final owneremailController = TextEditingController();
  final menu1Controller = TextEditingController();
  final menu2Controller = TextEditingController();
  final menu3Controller = TextEditingController();
  final menu4Controller = TextEditingController();
  final menu5Controller = TextEditingController();

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
    if (widget.restaurant != null) {
      idController.text = widget.restaurant!.restaurantId;
      nameController.text = widget.restaurant!.restaurantName;
      descriptionController.text =
          widget.restaurant!.restaurantDescription ?? "";
      detailsController.text = widget.restaurant!.restaurantDetails;
      phoneController.text = widget.restaurant!.restaurantPhone;
      locationController.text = widget.restaurant!.restaurantLocation;
      owneridController.text = widget.restaurant!.ownerId;
      owneremailController.text = widget.restaurant!.ownerEmail;
      menu1Controller.text = widget.restaurant!.menu1;
      menu2Controller.text = widget.restaurant!.menu2;
      menu3Controller.text = widget.restaurant!.menu3;
      menu4Controller.text = widget.restaurant!.menu4;
      menu5Controller.text = widget.restaurant!.menu5;
      imageUrl = widget.restaurant!.restauranImage;
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
                        Text("Camera"),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
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
                        Icons.photo_outlined,
                        size: 35,
                      ),
                      Text("Gallery"),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
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
        setState(() {
          uploading = false;
        });
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
                  controller: idController,
                  decoration: const InputDecoration(labelText: "Restaurant ID"),
                ),
                TextField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(labelText: "Restaurant Name"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      labelText: "Restaurant Description"),
                ),
                TextField(
                  controller: detailsController,
                  decoration:
                      const InputDecoration(labelText: "Restaurant Details"),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      labelText: "Restaurant Phone Number"),
                ),
                TextField(
                  controller: locationController,
                  decoration:
                      const InputDecoration(labelText: "Restaurant Location"),
                ),
                TextField(
                  controller: owneridController,
                  decoration: const InputDecoration(labelText: "Owner ID"),
                ),
                TextField(
                  controller: owneremailController,
                  decoration: const InputDecoration(labelText: "Owner Email"),
                ),
                TextField(
                  controller: menu1Controller,
                  decoration: const InputDecoration(labelText: "Menu 1"),
                ),
                TextField(
                  controller: menu2Controller,
                  decoration: const InputDecoration(labelText: "Menu 2"),
                ),
                TextField(
                  controller: menu3Controller,
                  decoration: const InputDecoration(labelText: "Menu 3"),
                ),
                TextField(
                  controller: menu4Controller,
                  decoration: const InputDecoration(labelText: "Menu 4"),
                ),
                TextField(
                  controller: menu5Controller,
                  decoration: const InputDecoration(labelText: "Menu 5"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [],
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (uploading) {
                      return;
                    }
                    var newrestaurantId =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    if (widget.restaurant != null) {
                      newrestaurantId = widget.restaurant!.restaurantId;
                    }
                    RestaurantModel newItem = RestaurantModel(
                      restaurantId: newrestaurantId,
                      restaurantName: nameController.text,
                      restaurantDescription: descriptionController.text,
                      ownerId: descriptionController.text,
                      ownerEmail: descriptionController.text,
                      restaurantPhone: descriptionController.text,
                      restaurantDetails: descriptionController.text,
                      restaurantLocation: descriptionController.text,
                      menu1: descriptionController.text,
                      menu2: descriptionController.text,
                      menu3: descriptionController.text,
                      menu4: descriptionController.text,
                      menu5: descriptionController.text,
                      restauranImage: imageUrl,
                    );
                    idController.text = "";
                    nameController.text = "";
                    descriptionController.text = "";
                    detailsController.text = "";
                    phoneController.text = "";
                    locationController.text = "";
                    owneridController.text = "";
                    owneremailController.text = "";
                    menu1Controller.text = "";
                    menu2Controller.text = "";
                    menu3Controller.text = "";
                    menu4Controller.text = "";
                    menu5Controller.text = "";
                    Navigator.of(context).pop(newItem);
                  },
                  child: uploading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        )
                      : Text(widget.restaurant == null
                          ? "Add a restaurant"
                          : "Update"),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
