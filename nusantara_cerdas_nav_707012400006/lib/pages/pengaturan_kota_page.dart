import 'package:flutter/material.dart';

class PengaturanKotaPage extends StatelessWidget {
  const PengaturanKotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Kota'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              value: true,
              onChanged: (value) {},
              title: const Text(
                'Notifikasi Layanan',
              ),
              subtitle: const Text(
                'Terima informasi terbaru dari pemerintah kota',
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Bahasa'),
              subtitle: const Text('Bahasa Indonesia'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Wilayah Kota'),
              subtitle: const Text('Kota Nusantara'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}