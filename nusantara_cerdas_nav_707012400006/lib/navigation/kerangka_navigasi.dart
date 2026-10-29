import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int indeksAktif = 0;

  final List<Widget> halaman = const [
    BerandaPage(),
    LayananPage(),
    WargaPage(),
  ];

  void pindahTujuan(int indeks) {
    setState(() {
      indeksAktif = indeks;
    });
  }

  void bukaDrawerRoute(String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  Widget ikonWargaDenganBadge(IconData ikon) {
    return BlocSelector<PengajuanCubit, List<String>, int>(
      selector: (daftar) => daftar.length,
      builder: (context, total) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(ikon),
            if (total > 0)
              Positioned(
                right: -10,
                top: -7,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    total > 99 ? '99+' : '$total',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onError,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool layarLebar = MediaQuery.of(context).size.width >= 600;

    return PopScope(
      canPop: indeksAktif == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && indeksAktif != 0) {
          setState(() {
            indeksAktif = 0;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Nusantara Cerdas')),
        drawer: NavigationDrawer(
          selectedIndex: indeksAktif < 3 ? indeksAktif : null,
          onDestinationSelected: (indeks) {
            if (indeks == 0) {
              Navigator.pop(context);
              pindahTujuan(0);
            } else if (indeks == 1) {
              Navigator.pop(context);
              pindahTujuan(1);
            } else if (indeks == 2) {
              Navigator.pop(context);
              pindahTujuan(2);
            } else if (indeks == 3) {
              bukaDrawerRoute(AppRoutes.pengaturanKota);
            } else if (indeks == 4) {
              bukaDrawerRoute(AppRoutes.tentangAplikasi);
            } else if (indeks == 5) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Keluar'),
                    content: const Text(
                      'Apakah Anda yakin ingin keluar dari aplikasi?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Keluar'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(28, 24, 16, 16),
              child: Text(
                'Nusantara Cerdas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: Text('Beranda'),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.miscellaneous_services_outlined),
              selectedIcon: Icon(Icons.miscellaneous_services),
              label: Text('Layanan'),
            ),
            NavigationDrawerDestination(
              icon: ikonWargaDenganBadge(Icons.person_outline),
              selectedIcon: ikonWargaDenganBadge(Icons.person),
              label: const Text('Warga'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: Text('Pengaturan Kota'),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.info_outline),
              selectedIcon: Icon(Icons.info),
              label: Text('Tentang Aplikasi'),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.logout),
              selectedIcon: Icon(Icons.logout),
              label: Text('Keluar'),
            ),
          ],
        ),
        body: Row(
          children: [
            if (layarLebar)
              NavigationRail(
                selectedIndex: indeksAktif,
                onDestinationSelected: pindahTujuan,
                labelType: NavigationRailLabelType.all,
                destinations: [
                  const NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Beranda'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.miscellaneous_services_outlined),
                    selectedIcon: Icon(Icons.miscellaneous_services),
                    label: Text('Layanan'),
                  ),
                  NavigationRailDestination(
                    icon: ikonWargaDenganBadge(Icons.person_outline),
                    selectedIcon: ikonWargaDenganBadge(Icons.person),
                    label: const Text('Warga'),
                  ),
                ],
              ),
            Expanded(
              child: IndexedStack(index: indeksAktif, children: halaman),
            ),
          ],
        ),
        bottomNavigationBar: layarLebar
            ? null
            : NavigationBar(
                selectedIndex: indeksAktif,
                onDestinationSelected: pindahTujuan,
                destinations: [
                  const NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Beranda',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.miscellaneous_services_outlined),
                    selectedIcon: Icon(Icons.miscellaneous_services),
                    label: 'Layanan',
                  ),
                  NavigationDestination(
                    icon: ikonWargaDenganBadge(Icons.person_outline),
                    selectedIcon: ikonWargaDenganBadge(Icons.person),
                    label: 'Warga',
                  ),
                ],
              ),
      ),
    );
  }
}
