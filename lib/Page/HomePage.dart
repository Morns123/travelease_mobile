import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/ReportPage.dart';
import 'package:travelease_mobile/Page/chat_bot.dart';
import 'package:travelease_mobile/Page/pages/detail_problem_page/detail_problem.dart';
import 'package:travelease_mobile/Page/pages/help_center_page/help_center.dart';
import 'package:travelease_mobile/service/faq_service.dart';
import 'package:travelease_mobile/widget/homepage/CategoryFAQ.dart';
import 'package:travelease_mobile/widget/homepage/Categorybase.dart';
import 'package:travelease_mobile/widget/homepage/CustomKontent.dart';
import 'package:travelease_mobile/widget/homepage/HomeApp.dart';

class HomePage extends StatefulWidget {
    final String token;
  const HomePage({required this.token});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _token;

  late Future<List<dynamic>> _categories;
  String selectedCategory = 'Penawaran & Promo'; // Default selected category
  Set<String> selectedSubcategories = {};
  List<dynamic> selectedFaqs = []; // List to hold the FAQ questions



      
  @override
  void initState() {
    super.initState();
    _categories = getFaqCategoriesWithSubcategoriesAndFaqs();
        _token = widget.token;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeApp(token: _token,),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Laporan Teratas",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(54, 99, 137, 1),
                        fontFamily: "Montserrat-Bold"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReportPage(onCategorySelected: (int) { }, token: _token,)));
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Riwayat Laporan",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(54, 99, 137, 0.73),
                              fontFamily: "Montserrat-Bold"),
                        ),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            const Categorybase(),
            Container(
              margin: EdgeInsets.only(top: 15),
              color: Color.fromRGBO(217, 217, 217, 1),
              height: 10,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "FAQ",
                    style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(54, 99, 137, 1),
                        fontFamily: "Montserrat-Bold"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenterPage(token: _token,)));
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Lihat Semua",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(54, 99, 137, 0.73),
                              fontFamily: "Montserrat-Bold"),
                        ),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CategoryFaq(
              onSelected: (String category) {
                setState(() {
                  selectedCategory = category;
                  selectedSubcategories.clear(); // Reset selected subcategories when changing category
                });
              },
            ),
            SizedBox(height: 10),
           FutureBuilder<List<dynamic>>(
  future: _categories,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      // Filter data berdasarkan kategori yang dipilih
      List<dynamic> selectedCategoryData = snapshot.data!
          .where((category) => category['name'] == selectedCategory)
          .toList();

      // Ambil subkategori dari kategori yang dipilih
      List<dynamic> subcategories = selectedCategoryData.isNotEmpty
          ? selectedCategoryData[0]['subcategories']
          : [];

      return Container(
        height: 350,
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ...subcategories.expand<Widget>((subcategory) {
              List<dynamic> faqs = subcategory['faqs'] ?? []; // FAQ dalam subkategori
              
              faqs.shuffle(); 
              var limitedFaqs = faqs.take(3).toList(); // Ambil 7 FAQ pertama

              return limitedFaqs.map<Widget>((faq) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProblemPage(
                          subsCategory: subcategory['name'],
                          question: faq['question'],
                          answer: faq['answer'],
                          token: _token,
                        ),
                      ),
                    );
                  },
                  child: CustomKontent(
                    label: faq['question'], // Pertanyaan FAQ
                    category: '[${subcategory['name']}]', // Nama subkategori langsung ke parameter
                  ),
                );
              }).toList();
            }).toList(),
          ],
        ),
      );
    } else {
      return const Center(child: Text('Tidak ada data subkategori.'));
    }
  },
),


            Container(
              margin: EdgeInsets.only(top: 15),
              color: Color.fromRGBO(217, 217, 217, 1),
              height: 10,
            ),
            SizedBox(height: 13),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("Hubungi Kami",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(103, 153, 195, 1),
                          fontFamily: "Montserrat-Bold")),
                )
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBot()));
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15),
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(103, 153, 195, 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.chat_bubble_outline, color: Colors.white),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Chat Dengan TravleMate',
                      style: TextStyle(
                          color: Color.fromRGBO(103, 153, 195, 1),
                          fontSize: 16,
                          fontFamily: "Montserrat-Bold"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}


