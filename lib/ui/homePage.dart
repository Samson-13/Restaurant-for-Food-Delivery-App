import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../models/restaurant.dart';
import 'addRestaurantPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RestaurantModel> restaurant = [];

  final restaurantRef = FirebaseFirestore.instance
      .collection("restaurant")
      .limit(30)
      .withConverter<RestaurantModel>(
    fromFirestore: (data, snap) {
      return RestaurantModel.fromMap(data.data()!);
    },
    toFirestore: (data, snap) {
      return data.toMap();
    },
  );

  void listenData() async {
    restaurantRef.snapshots().listen((event) {
      restaurant.clear();
      for (var element in event.docs) {
        restaurant.add(element.data());
      }
      setState(() {});
    });
    // log("firestoreResult: ${firestoreResult.docs.length}");
  }

  void readData() async {
    final firestoreResult = await restaurantRef.get();
    log("firestoreResult: ${firestoreResult.docs.length}");
    for (var element in firestoreResult.docs) {
      restaurant.add(element.data());
    }
    setState(() {});
    // final result = await box.read("todos");
    // if (result != null) {
    //   List data = result;
    //   for (var element in data) {
    //     Map<String, dynamic> js = element;
    //     TodoModel model = TodoModel.fromMap(js);
    //     todos.add(model);
    //   }
    //   setState(() {});
    // }
  }

  // Bottom Navbar
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Home',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
      ),
      body: ListView.builder(
        itemCount: restaurant.length,
        itemBuilder: (context, index) {
          var item = restaurant[index];
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => RestaurantPage(
              //             restaurantInfo: item,
              //           )),
              // );
            },
            child: Card(
              elevation: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            item.restaurantName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            item.restaurantDescription,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(item.restaurantPhone),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(item.restaurantLocation),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18)),
                          child: Image.network(
                            item.restauranImage!,
                            scale: 1.5,
                            width: 150,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // Bottom Navigator
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 20,
      //         color: Colors.black.withOpacity(.1),
      //       )
      //     ],
      //   ),
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      //       child: GNav(
      //         rippleColor: Colors.grey[300]!,
      //         hoverColor: Colors.grey[100]!,
      //         gap: 8,
      //         activeColor: Colors.black,
      //         iconSize: 24,
      //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //         duration: const Duration(milliseconds: 400),
      //         tabBackgroundColor: Colors.grey[100]!,
      //         color: Colors.black,
      //         tabs: const [
      //           GButton(
      //             icon: Icons.home,
      //             text: 'Home',
      //           ),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: (index) {
      //           setState(() {
      //             _selectedIndex = index;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const RestaurentAddPage(
              restaurant: null,
            );
          }));
        },
        backgroundColor: Colors.red,
        label: const Text('Add a restaurant'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
