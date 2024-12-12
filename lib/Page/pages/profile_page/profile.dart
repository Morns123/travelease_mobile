import 'package:flutter/material.dart';
import 'package:travelease_mobile/Page/login.dart';
import 'package:travelease_mobile/widget/components/field.dart';
import 'package:travelease_mobile/service/api_service.dart';
import 'package:http/http.dart' as http;


class ProfilePage extends StatefulWidget {
  final String token;
  const ProfilePage({required this.token});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String token;
  bool isEditing = false;
 final ApiService apiService = ApiService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = true;

   void initState() {
    super.initState();
    _fetchUserProfile();
    
  }

  Future<void> logout(BuildContext context) async {
    token = widget.token;
    final response = await http.post(
      Uri.parse('http://192.168.1.145:8000/api/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Logout berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully logged out')),
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      // Logout gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to logout: ${response.body}')),
      );
    }
  }

  void _fetchUserProfile() async {
    try {
      final response = await apiService.getProfile(widget.token);
      if (response['success']) {
        setState(() {
          _nameController.text = response['data']['user']['name'];
          _emailController.text = response['data']['user']['email'];
          _isLoading = false;
        });
      } else {
        _showError(response['message']);
      }
    } catch (e) {
      _showError('Failed to load profile');
    }
  }

void _updateProfile() async {
  final response = await apiService.updateProfile(
    widget.token,
    _nameController.text,
    _emailController.text,
  );

  print('Response: $response'); // Tambahkan log di sini
  if (response['success']) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully')),
    );
  } else {
    _showError(response['message']);
  }
}


    void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $message')),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6799C3),
        foregroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () => logout(context),
            child: Container(
              margin: EdgeInsets.only(right: 20),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 85, 74),
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: Icon(Icons.logout,color: Colors.white,),
                  ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xff6799C3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(300),
                      bottomRight: Radius.circular(300),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: 
                     _isLoading
                        ? CircularProgressIndicator() 
                        : Text(
                            _nameController.text,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                SizedBox(
                  width: 320,
                  child: MyTextField(
                    textEditingController: _nameController,
                    prefixIcon: Icons.person_outlined,
                    enabled: isEditing,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 320,
                  child: MyTextField(
                    textEditingController: _emailController,
                    prefixIcon: Icons.email_outlined,
                    enabled: isEditing,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(250, 45)),
                    backgroundColor: WidgetStatePropertyAll(
                      Color(0xff6799C3),
                    ),
                    shadowColor: WidgetStatePropertyAll(Colors.grey),
                    elevation: WidgetStatePropertyAll(1),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
    if (isEditing) {
      _updateProfile(); // Kirim perubahan ke API jika dalam mode edit
    }
    setState(() {
      isEditing = !isEditing; // Ubah mode edit setelah penyimpanan
    });
  },
  child: Text(
    isEditing ? 'Save Profile' : 'Edit Profile',
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xffffffff),
    ),
  ),
                ),
                
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(65),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 1,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person_outline_outlined,
                    color: Color(0xff366389),
                    size: 100,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
