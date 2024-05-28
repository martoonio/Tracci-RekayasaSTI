import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:reksti/global/global_var.dart';

class RegistCarScreen extends StatefulWidget {
  const RegistCarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistCarScreenState createState() => _RegistCarScreenState();
}

class _RegistCarScreenState extends State<RegistCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _platNomorController = TextEditingController();
  final _modelController = TextEditingController();
  final _tipeController = TextEditingController();
  final _tahunController = TextEditingController();

  registCar() {
    DatabaseReference car = carsListAvailable.push();

    car.set({
      'platNomor': _platNomorController.text,
      'model': _modelController.text,
      'tipe': _tipeController.text,
      'tahun': _tahunController.text,
      'id': car.key,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Car'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _platNomorController,
                  decoration: const InputDecoration(labelText: 'Car Number'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter car number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(labelText: 'Car Model'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter car model';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _tipeController,
                  decoration: const InputDecoration(labelText: 'Car Color'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter car color';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _tahunController,
                  decoration: const InputDecoration(labelText: 'Car Year'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter car year';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registCar();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
