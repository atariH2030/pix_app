import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ReadQrCodeScreen extends StatefulWidget {
  const ReadQrCodeScreen({super.key});

  @override
  State<ReadQrCodeScreen> createState() => _ReadQrCodeScreenState();
}

class _ReadQrCodeScreenState extends State<ReadQrCodeScreen> {
  // O controller agora é usado para chamar métodos, não para ler estados diretamente.
  final MobileScannerController controller = MobileScannerController();
  bool isScanCompleted = false;

  void closeScreen() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ler QR Code'),
        actions: [
          // Botão para o flash
          IconButton(
            color: Colors.white,
            // O ícone agora é estático, o estado é gerido internamente pelo controller
            icon: const Icon(Icons.flash_on),
            iconSize: 32.0,
            onPressed: () => controller.toggleTorch(),
          ),
          // Botão para trocar de câmara
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.cameraswitch),
            iconSize: 32.0,
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              if (!isScanCompleted) {
                setState(() {
                  isScanCompleted = true;
                });

                final List<Barcode> barcodes = capture.barcodes;
                final String code = barcodes.isNotEmpty
                    ? barcodes.first.rawValue ?? 'Nenhum dado encontrado'
                    : 'Nenhum dado encontrado';

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: const Text('QR Code Lido com Sucesso!'),
                    content: Text('Conteúdo: $code'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o diálogo
                          closeScreen(); // Fecha a tela do scanner
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ).then((_) {
                  // Reativa o scan quando o diálogo é fechado
                  setState(() {
                    isScanCompleted = false;
                  });
                });
              }
            },
          ),
          // Sobreposição visual (o quadrado)
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal, width: 4),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
