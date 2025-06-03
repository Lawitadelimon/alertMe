import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final nombreController = TextEditingController();
  final alergiasController = TextEditingController();
  final direccion1Controller = TextEditingController();
  final direccion2Controller = TextEditingController();
  final sexoController = TextEditingController();
  final edadController = TextEditingController();
  final contactoController = TextEditingController();
  final ubicacionController = TextEditingController();

  final List<String> tiposSangre = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? tipoSangreSeleccionado;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarDatosUsuario();
  }

  Future<void> cargarDatosUsuario() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          nombreController.text = data['nombre'] ?? '';
          tipoSangreSeleccionado = data['tipo_sangre'];
          alergiasController.text = data['alergias'] ?? '';
          direccion1Controller.text = data['direccion1'] ?? '';
          direccion2Controller.text = data['direccion2'] ?? '';
          sexoController.text = data['sexo'] ?? '';
          edadController.text = data['edad'] ?? '';
          contactoController.text = data['contacto'] ?? '';
          ubicacionController.text = data['ubicacion'] ?? '';
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    nombreController.dispose();
    alergiasController.dispose();
    direccion1Controller.dispose();
    direccion2Controller.dispose();
    sexoController.dispose();
    edadController.dispose();
    contactoController.dispose();
    ubicacionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AlertMe'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Mis Datos Personales',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildTextField('Nombre:', nombreController),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: tipoSangreSeleccionado,
                              decoration: const InputDecoration(
                                labelText: 'Tipo de sangre',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              ),
                              items: tiposSangre.map((tipo) {
                                return DropdownMenuItem(
                                  value: tipo,
                                  child: Text(tipo),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  tipoSangreSeleccionado = value;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            _buildTextField('Alergias o enfermedades:', alergiasController),
                            _buildTextField('Dirección:', direccion1Controller),
                            Row(
                              children: [
                                Expanded(child: _buildTextField('Sexo:', sexoController)),
                                const SizedBox(width: 16),
                                Expanded(child: _buildTextField('Edad:', edadController)),
                              ],
                            ),
                            _buildTextField('Dirección:', direccion2Controller),
                            _buildTextField('Contacto:', contactoController),
                            _buildTextField('Última ubicación:', ubicacionController),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: guardarDatosUsuario,
                                icon: const Icon(Icons.check_circle, color: Colors.green, size: 36),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }

  Future<void> guardarDatosUsuario() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('usuarios').doc(uid).set({
        'nombre': nombreController.text,
        'tipo_sangre': tipoSangreSeleccionado ?? '',
        'alergias': alergiasController.text,
        'direccion1': direccion1Controller.text,
        'sexo': sexoController.text,
        'edad': edadController.text,
        'direccion2': direccion2Controller.text,
        'contacto': contactoController.text,
        'ubicacion': ubicacionController.text,
        'actualizado': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos guardados correctamente')),
        );
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: usuario no autenticado')),
      );
    }
  }
}
