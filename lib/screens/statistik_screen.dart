import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tugas_provider.dart';

class StatistikScreen extends StatelessWidget {
  const StatistikScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TugasProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Tugas'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildStatCard(
              context,
              'Total Tugas',
              '${provider.totalTugas}',
              Icons.folder_shared,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildStatCard(
              context,
              'Tugas Selesai',
              '${provider.tugasSelesai}',
              Icons.check_circle_outline,
              Colors.green,
            ),
            const SizedBox(height: 16),
            _buildStatCard(
              context,
              'Tugas Aktif (Belum Selesai)',
              '${provider.tugasAktif}',
              Icons.hourglass_empty,
              Colors.orange,
            ),
            const SizedBox(height: 24),
            LinearProgressIndicator(
              value: provider.persentaseSelesai / 100,
              minHeight: 12,
              backgroundColor: Colors.grey.shade300,
              color: Colors.teal,
            ),
            const SizedBox(height: 12),
            Text(
              'Persentase Penyelesaian: ${provider.persentaseSelesai.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
