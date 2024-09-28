import 'package:flutter/material.dart';
import 'ebob.dart';
import 'ekok.dart';
import 'asal_carpan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;
  int _currentIndex = 0; // Aktif sayfa indeksini tutan değişken

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkTheme 
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.black,
              scaffoldBackgroundColor: Colors.black,
              colorScheme: ColorScheme.dark(primary: Colors.purple),
            )
          : ThemeData.light().copyWith(
              primaryColor: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.light(primary: Colors.blue),
            ),
      home: HomeScreen(
        isDarkTheme: _isDarkTheme,
        toggleTheme: () {
          setState(() {
            _isDarkTheme = !_isDarkTheme;
          });
        },
        currentIndex: _currentIndex,
        onPageSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isDarkTheme;
  final Function toggleTheme;
  final int currentIndex;
  final Function(int) onPageSelected;

  HomeScreen({required this.isDarkTheme, required this.toggleTheme, required this.currentIndex, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(currentIndex)),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Yuvarlak köşeler
        ),
        elevation: 200, // Gölge efekti
        actions: [
          Icon(isDarkTheme ? Icons.nights_stay : Icons.wb_sunny),
          Switch(
            value: isDarkTheme,
            onChanged: (value) => toggleTheme(),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.blue[400],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkTheme ? Colors.purple : Colors.blue,
              ),
              child: Center(
                child: Text(
                  '~Developed by Dophin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Ana Sayfa'),
              onTap: () {
                onPageSelected(0); // Sayfa 1'i göster
                Navigator.pop(context); // Drawer'ı kapat
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('EBOB'),
              onTap: () {
                onPageSelected(1); // Sayfa EBOB göster
                Navigator.pop(context); // Drawer'ı kapat
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('EKOK'),
              onTap: () {
                onPageSelected(2); // Sayfa EKOK göster
                Navigator.pop(context); // Drawer'ı kapat
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Asal Çarpanlar'),
              onTap: () {
                onPageSelected(3); // Sayfa Asal Çarpnlar göster
                Navigator.pop(context); // Drawer'ı kapat
              },
            ),
          ],
        ),
      ),
      body: _getPage(currentIndex), // Seçili sayfayı göster
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage(onPageSelected: onPageSelected);
      case 1:
        return EBOB();
      case 2:
        return EKOK();
      case 3:
        return Asal_carpan();
      default:
        return HomePage(onPageSelected: onPageSelected); // Varsayılan olarak Sayfa 1'i göster
    }
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Ana Sayfa';
      case 1:
        return 'EBOB';
      case 2:
        return 'EKOK';
      case 3:
        return 'Asal Çarpanlar';
      default:
        return 'Ana Sayfa'; // Varsayılan başlık
    }
  }
}

class HomePage extends StatelessWidget {
  final Function(int) onPageSelected;

  HomePage({required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
              onPressed: () => onPageSelected(1), // EBOB sayfasına git
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 150), // Buton boyutu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Köşeleri düz
                ),
                elevation: 5, // Gölge efekti
                shadowColor: Colors.black45,
              ),
              child: Text('EBOB Hesapla'),
            ),
            ElevatedButton(
              onPressed: () => onPageSelected(2), // EKOK sayfasına git
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 150), // Buton boyutu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Köşeleri düz
                ),
                elevation: 5, // Gölge efekti
                shadowColor: Colors.black45,
              ),
              child: Text('EKOK Hesapla'),
            ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
              onPressed: () => onPageSelected(3),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 150), // Buton boyutu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Köşeleri düz
                ),
                elevation: 5, // Gölge efekti
                shadowColor: Colors.black45,
              ), // Asal çarpanlar sayfasına git
              child: Text('Asal Çarpanlar'),
            ),
              ],
            ),
            SizedBox(height: 80),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Daha fazla seçenek yakında",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}