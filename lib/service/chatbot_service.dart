import 'dart:convert';
import 'package:http/http.dart' as http;

class Chatbot_service {
  static const String baseUrl = 'http://192.168.39.147/api/conversation';

  // Fungsi untuk mengambil initial nodes (node percakapan pertama)
  Future<List<dynamic>> fetchInitialNodes() async {
    final response = await http.get(Uri.parse('$baseUrl/initial'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['nodes'];  // Mengambil list nodes dari response API
    } else {
      throw Exception('Failed to load initial nodes');
    }
  }

  // Fungsi untuk mengambil child nodes
  Future<List<dynamic>> fetchChildNodes(int parentId) async {
    final response = await http.get(Uri.parse('$baseUrl/children/$parentId'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['nodes'];  // Mengambil list nodes dari response API
    } else {
      throw Exception('Failed to load child nodes');
    }
  }

  // Fungsi untuk mengambil detail node berdasarkan ID
  Future<Map<String, dynamic>> fetchNode(int nodeId) async {
    final response = await http.get(Uri.parse('$baseUrl/node/$nodeId'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load node');
    }
  }

  // Fungsi untuk mengambil seluruh path percakapan dari node ke root
  Future<List<dynamic>> fetchConversationPath(int nodeId) async {
    final response = await http.get(Uri.parse('$baseUrl/path/$nodeId'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load conversation path');
    }
  }
}

