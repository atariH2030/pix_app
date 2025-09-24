import 'package:flutter/material.dart';

class SendPixScreen extends StatefulWidget {
  const SendPixScreen({super.key});

  @override
  State<SendPixScreen> createState() => _SendPixScreenState();
}

class _SendPixScreenState extends State<SendPixScreen> {
  final _formKey = GlobalKey<FormState>();
  final _keyController = TextEditingController();
  final _amountController = TextEditingController();

  // ETAPA 1: Criar a função que mostra o diálogo de confirmação.
  void _showConfirmationDialog() {
    final key = _keyController.text;
    final amount = _amountController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Transferência'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você está prestes a enviar:'),
                SizedBox(height: 8),
                Text(
                  'R\$ $amount',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text('Para a chave PIX:'),
                Text(
                  key,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(
                  context,
                ).pop(); // Apenas fecha o diálogo de confirmação
              },
            ),
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () {
                // Em um app real, a chamada à API aconteceria aqui.
                print(
                  'Transferência Confirmada! Chave: $key, Valor: R\$ $amount',
                );

                // Fecha o diálogo de confirmação
                Navigator.of(context).pop();
                // Volta para a tela principal (home)
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar PIX')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _keyController,
                decoration: const InputDecoration(
                  labelText: 'Chave PIX (CPF, e-mail, telefone...)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a chave PIX.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                  border: OutlineInputBorder(),
                  prefixText: 'R\$ ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor.';
                  }
                  // Tenta converter o valor para double, aceitando vírgula como decimal
                  final formattedValue = value.replaceAll(',', '.');
                  if (double.tryParse(formattedValue) == null) {
                    return 'Por favor, insira um número válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                // ETAPA 2: Chamar a nova função de diálogo aqui.
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Se o formulário for válido, mostramos o diálogo de confirmação.
                    _showConfirmationDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Transferir'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _keyController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
