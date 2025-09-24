import 'package:flutter/material.dart';

class GenerateQrCodeScreen extends StatelessWidget {
  const GenerateQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receber PIX')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Apresente o QR Code para receber',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            // Em um app real, aqui estaria o widget que gera o QR Code.
            // Usamos um ícone grande como placeholder.
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.qr_code_2,
                size: 250,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sua Chave Aleatória: \n a1b2c3d4-e5f6-7890-gh12-ijklm3n4o5p6',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
