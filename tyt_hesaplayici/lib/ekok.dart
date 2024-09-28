import 'package:flutter/material.dart';

class EKOK extends StatefulWidget {
  const EKOK ({super.key});

  @override
  State<EKOK> createState() => _EKOKState();
}

class _EKOKState extends State<EKOK> {

  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  String _result = '';

  int _calculateGCD(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  void _calculate() {
    int? firstNumber = int.tryParse(_firstNumberController.text);
    int? secondNumber = int.tryParse(_secondNumberController.text);

    if (firstNumber != null && secondNumber != null) {
      int gcd = _calculateGCD(firstNumber, secondNumber);
      int sonuc = ((firstNumber * secondNumber) / gcd).round();
      setState(() {
        _result = '$sonuc';
      });
    } else {
      setState(() {
        _result = 'Lütfen geçerli sayılar girin!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "En büyük ortak bölenini hesaplamak istediğiniz sayıyı girin.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _firstNumberController,
              decoration: InputDecoration(
                labelText: 'Birinci Sayı',
                border: OutlineInputBorder(),
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _secondNumberController,
              decoration: InputDecoration(
                labelText: 'İkinci Sayı',
                border: OutlineInputBorder(),
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
              child: Text('Hesapla'),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "EKOK = $_result",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}