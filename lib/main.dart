import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'screens/note_editor_screen.dart';
import 'widgets/bottom_appbar.dart';
import 'providers/note_provider.dart';
import 'screens/home_page.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Noteprovider())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartApp(),
    );
  }
}

class StartApp extends StatefulWidget {
  const StartApp({super.key});

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<Noteprovider>(context, listen: false).loadsNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Noteprovider>();

    void goCreateNote() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreateNoteScreen()),
      );
    }

    if (!provider.isLoading) {
      return Scaffold(
        bottomNavigationBar: BottomAppbarWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff1565C0),
          onPressed: () {
            goCreateNote();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(child: HomeScreen(note: provider.notes)),
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
