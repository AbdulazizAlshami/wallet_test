import 'package:alqasemi_wallet/transactionScreens/transactionsDetailsScreen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final List<String> items = [
    'مبالغ مسحوبة',
    'مبالغ مودعة',
    'مبالغ مدخرة',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    const fillColor = Color.fromRGBO(192, 192, 192, 0.9);
    const primaryColor = Color.fromRGBO(255, 87, 51, 0.9);
    const accentColor = Color.fromRGBO(242, 210, 189, 0.9);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFd7dbe1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "الحسابات",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: true,

          //iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      width: 280,
                      child: TextField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'بحث',
                            hintStyle:
                                const TextStyle(color: Colors.grey, fontSize: 18),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(15),
                              width: 18,
                              child: const Icon(
                                Icons.search,
                                color: fillColor,
                              ),
                            )),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      //margin: const EdgeInsets.only(left: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 87, 51, 0.9),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Text(
                          'ترتيب حسب ',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(255, 87, 51, 0.9)),
                        ),
                        items: items
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: const Color.fromRGBO(
                                            255, 87, 51, 0.9)),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 140,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "الحسابات (4)",
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    ),
                    const Text(
                      "الرصيد الكلي  48,005,102.48 YER",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 275,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18)),
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            right: 30, left: 30, top: 30, bottom: 20),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                backgroundColor: accentColor,
                                child: Icon(
                                  Icons.money,
                                  color: Colors.blueGrey,
                                )),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "****5677",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text("جاري كاش - شركات",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("YER",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "الرصيد المتوفر",
                              style:
                                  TextStyle(color: Colors.black.withOpacity(0.5)),
                            ),
                            const Text(
                              " 5,005,102.48 YER",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const DetailsScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          elevation: 0,
                          minimumSize: const Size(300, 50), // Set the width and height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Set the border radius to zero
                          ),
                        ),
                        child: const Text(
                          "عرض التفاصيل",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 275,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18)),
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            right: 30, left: 30, top: 30, bottom: 20),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                backgroundColor: accentColor,
                                child: Icon(
                                  Icons.money,
                                  color: Colors.blueGrey,
                                )),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "****5677",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text("جاري كاش - شركات",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("YER",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "الرصيد المتوفر",
                              style:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                            ),
                            const Text(
                              " 5,005,102.48 YER",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const DetailsScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          elevation: 0,
                          minimumSize: const Size(300, 50), // Set the width and height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Set the border radius to zero
                          ),
                        ),
                        child: const Text(
                          "عرض التفاصيل",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
