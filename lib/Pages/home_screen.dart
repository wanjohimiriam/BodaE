// ignore_for_file: prefer_const_constructors

import 'package:bodae/Constants/colors.dart';
import 'package:bodae/widgets/drawer.dart';
import 'package:bodae/widgets/textfields.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  bool sellerMode = false;
  bool loading = false;
  TextEditingController searchController = TextEditingController();
  String searchInput = '';
  Map<String, dynamic> filter = {
    'price': {'down': 0.00, 'up': 1000.00},
    'pickup': '',
    'drop': ''
  };
  List<Map<String, dynamic>> bottomNavItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.message, 'label': 'Messages'},
    {'icon': Icons.shopping_cart, 'label': 'Orders'},
    {'icon': Icons.bookmark, 'label': 'Saved'},
    {'icon': Icons.calendar_today, 'label': 'Plans'},
  ];
  List<Map<String, dynamic>> locations = [
    {'region': 'Region 1'},
    {'region': 'Region 2'},
    // Add more locations here
  ];

  void loadValue(int value) {
    // Implement the logic to load the values
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyDisplay = <Widget>[
      // HomeTabDisplay(
      //   searchController: searchController,
      //   searchInput: searchInput,
      //   filter: filter,
      //   locations: locations,
      //   sellerMode: sellerMode,
      //   loading: loading,
      //   loadValue: loadValue,
      // ),
      // UsersPage(),
      // OrdersTabDisplay(),
      // SavedTabDisplay(),
      // PlansPage()
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: Text(
          currentTab == 1
              ? "messages"
              : currentTab == 2
                  ? "my_orders"
                  : currentTab == 3
                      ? "saved_posts"
                      : currentTab == 4
                          ? "my_plans"
                          : sellerMode
                              ? "LOOKING FOR DELIVERY"
                              : "OFFERING DELIVERY",
          style: TextStyle(color: AppColor.white),
        ),
      ),
      body: bodyDisplay[currentTab],
      floatingActionButton: Visibility(
        visible: currentTab == 0,
        child: FloatingActionButton(
          mini: false,
          backgroundColor: AppColor.blue,
          onPressed: () {
            Navigator.pushNamed(context, "/upload");
          },
          child: const Icon(
            Icons.add,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 1,
        child: SizedBox(
          height: 55,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                bottomNavItems.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      currentTab = index;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        bottomNavItems[index]["icon"],
                        size: currentTab == index ? 25 : 23,
                        color: currentTab == index
                            ? AppColor.blue
                            : Colors.grey.shade400,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        bottomNavItems[index]["label"],
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: currentTab == index ? 14 : 12,
                                  color: currentTab == index
                                      ? AppColor.blue
                                      : Colors.grey.shade400,
                                ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTabDisplay extends StatelessWidget {
  const HomeTabDisplay({
    super.key,
    required this.searchController,
    required this.searchInput,
    required this.filter,
    required this.locations,
    required this.sellerMode,
    required this.loading,
    required this.loadValue,
  });

  final TextEditingController searchController;
  final String searchInput;
  final Map<String, dynamic> filter;
  final List<Map<String, dynamic>> locations;
  final bool sellerMode;
  final bool loading;
  final Function(int) loadValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.blue,
                  child: Center(
                      child: Row(
                    children: [
                      CustomTextInput(
                       border: BorderSide(
                        color: AppColor.white, width: 2), 
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: AppColor.white,),
                        label: "Search")
                      
                    ],
                  )),
                ),
              ])
        ]));
  }
}
