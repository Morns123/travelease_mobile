import 'dart:convert';
import 'package:http/http.dart' as http;

class FaqService {
  static const String baseUrl = 'https://10.0.2.2:8000/api/faqs/faq';

  static Future<List<String>> fetchFaqs() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((faq) => faq['question'] as String).toList();
    } else {
      throw Exception('Failed to load FAQs');
    }
  }

  // Future<Map<String, dynamic>> fetchPosts(int page) async {
  //   final response = await http.get(Uri.parse('$baseUrl/posts?page=$page'));

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     List<Post> posts = (data['data']['data'] as List)
  //         .map((postJson) => Post.fromJson(postJson))
  //         .toList();
  //     return {
  //       'posts': posts,
  //       'nextPageUrl': data['data']['next_page_url'],
  //     };
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
}
