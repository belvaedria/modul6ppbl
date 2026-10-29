import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  Future<void> _kirimSemuaPengajuan(BuildContext context) async {
    final pengajuanCubit = context.read<PengajuanCubit>();
    final daftarPengajuan = List<String>.from(pengajuanCubit.state);

    if (daftarPengajuan.isEmpty) return;

    final setuju = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Kirim Semua Pengajuan'),
          content: Text(
            'Kirim ${daftarPengajuan.length} layanan sekaligus?\n\n'
            '${daftarPengajuan.join('\n')}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );

    if (setuju != true || !context.mounted) return;

    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;

    pengajuanCubit.kosongkan();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${daftarPengajuan.length} layanan selesai diproses '
          'dalam simulasi pengiriman.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Warga Nusantara',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'warga@nusantara.go.id',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Card(
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, modeTema) {
                final modeGelap = modeTema == ThemeMode.dark;

                return SwitchListTile(
                  secondary: Icon(
                    modeGelap ? Icons.dark_mode : Icons.light_mode,
                  ),
                  title: const Text('Mode Gelap'),
                  subtitle: Text(
                    modeGelap
                        ? 'Tampilan gelap sedang aktif'
                        : 'Tampilan terang sedang aktif',
                  ),
                  value: modeGelap,
                  onChanged: (value) {
                    context.read<ThemeCubit>().ubahTema(value);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            'Layanan Favorit',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          BlocBuilder<FavoritCubit, Set<String>>(
            builder: (context, favorit) {
              if (favorit.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Belum ada layanan favorit. '
                      'Tandai layanan dengan ikon bintang '
                      'pada halaman Layanan.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              final daftarFavorit = favorit.toList()..sort();

              return Card(
                child: Column(
                  children: daftarFavorit.map((nama) {
                    return ListTile(
                      leading: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      title: Text(nama),
                      trailing: IconButton(
                        tooltip: 'Hapus dari favorit',
                        icon: const Icon(Icons.star_border),
                        onPressed: () {
                          context
                              .read<FavoritCubit>()
                              .batalTandai(nama);
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          const Text(
            'Keranjang Pengajuan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          BlocBuilder<PengajuanCubit, List<String>>(
            builder: (context, daftarPengajuan) {
              if (daftarPengajuan.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Belum ada layanan dalam keranjang pengajuan.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return Card(
                child: Column(
                  children: [
                    ...daftarPengajuan.map((nama) {
                      return ListTile(
                        leading: const Icon(
                          Icons.assignment_outlined,
                        ),
                        title: Text(nama),
                        trailing: IconButton(
                          tooltip: 'Hapus dari pengajuan',
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            context.read<PengajuanCubit>().hapus(nama);
                          },
                        ),
                      );
                    }),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Total: ${daftarPengajuan.length} layanan',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          FilledButton.icon(
                            onPressed: () {
                              _kirimSemuaPengajuan(context);
                            },
                            icon: const Icon(Icons.send),
                            label: const Text('Kirim Semua Pengajuan'),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                context.read<PengajuanCubit>().kosongkan();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Keranjang pengajuan dikosongkan.',
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Kosongkan Keranjang'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.history),
              title: const Text(
                'Riwayat Laporan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Lihat laporan warga yang pernah dibuat',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.riwayatLaporan,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
