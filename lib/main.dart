import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  final String? baseUrl = dotenv.env['BASE_URL'];
  final String? anonKey = dotenv.env['ANON_KEY'];

  if (baseUrl == null || anonKey == null) {
    throw Exception(
      'Missing environment variables. Please ensure BASE_URL and ANON_KEY are defined in your .env file.',
    );
  }

  await Supabase.initialize(url: baseUrl, anonKey: anonKey);

  runApp(ProviderScope(child: ShoppingApp()));
}
