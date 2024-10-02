import 'package:flutter/material.dart';
import 'package:tyt_hesaplayici/ardisik_toplam.dart';
import 'package:tyt_hesaplayici/derece.dart';
import 'package:tyt_hesaplayici/faktoriyel.dart';
import 'package:tyt_hesaplayici/fibonacci.dart';
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
                  '~Developed by Yunus',
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
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Örüntülü Toplam'),
              onTap: () {
                onPageSelected(4); // Sayfa Asal Çarpnlar göster
                Navigator.pop(context); // Drawer'ı kapat
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Faktöriyel'),
              onTap: () {
                onPageSelected(5); // Sayfa Asal Çarpnlar göster
                Navigator.pop(context); // Drawer'ı kapat
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Fibonacci'),
              onTap: () {
                onPageSelected(6); // Sayfa Asal Çarpnlar göster
                Navigator.pop(context); // Drawer'ı kapat
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Derece Hesaplama'),
              onTap: () {
                onPageSelected(7); // Sayfa Asal Çarpnlar göster
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
      case 4:
        return ArdisikToplam();
      case 5:
        return Faktoriyel();
      case 6:
        return Fibonacci();
      case 7:
        return DerececHesap();
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
      case 4:
        return 'Örüntülü Toplamlar';
      case 5:
        return 'Faktöriyel';
      case 6:
        return 'Fibonacci';
      case 7:
        return 'Derece Hesaplama';
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                _buildCustomButton(context, "EBOB Hesaplama", () => onPageSelected(1)),
                _buildCustomButton(context, "EKOK Hesaplama", () => onPageSelected(2)),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                _buildCustomButton(context, "Asal Çarpanlar", () => onPageSelected(3)),
                _buildCustomButton(context, "Örüntülü Toplam", () => onPageSelected(4)),
              ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                _buildCustomButton(context, "Faktöriyel", () => onPageSelected(5)),
                _buildCustomButton(context, "Fibonacci", () => onPageSelected(6)),
              ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                _buildCustomButton(context, "Derece Hesaplama", () => onPageSelected(7)),
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
      ),
    );
  }

  Widget _buildCustomButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(150, 150), // Buton boyutu
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Köşeleri düz
        ),
        elevation: 5, // Gölge efekti
        backgroundColor: Theme.of(context).colorScheme.primary, // Buton rengi
        foregroundColor: Colors.white, // Metin rengi
        shadowColor: Colors.black45, // Gölge rengi
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}