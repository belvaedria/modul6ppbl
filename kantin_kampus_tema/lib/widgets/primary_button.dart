import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    // Warna, bentuk, dan padding tombol TIDAK dituliskan di sini karena
    // sudah diambil otomatis dari elevatedButtonTheme pada AppTheme
    // (lihat Kode Bagian E.b), sehingga seluruh PrimaryButton di aplikasi
    // otomatis konsisten dan otomatis menyesuaikan mode terang/gelap.
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
      label: Text(label),
    );
  }
}
