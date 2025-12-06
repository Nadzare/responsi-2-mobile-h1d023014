import 'package:flutter/material.dart';
import 'package:responsi2mobilepaket3_h1d023014/helpers/api_url.dart';
import 'package:responsi2mobilepaket3_h1d023014/helpers/user_info.dart';
import 'package:responsi2mobilepaket3_h1d023014/models/buku.dart';
import 'package:responsi2mobilepaket3_h1d023014/ui/buku_detail.dart';
import 'package:responsi2mobilepaket3_h1d023014/ui/buku_form.dart';
import 'package:responsi2mobilepaket3_h1d023014/ui/login_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BukuPage extends StatefulWidget {
  const BukuPage({Key? key}) : super(key: key);

  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  List<Buku> listBuku = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      String? token = await UserInfo().getToken();
      print('🔍 Token: $token');
      print('🔍 Fetching data from: ${ApiUrl.listBuku}');
      
      // Coba tanpa authorization dulu
      final response = await http.get(
        Uri.parse(ApiUrl.listBuku),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('📥 Status Code: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('📦 Parsed Data: $data');
        
        // Cek berbagai kemungkinan struktur response
        if (data is List) {
          // Jika response langsung array
          setState(() {
            listBuku = data.map((json) => Buku.fromJson(json)).toList();
          });
          print('✅ Data loaded: ${listBuku.length} buku');
        } else if (data['status'] == true && data['data'] != null) {
          // Jika response dengan wrapper status
          var bukuData = data['data'] as List;
          setState(() {
            listBuku = bukuData.map((json) => Buku.fromJson(json)).toList();
          });
          print('✅ Data loaded: ${listBuku.length} buku');
        } else if (data['data'] != null) {
          // Jika hanya ada key 'data'
          var bukuData = data['data'] as List;
          setState(() {
            listBuku = bukuData.map((json) => Buku.fromJson(json)).toList();
          });
          print('✅ Data loaded: ${listBuku.length} buku');
        } else {
          print('⚠️ Unexpected data structure');
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('❌ Error: $e');
      print('📍 StackTrace: $stackTrace');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventaris Buku Kafahmart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber[700]!, Colors.amber[500]!],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BukuForm()),
              ).then((value) {
                if (value == true) {
                  getData();
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog();
            },
          ),
        ],
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
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(color: Colors.amber[700]))
            : listBuku.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada data buku',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: getData,
                    color: Colors.amber[700],
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: listBuku.length,
                      itemBuilder: (context, index) {
                        return ItemBuku(
                          buku: listBuku[index],
                          onRefresh: getData,
                        );
                      },
                    ),
                  ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber[700]!, Colors.amber[500]!],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white, size: 32),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BukuForm()),
            ).then((value) {
              if (value == true) {
                getData();
              }
            });
          },
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                await UserInfo().logout();
                if (mounted) {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class ItemBuku extends StatelessWidget {
  final Buku buku;
  final Function onRefresh;

  const ItemBuku({Key? key, required this.buku, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[50]!, Colors.yellow[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BukuDetail(buku: buku),
              ),
            ).then((value) {
              if (value == true) {
                onRefresh();
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber[300]!, Colors.amber[100]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.book_rounded,
                    size: 40,
                    color: Colors.amber[800],
                  ),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buku.judul ?? '-',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[900],
                        letterSpacing: 0.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Penulis: ${buku.penulis ?? '-'}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green[400]!, Colors.green[300]!],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Rp ${buku.harga?.toString() ?? '0'}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Stok: ${buku.jumlah?.toString() ?? '0'} unit',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.amber[700]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
