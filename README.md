# pix_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# pix_app




# Projeto 2: Simulação de Aplicativo de Área PIX em Flutter

Este documento detalha o processo de criação de uma aplicação Flutter que simula as funcionalidades de uma "Área PIX". O projeto foca em navegação entre múltiplas telas, uso de formulários para entrada de dados, e integração com hardware do dispositivo (câmera) através de pacotes externos.

## 1. Como Construir o Projeto do Zero

Assumindo um ambiente com o Flutter SDK já configurado e funcional.

### 1.1. Criação do Projeto

Execute os seguintes comandos num terminal (Git Bash, CMD, etc.) num diretório de desenvolvimento apropriado (ex: `C:\dev`), evitando pastas sincronizadas com a nuvem (OneDrive, Google Drive).

```bash
# Navegue para a sua pasta de desenvolvimento
cd C:/dev/

# Crie o projeto Flutter
flutter create pix_app

# Entre na pasta do projeto
cd pix_app
1.2. Adicionar Dependências
Este projeto requer o pacote mobile_scanner para a funcionalidade de leitura de QR Code.

Bash

# Adiciona o pacote ao projeto (isto atualiza o ficheiro pubspec.yaml)
flutter pub add mobile_scanner
1.3. Configuração de Permissões Nativas
Para aceder à câmera, é necessário solicitar permissão nos ficheiros de configuração de cada plataforma.

Android
Ficheiro: android/app/src/main/AndroidManifest.xml

Ação: Adicionar a permissão de câmera dentro da tag <manifest>:

XML

<manifest xmlns:android="[http://schemas.android.com/apk/res/android](http://schemas.android.com/apk/res/android)">
    <uses-permission android:name="android.permission.CAMERA" />
    <application
        ...
iOS
Ficheiro: ios/Runner/Info.plist

Ação: Adicionar a descrição de uso da câmera dentro da tag principal <dict>:

XML

<key>NSCameraUsageDescription</key>
<string>Esta aplicação precisa de acesso à câmera para ler os QR Codes do PIX.</string>
1.4. Estrutura de Pastas
Organize o código criando a seguinte estrutura dentro da pasta lib:

lib/

screens/ (Pasta para todas as telas da aplicação)

main.dart

2. Anatomia do Código
Ficheiro: lib/main.dart
O ponto de entrada da aplicação. Configura o tema geral e define a tela inicial.

MaterialApp: Widget raiz que fornece funcionalidades essenciais como navegação e temas.

ThemeData: Personaliza a aparência da aplicação. Definimos a cor primária como Colors.teal e estilizámos a AppBar para ser consistente em todas as telas.

home: Aponta para a PixHomeScreen, a nossa tela principal.

Dart

import 'package:flutter/material.dart';
import 'package:pix_app/screens/pix_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.teal;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PIX App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const PixHomeScreen(),
    );
  }
}
Ficheiro: lib/screens/pix_home_screen.dart
A tela principal que serve como um menu de navegação para as outras funcionalidades.

GridView.count: Usado para criar uma grelha de botões com duas colunas, um layout comum para menus de apps.

_buildActionCard(...): Uma função auxiliar privada para construir os cartões de ação, evitando repetição de código. Cada cartão é um InkWell envolvendo um Card para ter um visual clicável com elevação.

Navigator.push: A função principal para navegação. Quando um cartão é pressionado, ela "empurra" uma nova tela para a pilha de navegação, levando o utilizador até ela.

Ficheiro: lib/screens/send_pix_screen.dart
Tela para enviar um PIX, contendo um formulário com validação.

StatefulWidget: Necessário para gerir o estado dos TextEditingControllers e da GlobalKey do formulário.

Form e GlobalKey<FormState>: O Form agrupa os campos de texto, e a _formKey permite-nos validar todos os campos de uma só vez com _formKey.currentState!.validate().

TextFormField: Um campo de texto com capacidades de validação. A propriedade validator define as regras (ex: não pode estar vazio, deve ser um número).

AlertDialog: Usado para criar um diálogo de confirmação, melhorando a experiência do utilizador ao permitir a revisão dos dados antes de finalizar a ação.

Ficheiro: lib/screens/read_qr_code_screen.dart
Implementa a funcionalidade de scanner de QR Code usando a câmera.

MobileScannerController: O objeto do pacote mobile_scanner que nos dá controlo sobre a câmera (ligar/desligar flash, trocar de câmera).

MobileScanner: O widget que exibe a visualização da câmera e deteta os códigos.

onDetect: Uma função callback que é executada quando um código é lido com sucesso. Dentro dela, capturamos o valor do código, exibimo-lo num AlertDialog e navegamos de volta.

dispose(): É crucial chamar controller.dispose() para libertar os recursos da câmera quando a tela é fechada.

Ficheiros Adicionais (Simulações)
lib/screens/pix_copy_paste_screen.dart: Simula a tela para pagamentos com "PIX Copia e Cola", contendo um TextField de múltiplas linhas.

lib/screens/generate_qr_code_screen.dart: Simula a tela de "Receber PIX", exibindo um ícone grande como placeholder para o QR Code a ser gerado.
