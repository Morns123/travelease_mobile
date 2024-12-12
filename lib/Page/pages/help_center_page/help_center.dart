import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/ReportPage.dart';
import 'package:travelease_mobile/Page/chat_bot.dart';
import 'package:travelease_mobile/Page/pages/detail_problem_page/detail_problem.dart';
import 'package:travelease_mobile/service/faq_service.dart';
import '../../../widget/components/chat_option.dart';
import '../../../widget/components/button_to_view.dart';
import '../../../widget/components/problem_category.dart';
import '../../../widget/components/button_to_problem_detail.dart';

class HelpCenterPage extends StatefulWidget {
  final String token;

  const HelpCenterPage({super.key, required this.token});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
    late String _token;


  late Future<List<dynamic>> _categories;
  String selectedCategory = 'Penawaran & Promo'; // Default selected category
  Set<String> selectedSubcategories =
      {}; // Track the selected subcategories as a set
  bool _showButtons = false;

  @override
  void initState() {
    super.initState();
    _categories = getFaqCategoriesWithSubcategoriesAndFaqs();
    _token = widget.token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(
            color: Color(0xff366389),
            fontSize: 20,
            fontFamily: "Montserrat-Bold",
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Container(
              //     height: 35,
              //     decoration: BoxDecoration(
              //       color: const Color(0xffD9D9D9),
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     child: const TextField(
              //       decoration: InputDecoration(
              //         hintText: 'Cari',
              //         hintStyle:
              //             TextStyle(color: Color.fromARGB(255, 197, 197, 197)),
              //         prefixIcon: Icon(
              //           Icons.search,
              //           color: Color.fromARGB(255, 154, 154, 154),
              //         ),
              //         border: InputBorder.none,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ProblemCategory(
                    onSelected: (String category) {
                      setState(() {
                        selectedCategory = category;
                        selectedSubcategories
                            .clear(); // Reset selected subcategories when changing category
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: FutureBuilder<List<dynamic>>(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<dynamic> selectedCategoryData = snapshot.data!
                  .where((category) => category['name'] == selectedCategory)
                  .toList();

              // Get subcategories for the selected category
              List<dynamic> subcategories = selectedCategoryData.isNotEmpty
                  ? selectedCategoryData[0]['subcategories']
                  : [];

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: subcategories.map<Widget>((subcategory) {
                    List<dynamic> faqs =
                        subcategory['faqs']; // FAQs for this subcategory
                    bool isSelected =
                        selectedSubcategories.contains(subcategory['name']);
                    return Column(
                      children: [
                        ButtonToView(
                          size: const Size(double.infinity, 47),
                          icon: isSelected
                              ? Icons.keyboard_arrow_up_outlined
                              : Icons.keyboard_arrow_down_outlined,
                          color: const Color(0xffffffff),
                          title: subcategory['name'],
                          onPressed: () {
                            setState(() {
                              if (isSelected) {
                                // If already selected, remove it from the set
                                selectedSubcategories
                                    .remove(subcategory['name']);
                              } else {
                                // If not selected, add it to the set
                                selectedSubcategories.add(subcategory['name']);
                              }
                            });
                          },
                          outlinedBorder: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0)),
                            side: isSelected
                                ? const BorderSide(
                                    color: Color(0xff366389),
                                    width: 1,
                                    style: BorderStyle.solid,
                                  )
                                : BorderSide.none,
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: isSelected
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 30,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 400,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                    ),
                                    child: Column(
                                      children: faqs.map<Widget>((faq) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailProblemPage(
                                                    subsCategory:
                                                        subcategory['name'],
                                                    question: faq[
                                                        'question'], // Data pertanyaan dari API
                                                    answer: faq[
                                                        'answer'], // Data jawaban dari API
                                                    token: _token,    
                                                  ),
                                                ));
                                          },
                                          child: ButtonToProblemDetail(
                                            size:
                                                const Size(double.infinity, 35),
                                            color: const Color(0xffffffff),
                                            title:
                                                '[${subcategory['name']}] ${faq['question']}', // Displaying the question
                                            outlinedBorder:
                                                const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0)),
                                              side: BorderSide(
                                                color: Color(0xffC1C1C1),
                                                width: 1,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            } else {
              return const Center(child: Text('Tidak ada data subkategori.'));
            }
          },
        ),
      ),
      bottomSheet: Container(
        height: 130,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5, left: 20),
              child: Text(
                'Hubungi Kami',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat-Bold",
                ),
              ),
            ),
            ChatOption(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportPage(
                      onCategorySelected: (int) {}, token: _token, 
                    ),
                  ),
                );
              },
              text: 'Pertanyaan Saya',
              color: const Color(0xffC73437),
              textColor: const Color(0xffC73437),
            ),
            ChatOption(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatBot(token: _token,)),
                );
              },
              text: 'Chat Dengan TravelMate',
              color: const Color(0xff6799C3),
              textColor: const Color.fromRGBO(61, 96, 125, 1),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xffD9D9D9),
    );
  }
}
