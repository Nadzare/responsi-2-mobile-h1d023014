import 'package:flutter/material.dart';
import 'package:responsi2mobilepaket3_h1d023014/helpers/api_url.dart';
import 'package:responsi2mobilepaket3_h1d023014/helpers/user_info.dart';
import 'package:responsi2mobilepaket3_h1d023014/ui/registrasi_page.dart';
import 'package:responsi2mobilepaket3_h1d023014/ui/buku_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.amber[700]!,
              Colors.amber[400]!,
              Colors.yellow[300]!,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.book_rounded,
                        size: 80,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Kafahmart',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sistem Inventaris Buku',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _emailTextField(),
                          const SizedBox(height: 20),
                          _passwordTextField(),
                          const SizedBox(height: 30),
                          _buttonLogin(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _menuRegistrasi(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
        ),
        prefixIcon: Icon(Icons.email, color: Colors.amber[700]),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
        ),
        prefixIcon: Icon(Icons.lock, color: Colors.amber[700]),
      ),
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Password harus diisi';
        }
        return null;
      },
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[700]!, Colors.amber[500]!],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Login",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) _submit();
          }
        },
      ),
    );
  }

  void _submit() async {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      // Debug: Print data yang akan dikirim
      print('=== LOGIN DEBUG ===');
      print('URL: ${ApiUrl.login}');
      print('Email: ${_emailTextboxController.text}');

      final response = await http.post(
        Uri.parse(ApiUrl.login),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _emailTextboxController.text,
          'password': _passwordTextboxController.text,
        }),
      );

      // Debug: Print response
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        
        // Cek status bisa berupa boolean true atau string "success"
        bool isSuccess = (data['status'] == true || 
                         data['status'] == 'success' ||
                         data['message']?.toLowerCase().contains('berhasil') == true);
        
        if (isSuccess && data['data'] != null) {
          // Simpan token dan user_id jika ada
          if (data['data']['token'] != null) {
            await UserInfo().setToken(data['data']['token']);
          }
          if (data['data']['id'] != null) {
            await UserInfo().setUserID(data['data']['id']);
          } else if (data['data']['user_id'] != null) {
            await UserInfo().setUserID(data['data']['user_id']);
          }
          
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BukuPage()),
            );
          }
        } else {
          if (mounted) {
            _showWarningDialog(data['message'] ?? 'Login gagal');
          }
        }
      } else {
        if (mounted) {
          _showWarningDialog('Login gagal. Status: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (mounted) {
        print('ERROR: $e');
        _showWarningDialog('Terjadi kesalahan: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peringatan'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Belum punya akun? Registrasi",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
      ),
    );
  }
}
