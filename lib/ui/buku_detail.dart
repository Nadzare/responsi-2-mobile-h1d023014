import 'package:flutter/material.dart';
import 'package:responsi2mobilepaket3_h1d023014/helpers/api_url.dart';
import 'package:responsi2mobilepaket3_h1d023014/helpers/user_info.dart';
import 'package:responsi2mobilepaket3_h1d023014/models/buku.dart';
import 'package:responsi2mobilepaket3_h1d023014/ui/buku_form.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BukuDetail extends StatefulWidget {
  final Buku buku;

  const BukuDetail({Key? key, required this.buku}) : super(key: key);

  @override
  _BukuDetailState createState() => _BukuDetailState();
}

class _BukuDetailState extends State<BukuDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Buku Kafahmart',
          style: TextStyle(fontWeight: FontWeight.bold),
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
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber[100]!, Colors.yellow[100]!],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.amber[300]!, Colors.amber[100]!],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.4),
                            blurRadius: 15,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.book_rounded,
                        size: 80,
                        color: Colors.amber[900],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.buku.judul ?? '-',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[900],
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildDetailCard(
                      icon: Icons.person,
                      label: 'Penulis',
                      value: widget.buku.penulis ?? '-',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailCard(
                      icon: Icons.business,
                      label: 'Penerbit',
                      value: widget.buku.penerbit ?? '-',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailCard(
                      icon: Icons.attach_money,
                      label: 'Harga',
                      value: 'Rp ${widget.buku.harga?.toString() ?? '0'}',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailCard(
                      icon: Icons.inventory,
                      label: 'Jumlah Stok',
                      value: '${widget.buku.jumlah?.toString() ?? '0'} unit',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailCard(
                      icon: Icons.library_books,
                      label: 'Volume',
                      value: widget.buku.volume ?? '-',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailCard(
                      icon: Icons.calendar_today,
                      label: 'Tanggal Masuk',
                      value: widget.buku.tanggalMasuk ?? '-',
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                      Expanded(
                        child: Container(
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
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: const Text(
                              'EDIT',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BukuForm(buku: widget.buku),
                                ),
                              ).then((value) {
                                if (value == true) {
                                  Navigator.pop(context, true);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.red[600]!, Colors.red[400]!],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            label: const Text(
                              'HAPUS',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => confirmHapus(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  Widget _buildDetailCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.amber[50]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber[300]!, Colors.amber[100]!],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.amber[900], size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void confirmHapus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text(
              'Apakah Anda yakin ingin menghapus buku "${widget.buku.judul}"?'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  const Text('Hapus', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                hapus();
              },
            ),
          ],
        );
      },
    );
  }

  void hapus() async {
    try {
      String? token = await UserInfo().getToken();
      
      print('🗑️ Deleting data from: ${ApiUrl.deleteBuku(widget.buku.id!)}');
      
      final response = await http.delete(
        Uri.parse(ApiUrl.deleteBuku(widget.buku.id!)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('📥 Status Code: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == true || data['message'] != null) {
          if (mounted) {
            print('✅ Data berhasil dihapus');
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Sukses'),
                  content: const Text('Data berhasil dihapus'),
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
        } else {
          if (mounted) {
            _showWarningDialog(data['message'] ?? 'Gagal menghapus data');
          }
        }
      } else {
        if (mounted) {
          _showWarningDialog('Gagal menghapus data');
        }
      }
    } catch (e) {
      if (mounted) {
        _showWarningDialog('Terjadi kesalahan: ${e.toString()}');
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
}
