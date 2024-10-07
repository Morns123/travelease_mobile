import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/ReportPage.dart';
import '../components/chat_option.dart';
import '../components/button_to_view.dart';
import '../components/problem_category.dart';
import '../components/button_to_problem_detail.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  bool _showButtons = false;
  bool _showButtons2 = false;
  final String title = 'Voucher';

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
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProblemCategory(
                        onClick: () {},
                        text: 'Penawaran & Promo',
                      ),
                      ProblemCategory(
                        onClick: () {},
                        text: 'Refund',
                      ),
                      ProblemCategory(
                        onClick: () {},
                        text: 'Supir Bermasalah',
                      ),
                      ProblemCategory(
                        onClick: () {},
                        text: 'Informasi Umur',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Visibility(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 130),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ButtonToView(
                  size: const Size(double.infinity, 35),
                  icon: _showButtons
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                  color: const Color(0xffffffff),
                  title: 'Promosi',
                  onPressed: () {
                    setState(() {
                      _showButtons = !_showButtons;
                    });
                  },
                  outlinedBorder: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(0),
                    ),
                    side: _showButtons
                        ? const BorderSide(
                            color: Color(0xff366389),
                            width: 1,
                            style: BorderStyle.solid,
                          )
                        : BorderSide.none,
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 0),
                  child: _showButtons
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 30,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 400,
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                            ),
                            child: Column(
                              children: [
                                ButtonToProblemDetail(
                                  size: const Size(double.infinity, 35),
                                  color: const Color(0xffffffff),
                                  title:
                                      '[$title] Bagaimana cara menggunakan kode voucher',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/detail_problem',
                                    );
                                  },
                                  outlinedBorder: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    side: BorderSide(
                                      color: Color(0xffC1C1C1),
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                ButtonToView(
                  size: const Size(double.infinity, 35),
                  icon: _showButtons2
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                  color: const Color(0xffffffff),
                  title: 'Program Berhadiah',
                  onPressed: () {
                    setState(() {
                      _showButtons2 = !_showButtons2;
                    });
                  },
                  outlinedBorder: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(0),
                    ),
                    side: _showButtons2
                        ? const BorderSide(
                            color: Color(0xff366389),
                            width: 1,
                            style: BorderStyle.solid,
                          )
                        : BorderSide.none,
                  ),
                ),
              ],
            ),
          ),
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
                ),
              ),
            ),
            ChatOption(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReportPage(onCategorySelected: (int ) {  },)));
              },
              text: 'Pertanyaan Saya',
              color: const Color(0xffC73437),
            ),
            ChatOption(
              onTap: () {},
              text: 'Chat Dengan TravelMate',
              color: const Color(0xff6799C3),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xffD9D9D9),
    );
  }
}
