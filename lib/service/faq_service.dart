import 'dart:convert';
import 'package:http/http.dart' as http;

// Fungsi untuk mengambil kategori FAQ beserta subkategori dan FAQ terkait
Future<List<dynamic>> getFaqCategoriesWithSubcategoriesAndFaqs() async {
  
  final response = await http.get(
    
    Uri.parse('http://192.168.1.145:8000/api/faqs/categories-with-faqs'),  // Ganti dengan URL API Anda
  );

  if (response.statusCode == 200) {
    print('$response');
    // Jika response berhasil, parse JSON
    return json.decode(response.body);
  } else {
    // Jika terjadi error
    throw Exception('Failed to load categories with subcategories and faqs');
  }
}


