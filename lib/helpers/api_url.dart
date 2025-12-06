class ApiUrl {
  static const String baseUrl = 'http://192.168.100.13:8080';

  static const String registrasi = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String listBuku = '$baseUrl/books';
  static const String createBuku = '$baseUrl/books';

  static String updateBuku(int id) {
    return '$baseUrl/books/$id';
  }

  static String showBuku(int id) {
    return '$baseUrl/books/$id';
  }

  static String deleteBuku(int id) {
    return '$baseUrl/books/$id';
  }
}
