import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/keranjang_cubit.dart';
import '../models/produk.dart';
import '../widgets/cart_summary_bar.dart';
import '../widgets/theme_toggle_button.dart';

class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        actions: const [ThemeToggleButton()],
      ),
      body: BlocBuilder<KeranjangCubit, List<ItemKeranjang>>(
        builder: (context, daftarItem) {
          final totalItem = daftarItem.fold(0, (a, b) => a + b.jumlah);
          final totalHarga = daftarItem.fold(0, (a, b) => a + b.subtotal);
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: daftarItem.length,
                  itemBuilder: (context, index) {
                    final item = daftarItem[index];
                    return ListTile(
                      title: Text(item.produk.nama),
                      subtitle: Text('${item.jumlah} x Rp${item.produk.harga}'),
                      trailing: Text('Rp${item.subtotal}'),
                    );
                  },
                ),
              ),
              CartSummaryBar(
                totalItem: totalItem,
                totalHarga: totalHarga,
                onKosongkan: () => context.read<KeranjangCubit>().kosongkan(),
              ),
            ],
          );
        },
      ),
    );
  }
}
