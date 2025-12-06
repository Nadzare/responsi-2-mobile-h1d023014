import 'package:flutter/material.dart';
import 'package:responsi2mobilepaket3_h1d023014/helpers/api_url.dart';
import 'package:responsi2mobilepaket3_h1d023014/helpers/user_info.dart';
import 'package:responsi2mobilepaket3_h1d023014/models/buku.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BukuForm extends StatefulWidget {
  final Buku? buku;

  BukuForm({Key? key, this.buku}) : super(key: key);

  @override
  _BukuFormState createState() => _BukuFormState();
}

class _BukuFormState extends State<BukuForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _judulTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();
  final _tanggalMasukTextboxController = TextEditingController();
  final _volumeTextboxController = TextEditingController();
  final _penulisTextboxController = TextEditingController();
  final _penerbitTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.buku != null) {
      _judulTextboxController.text = widget.buku!.judul ?? '';
      _hargaTextboxController.text = widget.buku!.harga?.toString() ?? '';
      _jumlahTextboxController.text = widget.buku!.jumlah?.toString() ?? '';
      _tanggalMasukTextboxController.text = widget.buku!.tanggalMasuk ?? '';
      _volumeTextboxController.text = widget.buku!.volume ?? '';
      _penulisTextboxController.text = widget.buku!.penulis ?? '';
      _penerbitTextboxController.text = widget.buku!.penerbit ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.buku == null
              ? 'Tambah Inventaris Kafahmart'
              : 'Edit Inventaris Kafahmart',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber[700]!, Colors.amber[500]!],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.amber[50]!,
              Colors.yellow[50]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _judulTextField(),
                  const SizedBox(height: 16),
                  _penulisTextField(),
                  const SizedBox(height: 16),
                  _penerbitTextField(),
                  const SizedBox(height: 16),
                  _hargaTextField(),
                  const SizedBox(height: 16),
                  _jumlahTextField(),
                  const SizedBox(height: 16),
                  _volumeTextField(),
                  const SizedBox(height: 16),
                  _tanggalMasukTextField(),
                  const SizedBox(height: 30),
                  _buttonSimpan(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _judulTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Judul Buku",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
        ),
        prefixIcon: Icon(Icons.book_rounded, color: Colors.amber[700]),
      ),
      controller: _judulTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Judul harus diisi";
        }
        return null;
      },
    );
  }

  Widget _penulisTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Penulis",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
        ),
        prefixIcon: Icon(Icons.person, color: Colors.amber[700]),
      ),
      controller: _penulisTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Penulis harus diisi";
        }
        return null;
      },
    );
  }

  Widget _penerbitTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Penerbit",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
        ),
        prefixIcon: Icon(Icons.business, color: Colors.amber[700]),
      ),
      controller: _penerbitTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Penerbit harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Harga (Rp)",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
        ),
        prefixIcon: Icon(Icons.attach_money, color: Colors.amber[700]),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jumlahTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Jumlah Stok",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
        ),
        prefixIcon: Icon(Icons.inventory, color: Colors.amber[700]),
      ),
      keyboardType: TextInputType.number,
      controller: _jumlahTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah harus diisi";
        }
        return null;
      },
    );
  }

  Widget _volumeTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Volume",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
        ),
        prefixIcon: Icon(Icons.library_books, color: Colors.amber[700]),
      ),
      controller: _volumeTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Volume harus diisi";
        }
        return null;
      },
    );
  }

  Widget _tanggalMasukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tanggal Masuk (YYYY-MM-DD)",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
        ),
        prefixIcon: Icon(Icons.calendar_today, color: Colors.amber[700]),
      ),
      controller: _tanggalMasukTextboxController,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.amber[700]!,
                  onPrimary: Colors.white,
                  onSurface: Colors.amber[900]!,
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          String formattedDate =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          setState(() {
            _tanggalMasukTextboxController.text = formattedDate;
          });
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal masuk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSimpan() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[700]!, Colors.amber[500]!],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.4),
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
            : Text(
                widget.buku == null ? "SIMPAN" : "UPDATE",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              widget.buku == null ? simpan() : ubah();
            }
          }
        },
      ),
    );
  }

  void simpan() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String? token = await UserInfo().getToken();
      
      var requestBody = {
        'judul': _judulTextboxController.text,
        'harga': int.parse(_hargaTextboxController.text),
        'jumlah': int.parse(_jumlahTextboxController.text),
        'tanggal_masuk': _tanggalMasukTextboxController.text,
        'volume': _volumeTextboxController.text,
        'penulis': _penulisTextboxController.text,
        'penerbit': _penerbitTextboxController.text,
      };
      
      print('📤 Sending data to: ${ApiUrl.createBuku}');
      print('📤 Request Body: $requestBody');
      
      final response = await http.post(
        Uri.parse(ApiUrl.createBuku),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      print('📥 Status Code: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        // Cek berbagai kemungkinan response sukses
        if (data['status'] == true || response.statusCode == 201) {
          if (mounted) {
            print('✅ Data berhasil disimpan');
            _showSuccessDialog('Data berhasil disimpan');
          }
        } else {
          if (mounted) {
            print('⚠️ ${data['message'] ?? 'Gagal menyimpan data'}');
            _showWarningDialog(data['message'] ?? 'Gagal menyimpan data');
          }
        }
      } else {
        if (mounted) {
          _showWarningDialog('Gagal menyimpan data');
        }
      }
    } catch (e) {
      if (mounted) {
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

  void ubah() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String? token = await UserInfo().getToken();
      
      var requestBody = {
        'judul': _judulTextboxController.text,
        'harga': int.parse(_hargaTextboxController.text),
        'jumlah': int.parse(_jumlahTextboxController.text),
        'tanggal_masuk': _tanggalMasukTextboxController.text,
        'volume': _volumeTextboxController.text,
        'penulis': _penulisTextboxController.text,
        'penerbit': _penerbitTextboxController.text,
      };
      
      print('📤 Updating data to: ${ApiUrl.updateBuku(widget.buku!.id!)}');
      print('📤 Request Body: $requestBody');
      
      final response = await http.put(
        Uri.parse(ApiUrl.updateBuku(widget.buku!.id!)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      print('📥 Status Code: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == true || data['message'] != null) {
          if (mounted) {
            print('✅ Data berhasil diupdate');
            _showSuccessDialog('Data berhasil diupdate');
          }
        } else {
          if (mounted) {
            _showWarningDialog(data['message'] ?? 'Gagal mengupdate data');
          }
        }
      } else {
        if (mounted) {
          _showWarningDialog('Gagal mengupdate data');
        }
      }
    } catch (e) {
      if (mounted) {
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

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sukses'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(true);
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

  @override
  void dispose() {
    _judulTextboxController.dispose();
    _hargaTextboxController.dispose();
    _jumlahTextboxController.dispose();
    _tanggalMasukTextboxController.dispose();
    _volumeTextboxController.dispose();
    _penulisTextboxController.dispose();
    _penerbitTextboxController.dispose();
    super.dispose();
  }
}
