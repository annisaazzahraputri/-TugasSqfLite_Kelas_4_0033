
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/model/barang.dart';
import 'package:flutter_application_1/presentation/controller/barang_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void tampilkanForm(
    BuildContext context,
    BarangController ctr, {
    Barang? barang,
  }) {
    final namaController =
        TextEditingController(text: barang?.nama ?? '');

    final stokController =
        TextEditingController(text: barang?.stok.toString() ?? '');

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            barang == null ? 'Tambah Barang' : 'Edit Barang',
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Barang',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama barang harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: stokController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Stok Barang',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final stok = int.tryParse(value ?? '');

                    if (stok == null || stok < 0) {
                      return 'Masukkan stok yang valid';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final data = Barang(
                    id: barang?.id,
                    nama: namaController.text.trim(),
                    stok: int.parse(stokController.text),
                  );

                  if (barang == null) {
                    ctr.tambahBarang(data);
                  } else {
                    ctr.updateBarang(data);
                  }

                  Navigator.pop(context);
                }
              },
              child: Text(
                barang == null ? 'Simpan' : 'Update',
              ),
            ),
          ],
        );
      },
    ).then((_) {
      namaController.dispose();
      stokController.dispose();
    });
  }

  void konfirmasiHapus(
    BuildContext context,
    BarangController ctr,
    Barang barang,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Barang'),
          content: Text(
            'Yakin ingin menghapus ${barang.nama}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ctr.hapusBarang(barang.id!);
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctr = Get.find<BarangController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Barang SQLite'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (ctr.barangList.isEmpty) {
          return const Center(
            child: Text('Data Barang Belum Ada'),
          );
        }

        return ListView.builder(
          itemCount: ctr.barangList.length,
          itemBuilder: (context, index) {
            final barang = ctr.barangList[index];

            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              child: ListTile(
                title: Text(
                  barang.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('Stok Barang: ${barang.stok}'),
                leading: CircleAvatar(
                  child: Text('${barang.id}'),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        tampilkanForm(
                          context,
                          ctr,
                          barang: barang,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        konfirmasiHapus(
                          context,
                          ctr,
                          barang,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tampilkanForm(context, ctr);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
