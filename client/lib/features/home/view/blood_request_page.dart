
import 'package:flutter/material.dart';


class BloodRequestPage extends StatelessWidget {
  const BloodRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Request'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Blood Request Page'),
      ),
    );
  }
}