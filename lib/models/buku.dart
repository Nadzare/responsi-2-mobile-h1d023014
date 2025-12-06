class Buku {
  int? id;
  String? judul;
  int? harga;
  int? jumlah;
  String? tanggalMasuk;
  String? volume;
  String? penulis;
  String? penerbit;

  Buku({
    this.id,
    this.judul,
    this.harga,
    this.jumlah,
    this.tanggalMasuk,
    this.volume,
    this.penulis,
    this.penerbit,
  });

  factory Buku.fromJson(Map<String, dynamic> obj) {
    return Buku(
      id: obj['id'],
      judul: obj['judul'],
      harga: obj['harga'],
      jumlah: obj['jumlah'],
      tanggalMasuk: obj['tanggal_masuk'],
      volume: obj['volume']?.toString(), // Convert to String safely
      penulis: obj['penulis'],
      penerbit: obj['penerbit'],
    );
  }
}
