// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl =
      'https://theheistlabbackend-production.up.railway.app';

  static Future<int> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    if (email == '' || password == '') {
      print('Login failed: Email or Password cannot be empty');
      return 0;
    }

    if (!email.contains("@")) {
      print('Login failed: Invalid Email');
      return 3;
    }

    if (password.length < 5) {
      print('Login failed: Password Must be 5 Characters long.');
      return 4;
    }

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);
    int status_code = data['status_code'];

    if (status_code == 200) {
      String token = data['token'];
      saveUserSession(token);
      print('Login successful: $data');
      return 1;
    } else {
      print('Login failed: ${response.body}');
      return 2;
    }
  }

  static Future<int> registerUser(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    final url = Uri.parse('$baseUrl/auth/register');

    if (name == '' || email == '' || password == '') {
      print('Register failed: Name, Email or Password cannot be empty');
      return 0;
    }

    if (password != passwordConfirmation) {
      print('Register failed: Password Confirmation Missmatched.');
      return 2;
    }

    if (!email.contains("@")) {
      print('Register failed: Invalid Email');
      return 3;
    }

    if (password.length < 5) {
      print('Register failed: Password Must be 5 Characters long.');
      return 4;
    }

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
      }),
    );

    final data = jsonDecode(response.body);
    int status_code = data['status_code'];

    if (status_code == 200) {
      int otp = data['registered_user_details']['otp'];
      saveOTPData(otp.toString(), email);
      print('Register successful: $data');
      return 1;
    } else {
      print('Register failed: ${response.body}');
      return 5;
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
    if (old_otp != null && old_otp.isNotEmpty) {
      prefs.remove('otp');
      prefs.remove('otp_email');
      prefs.remove('otp_time');
    }
    await prefs.setString('otp', otp);
    await prefs.setString('otp_email', email);
    await prefs.setString(
      'otp_time',
      DateTime.now().millisecondsSinceEpoch.toString(),
    );
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

  static activateUser(otp) async {
    final prefs = await SharedPreferences.getInstance();
    final saved_otp = prefs.getString('otp');
    final otp_time = prefs.getString('otp_time');
    final otp_email = prefs.getString('otp_email');
    print('OTP details: ${otp} ${saved_otp} ${otp_email} ${otp_time}');
    final url = Uri.parse('$baseUrl/auth/activate-user');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": otp_email,
        "otp": otp,
        "saved_otp": saved_otp,
        "otp_time": otp_time,
      }),
    );

    final data = jsonDecode(response.body);
    int status_code = data['status_code'];

    if (status_code == 200) {
      print('OTP matched: $data');
      return 1;
    } else if (status_code == 500) {
      print('OTP expired');
      return 0;
    } else if (status_code == 501) {
      print('User not found');
      return 2;
    } else if (status_code == 502) {
      print('OTP Mismatched');
      return 3;
    }

    return 3;
  }

  static verifyForgotOtp(otp) async {
    final prefs = await SharedPreferences.getInstance();
    final saved_otp = prefs.getString('otp');
    final otp_time = prefs.getString('otp_time');
    final otp_email = prefs.getString('otp_email');
    print('OTP details: ${otp} ${saved_otp} ${otp_email} ${otp_time}');
    if (otp == saved_otp) {
      num current_time = DateTime.now().millisecondsSinceEpoch;
      final five_minutes = 5 * 60 * 1000;
      if (otp_time != null) {
        num? otpTimeInt = num.tryParse(otp_time);

        if (otpTimeInt != null && current_time - otpTimeInt > five_minutes) {
          return 0;
        } else {
          return 1;
        }
      } else {
        return 2;
      }
    } else {
      return 3;
    }
  }

  static resetPassword(old_password, password, password_confirmation) async {
    final prefs = await SharedPreferences.getInstance();
    final otp_email = prefs.getString('otp_email');
    print('OTP email: ${otp_email}');

    final url = Uri.parse('$baseUrl/auth/reset-password');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": otp_email,
        "old_password": old_password,
        "new_password": password,
        "password_confirmation": password_confirmation,
      }),
    );

    final data = jsonDecode(response.body);
    int status_code = data['status_code'];

    if (status_code == 200) {
      print('Password successfully reset: $data');
      return 1;
    } else if (status_code == 500) {
      print('Invalid old password');
      return 0;
    } else if (status_code == 501) {
      print('Password confirmation missmatched');
      return 2;
    } else if (status_code == 502) {
      print('User not found');
      return 3;
    }
  }
}
