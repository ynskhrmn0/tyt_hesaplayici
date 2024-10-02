import 'package:flutter/material.dart';

class Faktoriyel extends StatefulWidget {
  const Faktoriyel({super.key});

  @override
  State<Faktoriyel> createState() => _FaktoriyelState();
}

class _FaktoriyelState extends State<Faktoriyel> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';
  String _digitCount = '';

  void _calculate() {
    final int? number = int.tryParse(_numberController.text);
    if (number == null || number < 0) {
      setState(() {
        _result = 'Lütfen geçerli bir pozitif tam sayı girin.';
        _digitCount = '';
      });
      return;
    }

    BigInt factorial = BigInt.one;
    for (int i = 1; i <= number; i++) {
      factorial *= BigInt.from(i);
    }

    setState(() {
      _result = '$factorial';
      _digitCount = '${factorial.toString().length}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Faktöriyelini hesaplamak istediğiniz sayıyı girin:",
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
                  "Faktöriyel = $_result",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Basamak Sayısı = $_digitCount",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}