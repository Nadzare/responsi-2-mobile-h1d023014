import 'package:flutter/material.dart';
import 'package:responsi2mobilepaket3_h1d023014/helpers/api_url.dart';
import 'package:responsi2mobilepaket3_h1d023014/ui/login_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  final _konfirmasiPasswordTextboxController = TextEditingController();

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
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Daftar Akun',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
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
                          _namaTextField(),
                          const SizedBox(height: 20),
                          _emailTextField(),
                          const SizedBox(height: 20),
                          _passwordTextField(),
                          const SizedBox(height: 20),
                          _passwordKonfirmasiTextField(),
                          const SizedBox(height: 30),
                          _buttonRegistrasi(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _menuLogin(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama",
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
        prefixIcon: Icon(Icons.person, color: Colors.amber[700]),
      ),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama harus diisi";
        }
        return null;
      },
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
          return "Password harus diisi";
        }
        if (value.length < 6) {
          return "Password minimal 6 karakter";
        }
        return null;
      },
    );
  }

  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Konfirmasi Password",
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
        prefixIcon: Icon(Icons.lock_outline, color: Colors.amber[700]),
      ),
      obscureText: true,
      controller: _konfirmasiPasswordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Konfirmasi Password harus diisi";
        }
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password tidak sama";
        }
        return null;
      },
    );
  }

  Widget _buttonRegistrasi() {
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
                "Registrasi",
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
      print('=== REGISTRASI DEBUG ===');
      print('URL: ${ApiUrl.registrasi}');
      print('Nama: ${_namaTextboxController.text}');
      print('Email: ${_emailTextboxController.text}');
      print('Password: ${_passwordTextboxController.text}');

      final response = await http.post(
        Uri.parse(ApiUrl.registrasi),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nama': _namaTextboxController.text,
          'email': _emailTextboxController.text,
          'password': _passwordTextboxController.text,
        }),
      );

      // Debug: Print response
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        
        // Cek status bisa berupa boolean true atau string "success"
        bool isSuccess = (data['status'] == true || 
                         data['status'] == 'success' ||
                         data['message']?.toLowerCase().contains('berhasil') == true);
        
        if (isSuccess) {
          if (mounted) {
            _showSuccessDialog();
          }
        } else {
          if (mounted) {
            _showWarningDialog(data['message'] ?? 'Registrasi gagal');
          }
        }
      } else {
        if (mounted) {
          _showWarningDialog('Registrasi gagal. Status: ${response.statusCode}');
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

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sukses'),
          content: const Text('Registrasi berhasil! Silakan login.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
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

  Widget _menuLogin() {
    return Center(
      child: InkWell(
        child: const Text(
          "Sudah punya akun? Login",
          style: TextStyle(color: Colors.brown, fontSize: 16),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
