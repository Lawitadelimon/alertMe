import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceSearchPage extends StatefulWidget {
  const DeviceSearchPage({super.key});

  @override
  State<DeviceSearchPage> createState() => _DeviceSearchPageState();
}

class _DeviceSearchPageState extends State<DeviceSearchPage> {
  final List<ScanResult> scanResults = [];
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    startScan();
  }

  void startScan() async {
    setState(() {
      isScanning = true;
      scanResults.clear();
    });

    // Inicia escaneo
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    // Escucha resultados
    FlutterBluePlus.scanResults.listen((results) {
      for (var result in results) {
        if (!scanResults.any((r) => r.device.remoteId == result.device.remoteId)) {
          setState(() {
            scanResults.add(result);
          });
        }
      }
    });

    // Espera y detiene escaneo
    await Future.delayed(const Duration(seconds: 5));
    await FlutterBluePlus.stopScan();

    setState(() {
      isScanning = false;
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conectado a ${device.platformName}')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar: $e')),
      );
    }
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Dispositivo'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: isScanning
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: scanResults.length,
              itemBuilder: (context, index) {
                final result = scanResults[index];
                return ListTile(
                  leading: const Icon(Icons.watch),
                  title: Text(result.device.platformName.isNotEmpty
                      ? result.device.platformName
                      : 'Dispositivo sin nombre'),
                  subtitle: Text(result.device.remoteId.str),
                  trailing: ElevatedButton(
                    onPressed: () => connectToDevice(result.device),
                    child: const Text('Conectar'),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: startScan,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
