import 'dart:convert';

class Barang {
  final int? id;
  final String nama;
  final int stok;

  Barang({
    this.id,
    required this.nama,
    required this.stok,
  });

  Barang copyWith({
    int? id,
    String? nama,
    int? stok,
  }) {
    return Barang(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      stok: stok ?? this.stok,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'stok': stok,
    };
  }

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      id: map['id'] as int?,
      nama: map['nama'] as String,
      stok: map['stok'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Barang.fromJson(String source) =>
      Barang.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Barang(id: $id, nama: $nama, stok: $stok)';
  }
}
