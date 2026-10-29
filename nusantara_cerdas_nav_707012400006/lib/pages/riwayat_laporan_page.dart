import 'package:flutter/material.dart';

class RiwayatLaporanPage extends StatelessWidget {
  const RiwayatLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Laporan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.report_problem),
              title: Text('Lampu Jalan Rusak'),
              subtitle: Text(
                'Status: Sedang ditangani',
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text('Sampah Menumpuk'),
              subtitle: Text(
                'Status: Selesai',
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.directions_bus),
              title: Text('Halte Rusak'),
              subtitle: Text(
                'Status: Menunggu penanganan',
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Membuat laporan baru',
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text('Daftar laporan'),
                  ),
                );
              },
              icon: const Icon(Icons.list),
            ),
            const SizedBox(width: 40),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text('Laporan tersimpan'),
                  ),
                );
              },
              icon: const Icon(Icons.bookmark),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text('Menyaring laporan'),
                  ),
                );
              },
              icon: const Icon(Icons.filter_list),
            ),
          ],
        ),
      ),
    );
  }
}