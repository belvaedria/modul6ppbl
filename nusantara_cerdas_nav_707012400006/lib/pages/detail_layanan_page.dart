import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import 'layanan_page.dart';

class DetailLayananPage extends StatefulWidget {
  final Layanan layanan;

  const DetailLayananPage({
    super.key,
    required this.layanan,
  });

  @override
  State<DetailLayananPage> createState() =>
      _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  bool sedangMengirim = false;
  Future<void> ajukanPermohonan() async {
    if (sedangMengirim) return;
    setState(() {
      sedangMengirim = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    context.read<PengajuanCubit>().tambah(widget.layanan.nama);

    Navigator.pop(
      context,
      'Permohonan ${widget.layanan.nama.toLowerCase()} '
      'telah ditambahkan ke keranjang pengajuan.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final layanan = widget.layanan;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Layanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.miscellaneous_services,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              layanan.nama,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _Informasi(
              label: 'Dinas Penanggung Jawab',
              nilai: layanan.dinas,
              ikon: Icons.account_balance,
            ),
            _Informasi(
              label: 'Jam Operasional',
              nilai: layanan.jamOperasional,
              ikon: Icons.access_time,
            ),
            _Informasi(
              label: 'Keterangan',
              nilai: layanan.keterangan,
              ikon: Icons.info_outline,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed:
                    sedangMengirim ? null : ajukanPermohonan,
                icon: sedangMengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  sedangMengirim
                      ? 'Sedang mengirim...'
                      : 'Ajukan Permohonan',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Informasi extends StatelessWidget {
  final String label;
  final String nilai;
  final IconData ikon;

  const _Informasi({
    required this.label,
    required this.nilai,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ikon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(nilai),
              ],
            ),
          ),
        ],
      ),
    );
  }
}