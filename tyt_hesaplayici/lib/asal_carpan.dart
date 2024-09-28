import 'package:flutter/material.dart';

class Asal_carpan extends StatefulWidget {
  @override
  _Asal_carpanState createState() => _Asal_carpanState();
}

class _Asal_carpanState extends State<Asal_carpan> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';

  List<int> _primeFactors(int n) {
    List<int> factors = [];
    for (int i = 2; i <= n; i++) {
      while (n % i == 0) {
        factors.add(i);
        n ~/= i;
      }
    }
    return factors;
  }

  void _calculate() {
    int? number = int.tryParse(_numberController.text);

    if (number != null && number > 0) {
      List<int> factors = _primeFactors(number);
      setState(() {
        _result = '${factors.join(', ')}';
      });
    } else {
      setState(() {
        _result = 'Lütfen geçerli bir sayı girin!';
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
              "Asal Çarpanlarını hesaplamak istediğiniz sayıyı girin.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Sayı girin',
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Asal Çarpanlar = $_result",
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
