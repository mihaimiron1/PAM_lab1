import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator salariu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const SalaryCalculator(),
    );
  }
}

class SalaryCalculator extends StatefulWidget {
  const SalaryCalculator({super.key});

  @override
  State<SalaryCalculator> createState() => _SalaryCalculatorState();
}

class _SalaryCalculatorState extends State<SalaryCalculator> {
  final TextEditingController salaryController = TextEditingController();

  String selectedEmployeeType = 'Angajat standard';

  double netSalary = 0;
  double taxes = 0;

  double getTaxRate() {
    if (selectedEmployeeType == 'Angajat standard') {
      return 0.20;
    } else if (selectedEmployeeType == 'Angajat cu scutire') {
      return 0.15;
    } else {
      return 0.25;
    }
  }

  void calculateSalary() {
    double grossSalary =
        double.tryParse(salaryController.text) ?? 0;

    double taxRate = getTaxRate();

    setState(() {
      taxes = grossSalary * taxRate;
      netSalary = grossSalary - taxes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator salariu'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Salariu brut',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: salaryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Introduceți salariul brut',
                border: OutlineInputBorder(),
                suffixText: 'MDL',
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Tip angajat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: selectedEmployeeType,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),

              items: const [
                DropdownMenuItem(
                  value: 'Angajat standard',
                  child: Text('Angajat standard - 20%'),
                ),
                DropdownMenuItem(
                  value: 'Angajat cu scutire',
                  child: Text('Angajat cu scutire - 15%'),
                ),
                DropdownMenuItem(
                  value: 'Angajat fără scutire',
                  child: Text('Angajat fără scutire - 25%'),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  selectedEmployeeType = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateSalary,
                child: const Text(
                  'CALCULEAZĂ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Rezultat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              'Salariu net: ${netSalary.toStringAsFixed(2)} MDL',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              'Suma impozitelor: ${taxes.toStringAsFixed(2)} MDL',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}