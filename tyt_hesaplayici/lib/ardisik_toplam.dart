import 'package:flutter/material.dart';

class ArdisikToplam extends StatefulWidget {
  const ArdisikToplam({super.key});

  @override
  State<ArdisikToplam> createState() => _ArdisikToplamState();
}

class _ArdisikToplamState extends State<ArdisikToplam> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _stepController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  String _result = '';
  String _termCount = '';

  void _calculateSum() {
    final int start = int.tryParse(_startController.text) ?? 0;
    final int step = int.tryParse(_stepController.text) ?? 0;
    final int end = int.tryParse(_endController.text) ?? 0;
    int sum = 0;
    int count = 0;

    for (int i = start; i <= end; i += step) {
      sum += i;
      count++;
    }

    setState(() {
      _result = '$sum';
      _termCount = '$count';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'İlk sayıyı, artış miktarını ve son sayıyı girin:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            TextField(
              controller: _startController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'İlk Sayı',
                border: OutlineInputBorder(),
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _stepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Artış Miktarı',
                border: OutlineInputBorder(),
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _endController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Son Sayı',
                border: OutlineInputBorder(),
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateSum,
              child: Text('Hesapla'),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Tüm Sayıların Toplamı = $_result",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Terim Sayısı = $_termCount",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      );
  }
}