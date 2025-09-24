import 'package:flutter/material.dart';
import 'package:pix_app/screens/generate_qr_code_screen.dart'; // IMPORTAR
import 'package:pix_app/screens/pix_copy_paste_screen.dart'; // IMPORTAR
import 'package:pix_app/screens/read_qr_code_screen.dart'; // IMPORTAR
import 'package:pix_app/screens/send_pix_screen.dart';

class PixHomeScreen extends StatelessWidget {
  const PixHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área PIX')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildActionCard(
              icon: Icons.send,
              label: 'Enviar PIX',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SendPixScreen(),
                  ),
                );
              },
            ),
            _buildActionCard(
              icon: Icons.qr_code_scanner,
              label: 'Ler QR Code',
              // ATUALIZAR NAVEGAÇÃO
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReadQrCodeScreen(),
                  ),
                );
              },
            ),
            _buildActionCard(
              icon: Icons.content_copy,
              label: 'PIX Copia e Cola',
              // ATUALIZAR NAVEGAÇÃO
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PixCopyPasteScreen(),
                  ),
                );
              },
            ),
            _buildActionCard(
              icon: Icons.receipt_long,
              label: 'Receber PIX',
              // ATUALIZAR NAVEGAÇÃO
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenerateQrCodeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    // ... (O resto do código permanece igual)
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.teal),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
