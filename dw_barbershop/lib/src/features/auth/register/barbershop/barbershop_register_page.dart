import 'package:dw_barbershop/src/core/ui/widgets/hour_panel.dart';
import 'package:dw_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:flutter/material.dart';

class BarberhsopRegisterPage extends StatefulWidget {
  const BarberhsopRegisterPage({super.key});

  @override
  State<BarberhsopRegisterPage> createState() => _BarberhsopRegisterPageState();
}

class _BarberhsopRegisterPageState extends State<BarberhsopRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('E-mail'),
                ),
              ),
              const SizedBox(height: 24),
              WeekdaysPanel(
                onDayPressed: (value) {
                  print('Dia selecionado: $value');
                },
              ),
              const SizedBox(height: 24),
              HoursPanel(
                startTime: 6,
                endTime: 23,
                onHourPressed: (value) {
                  print('Hora selecionada: $value');
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: const Text('CADASTRAR ESTABELECIMENTO'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
