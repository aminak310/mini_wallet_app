import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://aeuesiaqqhflnowheoco.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFldWVzaWFxcWhmbG5vd2hlb2NvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE2NTIxMDMsImV4cCI6MjA4NzIyODEwM30.mM_Uo0cfYnmF7-62jKGJm25vum3sZtOsu_KEOTLWc4U',
  );

  runApp(const MiniWalletApp());
}

class MiniWalletApp extends StatelessWidget {
  const MiniWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mini Wallet",
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}