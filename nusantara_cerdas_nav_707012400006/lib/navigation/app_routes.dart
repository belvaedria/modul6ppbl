import 'package:flutter/material.dart';
import '../pages/detail_layanan_page.dart';
import '../pages/layanan_page.dart';
import '../pages/pengaturan_kota_page.dart';
import '../pages/riwayat_laporan_page.dart';
import '../pages/route_tidak_dikenal_page.dart';
import '../pages/tentang_aplikasi_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail-layanan';
  static const String riwayatLaporan = '/riwayat-laporan';
  static const String pengaturanKota = '/pengaturan-kota';
  static const String tentangAplikasi = '/tentang-aplikasi';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      riwayatLaporan: (context) => const RiwayatLaporanPage(),
      pengaturanKota: (context) => const PengaturanKotaPage(),
      tentangAplikasi: (context) => const TentangAplikasiPage(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    switch (settings.name) {
      case detailLayanan:
        final layanan = settings.arguments as Layanan;

        return MaterialPageRoute(
          builder: (context) {
            return DetailLayananPage(
              layanan: layanan,
            );
          },
          settings: settings,
        );

      default:
        return null;
    }
  }

  static Route<dynamic> routeTidakDikenal(
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (context) {
        return RouteTidakDikenalPage(
          namaRoute: settings.name ?? 'Tidak diketahui',
        );
      },
    );
  }
}