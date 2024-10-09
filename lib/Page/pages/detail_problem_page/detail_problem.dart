import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/ReportPage.dart';
import 'package:travelease_mobile/Page/chat_bot.dart';
import 'package:travelease_mobile/Page/pages/components/button_article.dart';
import '../components/chat_option.dart';

class DetailProblemPage extends StatefulWidget {
  const DetailProblemPage({super.key});

  @override
  State<DetailProblemPage> createState() => _DetailProblemPageState();
}

class _DetailProblemPageState extends State<DetailProblemPage> {
  final String frontArrow = '>';
  final String title = 'Voucher';
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(right: 15),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'TravelEase $frontArrow',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Penawaran & Promo $frontArrow',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Promosi $frontArrow',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '[Voucher] $frontArrow',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const ListTile(
                    title: Text(
                      '[Voucher] Bagaimana cara menggunakan kode voucher?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                    ),
                    subtitle: Text(
                      'Jika Anda memiliki kode Voucher selain yang didapatkan dari Shopee, Anda dapat memasukkan kode Voucher tersebut dengan masuk ke halaman Saya > pilih Voucher Saya > pilih Masukkan Kode Voucher > masukkan kode Voucher yang Anda miliki > pilih Simpan.\n\nVoucher yang berhasil tersimpan di halaman Voucher Saya dapat Anda gunakan saat melakukan pembayaran, sesuai Syarat dan Ketentuan yang berlaku.\n\nJika memasukkan kode Voucher yang tidak valid, maka sistem akan menampilkan pesan bahwa Voucher tidak tersedia.\n\n⚠Catatan: Jika Voucher tidak dapat dipilih, artinya barang pada keranjang Anda belum memenuhi Syarat & Ketentuan. Voucher yang diberikan oleh Shopee, didapatkan dari Daily Prize, dan/atau dibeli dari halaman Reward Koin Shopee akan otomatis masuk ke dalam Voucher Saya. Setiap Voucher yang telah disimpan memiliki Syarat & Ketentuan berbeda yang harus diikuti.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                      maxLines: 17,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Artikel Terkait',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      ButtonArticle(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        title:
                            '[$title] Bagaimana cara menggunakan voucher saat checkout',
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
                            : const Border(
                                top: BorderSide(
                                  color: Color(0xff969595),
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                                bottom: BorderSide(
                                  color: Color(0xff969595),
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                      ),
                      ButtonArticle(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        title:
                            '[$title] Dimana saya dapat menemukan voucher?',
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
                            : const Border(
                                top: BorderSide(
                                  color: Color(0xff969595),
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                                bottom: BorderSide(
                                  color: Color(0xff969595),
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                      ),
                    ],
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
              textColor: const Color(0xffC73437),
            ),
            ChatOption(
              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBot()));

              },
              text: 'Chat Dengan TravelMate',
              color: const Color(0xff6799C3),
              textColor: Color.fromRGBO(61, 96, 125, 1),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xffD9D9D9),
    );
  }
}
