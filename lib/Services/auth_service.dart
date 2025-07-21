// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://theheistlabbackend-production.up.railway.app';

  static Future<bool> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);
    int status_code = data['status_code'];
    String token = data['token'];

    if (status_code == 200) {
      saveUserSession(token);
      print('Login successful: $data');
      return true;
    } else {
      print('Login failed: ${response.body}');
      return false;
    }

  }

  static Future<bool> registerUser(String name, String email, String password, String passwordConfirmation) async {
    final url = Uri.parse('$baseUrl/auth/register');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password, "password_confirmation": passwordConfirmation}),
    );

    final data = jsonDecode(response.body);
    int status_code = data['status_code'];

    if (status_code == 200) {
      int otp = data['registered_user_details']['otp'];
      saveOTPData(otp.toString(), email);
      print('Register successful: $data');
      return true;
    } else {
      print('Register failed: ${response.body}');
      return false;
    }

  }

  static saveUserSession(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    // You can also store user name, email etc.
  }

  static saveOTPData(String otp, String email) async {
    final prefs = await SharedPreferences.getInstance();
    final old_otp = prefs.getString('otp');
    if(old_otp != null && old_otp.isNotEmpty) {
      prefs.remove('otp');
      prefs.remove('email');
      prefs.remove('otp_time');
    }
    await prefs.setString('otp', otp);
    await prefs.setString('email', email);
    await prefs.setString('otp_time', DateTime.now().millisecondsSinceEpoch.toString());
  }



  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
  }

  static sendForgotOtpEmail(String email) async {
    final url = Uri.parse('$baseUrl/auth/send-forgot-otp');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    final data = jsonDecode(response.body);
    //print('here response body: $data');
    //return true;
    int status_code = data['status_code'];
    int otp = data['otp'];

    if (status_code == 200) {
      saveOTPData(otp.toString(), email);
      print('OTP successfully sent: $data');
      return true;
    } else {
      print('OTP failed to be sent: ${response.body}');
      return false;
    }

  }

  static activateUser() {

  }

}
