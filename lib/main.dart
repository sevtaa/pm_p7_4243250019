import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/tugas_provider.dart';
import 'router/app_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TugasProvider(),
      child: const TugasApp(),
    ),
  );
}

class TugasApp extends StatelessWidget {
  const TugasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Planner Tugas Kuliah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      routerConfig: appRouter,
    );
  }
}
