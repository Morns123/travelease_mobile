





// You said:
// import 'package:flutter/material.dart';
// import 'package:travelease_mobile/Page/ReportPage.dart';
// import 'package:travelease_mobile/Page/chat_bot.dart';
// import 'package:travelease_mobile/Page/pages/components/button_article.dart';
// import '../components/chat_option.dart';

// class DetailProblemPage extends StatefulWidget {
//   final String subsCategory;
//   final String question;
//   final String answer;

//   const DetailProblemPage({
//     super.key,
//     required this.subsCategory,
//     required this.question,
//     required this.answer,
//   });

//   @override
//   State<DetailProblemPage> createState() => _DetailProblemPageState();
// }

// class _DetailProblemPageState extends State<DetailProblemPage> {
//   final String frontArrow = '>';
//   final String title = 'Voucher';
//   bool _isExpanded = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Padding(
//           padding: const EdgeInsets.only(right: 15),
//           child: Container(
//             height: 35,
//             decoration: BoxDecoration(
//               color: const Color(0xffD9D9D9),
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: const TextField(
              
//               decoration: InputDecoration(
//                 hintText: 'Cari',
//                 hintStyle: TextStyle(color: Colors.black),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.black,
//                 ),
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(48),
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//             ),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           'TravelEase $frontArrow',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xff000000),
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           'Penawaran & Promo $frontArrow',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xff000000),
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           'Promosi $frontArrow',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xff000000),
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           '[Voucher] $frontArrow',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xff000000),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Visibility(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 130),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: ListTile(
//                   title: Text(
//                     '[${widget.subsCategory}] ${widget.question}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xff000000),
//                     ),
//                   ),
//                   subtitle: Container(
//                     margin: EdgeInsets.only(top: 20),
//                     child: Text(
//                       widget.answer,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff000000),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 15),
//                         child: Text(
//                           'Artikel Terkait',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w800,
//                             color: Color.fromARGB(255, 47, 61, 102),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 2,
//                       ),
//                       Column(
//                         children: [
//                           ButtonArticle(
//                             onTap: () {
//                               setState(() {
//                                 _isExpanded = !_isExpanded;
//                               });
//                             },
//                             title:
//                                 '[${widget.subsCategory}] ${widget.question}',
//                             border: _isExpanded
//                                 ? const Border(
//                                     top: BorderSide(
//                                       color: Color(0xff366389),
//                                       width: 2,
//                                       style: BorderStyle.solid,
//                                     ),
//                                     bottom: BorderSide(
//                                       color: Color(0xff366389),
//                                       width: 2,
//                                       style: BorderStyle.solid,
//                                     ),
//                                   )
//                                 : const Border(
//                                     top: BorderSide(
//                                       color: Color(0xff969595),
//                                       width: 1,
//                                       style: BorderStyle.solid,
//                                     ),
//                                     bottom: BorderSide(
//                                       color: Color(0xff969595),
//                                       width: 1,
//                                       style: BorderStyle.solid,
//                                     ),
//                                   ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomSheet: Container(
//         height: 130,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(top: 5, left: 20),
//               child: Text(
//                 'Hubungi Kami',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             ChatOption(
//               onTap: () {
//                                 // ignore: avoid_types_as_parameter_names
//                                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  ReportPage(onCategorySelected: (int ) {  },)));

//               },
//               text: 'Pertanyaan Saya',
//               color: const Color(0xffC73437),
//               textColor: const Color(0xffC73437),
//             ),
//             ChatOption(
//               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBot()));

//               },
//               text: 'Chat Dengan TravelMate',
//               color: const Color(0xff6799C3),
//               textColor: const Color.fromRGBO(61, 96, 125, 1),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: const Color(0xffD9D9D9),
//     );
//   }
// }
