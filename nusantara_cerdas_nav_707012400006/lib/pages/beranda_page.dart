import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pilar = [
      {
        'nama': 'Smart Governance',
        'ikon': Icons.account_balance,
        'deskripsi':
            'Pemerintahan yang transparan dan pelayanan publik berbasis digital.',
      },
      {
        'nama': 'Smart Economy',
        'ikon': Icons.trending_up,
        'deskripsi':
            'Pengembangan ekonomi dan peluang usaha melalui teknologi.',
      },
      {
        'nama': 'Smart Living',
        'ikon': Icons.home,
        'deskripsi':
            'Peningkatan kualitas hidup masyarakat melalui layanan kota.',
      },
      {
        'nama': 'Smart Mobility',
        'ikon': Icons.directions_bus,
        'deskripsi':
            'Transportasi yang aman, mudah, dan terintegrasi.',
      },
      {
        'nama': 'Smart Environment',
        'ikon': Icons.eco,
        'deskripsi':
            'Pengelolaan lingkungan yang bersih dan berkelanjutan.',
      },
      {
        'nama': 'Smart People',
        'ikon': Icons.people,
        'deskripsi':
            'Masyarakat yang aktif, berpengetahuan, dan adaptif terhadap teknologi.',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_city,
                  color: Colors.white,
                  size: 56,
                ),
                SizedBox(height: 12),
                Text(
                  'Kota Nusantara',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Menuju Kota Cerdas dan Berkelanjutan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Enam Pilar Smart City',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pilar.length,
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 450,
              mainAxisExtent: 150,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final item = pilar[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        item['ikon'] as IconData,
                        size: 40,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['nama'] as String,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['deskripsi'] as String,
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}