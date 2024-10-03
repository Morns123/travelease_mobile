import 'package:flutter/material.dart';
import '../components/chat_option.dart';
import '../components/list_problem.dart';
import '../components/problem_category.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  bool _isExpanded = false;

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
          preferredSize: const Size.fromHeight(30),
          child: Padding(
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
        ),
      ),
      body: Visibility(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            ListProblem(
              title: 'Promosi',
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              trailing:
                  Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              border: _isExpanded
                  ? const Border(
                      top: BorderSide(
                        color: Color(0xff366389),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      bottom: BorderSide(
                        color: Color(0xff366389),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    )
                  : Border.all(
                      color: Colors.transparent,
                      width: 0,
                      style: BorderStyle.none,
                    ),
            ),
            ListProblem(
              title: 'Program Berhadiah',
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              trailing:
                  Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              border: _isExpanded
                  ? const Border(
                      top: BorderSide(
                        color: Color(0xff366389),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      bottom: BorderSide(
                        color: Color(0xff366389),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    )
                  : Border.all(
                      color: Colors.transparent,
                      width: 0,
                      style: BorderStyle.none,
                    ),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         if (_isExpanded)
            //           Column(
            //             children: List.generate(10, (index) {
            //               return const ListTile(
            //                 title: Text(
            //                     '[Voucher] Bagaimana cara menggunakan kode voucher'),
            //               );
            //             }),
            //           ),
            //         if (_isExpanded)
            //           TextButton(
            //             onPressed: () {
            //               ScaffoldMessenger.of(context).showSnackBar(
            //                   const SnackBar(
            //                       content: Text('Memuat lebih banyak...')));
            //             },
            //             child: const Text('Lihat Lebih Banyak'),
            //           ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
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
              onTap: () {},
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
