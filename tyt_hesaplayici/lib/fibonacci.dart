import 'package:flutter/material.dart';

class Fibonacci extends StatefulWidget {
  const Fibonacci({super.key});

  @override
  State<Fibonacci> createState() => _FibonacciState();
}

class _FibonacciState extends State<Fibonacci> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';
  String _sumResult = '';
  int _selectedSegment = 0;
  int _bugFixIndex = 0;

  void _calculateFibonacci() {
    final int? number = int.tryParse(_numberController.text);
    if (number == null || number < 0) {
      setState(() {
        _result = 'Lütfen geçerli bir pozitif tam sayı girin.';
        _sumResult = '';
      });
      return;
    }

    if (_selectedSegment == 0) {
      BigInt a = BigInt.zero, b = BigInt.one; // BigInt ile başla
      int index = 1;

      // Fibonacci dizisinde girilen sayının yerini bulma
      while (b < BigInt.from(number)) {
        BigInt temp = a;
        a = b;
        b = temp + b;
        index++;
      }

      if (b == BigInt.from(number)) {
        setState(() {
          _result = '$number, Fibonacci dizisinde baştan $index. sıradadır.';
          _sumResult = '~';
        });
      } else {
        _bugFixIndex = index - 1;
        setState(() {
          _result =
              '$number, Fibonacci dizisinde ${a} ve ${b} arasında bulunur.';
          _sumResult =
              'Bu sayı, Fibonacci dizisinde $_bugFixIndex. terimden sonra gelir.';
        });
      }
    } else {
      BigInt a = BigInt.zero, b = BigInt.one; // BigInt ile başla
      int index = 1;

      // Girilen terim sayısına göre Fibonacci dizisi değerini bulma
      while (index < number) {
        BigInt temp = a;
        a = b;
        b = temp + b;
        index++;
      }

      setState(() {
        _result = 'Fibonacci dizisinde $number. terim: $b';
        _sumResult =
            'Bu terime kadar olan sayıların toplamı: ${_calculateFibonacciSum(number)}';
      });
    }
  }

  BigInt _calculateFibonacciSum(int term) {
    if (term <= 0) return BigInt.zero; // Geçersiz terim için toplam 0 döndür
    if (term == 1) return BigInt.zero; // Sadece ilk terim için toplam 0'dır

    BigInt a = BigInt.zero, b = BigInt.one; // BigInt ile başla
    BigInt sum = BigInt.one; // İlk terim 1 olduğu için başlangıç toplamı 1
    for (int i = 2; i < term; i++) {
      BigInt temp = a;
      a = b;
      b = temp + b;
      sum += b; // Toplama mevcut terimi ekle
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                "Fibonacci ile ilgili hesaplamak istediğiniz sayıyı girin:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _numberController,
                      decoration: InputDecoration(
                        labelText: 'Sayı girin',
                        border: OutlineInputBorder(),
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    children: [
                      ToggleButtons(
                        borderRadius: BorderRadius.circular(8),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Sırasını bul'),
                          ),
                        ],
                        isSelected: [_selectedSegment == 0],
                        onPressed: (index) {
                          setState(() {
                            _selectedSegment = 0;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      ToggleButtons(
                        borderRadius: BorderRadius.circular(8),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Sayıyı bul'),
                          ),
                        ],
                        isSelected: [_selectedSegment == 1],
                        onPressed: (index) {
                          setState(() {
                            _selectedSegment = 1;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateFibonacci,
                child: Text('Hesapla'),
              ),
              SizedBox(height: 20),
              if (_sumResult.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _result,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (_sumResult.isNotEmpty) SizedBox(height: 20),
              if (_sumResult.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _sumResult,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
