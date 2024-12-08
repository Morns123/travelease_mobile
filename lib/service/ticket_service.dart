import 'dart:convert';
import 'package:http/http.dart' as http;

class Ticket_service {
  
  Future<List<dynamic>> getTicket() async {
  
  final response = await http.get(
    
    Uri.parse('http://192.168.1.10:8000/api/ticket'),  // Ganti dengan URL API Anda
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

}