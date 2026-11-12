import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/tugas_provider.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double lebarLayar = MediaQuery.sizeOf(context).width;
    final bool isWideScreen = lebarLayar >= 840;

    // Memakai context.select agar badge navigasi hanya rebuild saat jumlah tugas aktif berubah
    final int jumlahAktif = context.select((TugasProvider p) => p.tugasAktif);

    final destinations = [
      NavigationDestination(
        icon: Badge.count(
          count: jumlahAktif,
          isLabelVisible: jumlahAktif > 0,
          child: const Icon(Icons.list_alt_outlined),
        ),
        selectedIcon: Badge.count(
          count: jumlahAktif,
          isLabelVisible: jumlahAktif > 0,
          child: const Icon(Icons.list_alt),
        ),
        label: 'Tugas',
      ),
      const NavigationDestination(
        icon: Icon(Icons.add_task_outlined),
        selectedIcon: Icon(Icons.add_task),
        label: 'Tambah',
      ),
      const NavigationDestination(
        icon: Icon(Icons.bar_chart_outlined),
        selectedIcon: Icon(Icons.bar_chart),
        label: 'Statistik',
      ),
    ];

    if (isWideScreen) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              destinations: destinations.map((d) {
                return NavigationRailDestination(
                  icon: d.icon,
                  selectedIcon: d.selectedIcon,
                  label: Text(d.label),
                );
              }).toList(),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: destinations,
      ),
    );
  }
}
