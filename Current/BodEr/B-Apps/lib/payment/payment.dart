import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double? devHeight;
  double? devWidth;

  // Map to track which month is expanded or collapsed
  final Map<String, bool> monthExpanded = {
    "January": false,
    "February": false,
    "March": true,
  };

  @override
  Widget build(BuildContext context) {
    devHeight = MediaQuery.of(context).size.height;
    devWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.blue,
              height: devHeight! * 0.2,
              width: devWidth,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 25,
                        ),
                        const SizedBox(width: 50),
                        const Text(
                          "Mobile Wallet",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    const Text(
                      "Current Balance: 700",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: monthExpanded.keys.map((month) {
                  return Column(
                    children: [
                      // Month Header with Toggle
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            monthExpanded[month] = !(monthExpanded[month]!);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              month,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Icon(
                              monthExpanded[month]!
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 30,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      // Items under the month
                      if (monthExpanded[month]!)
                        Column(
                          children: [
                            customColumn("Juja - Kiambu", "5,000"),
                            customColumn("Thika - Nairobi", "3,200"),
                          ],
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customColumn(String location, String amount) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        height: devHeight! * 0.08,
        width: devWidth! * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check,
                color: Colors.green,
                size: 30,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    amount,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
