import 'package:flutter/material.dart';

class AppHome extends StatefulWidget {
  final String title;

  const AppHome({super.key, required this.title});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final TextEditingController _baseController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  String _resultado = 'Aún no se ha calculado ningún resultado.';

  void _calcularArea() {
    final double? base = double.tryParse(_baseController.text.trim());
    final double? altura = double.tryParse(_alturaController.text.trim());

    if (base == null || altura == null) {
      setState(() {
        _resultado = 'Ingresa valores numéricos válidos en Base y Altura.';
      });
      return;
    }

    final double area = (base * altura) / 2;
    setState(() {
      _resultado = 'Área del triángulo: ${area.toStringAsFixed(2)}';
    });
  }

  void _calcularParametro() {
    final double? base = double.tryParse(_baseController.text.trim());

    if (base == null) {
      setState(() {
        _resultado = 'Ingresa un valor numérico válido en Base.';
      });
      return;
    }

    final double perimetro = 3 * base;
    setState(() {
      _resultado =
          'Parámetro (perímetro equilátero): ${perimetro.toStringAsFixed(2)}';
    });
  }

  void _mostrarResultado() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resultado'),
        content: Text(_resultado),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _baseController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.lightBlue.shade200,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Triangulo',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _baseController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Base',
                    prefixIcon: Icon(Icons.straighten),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _alturaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Altura',
                    prefixIcon: Icon(Icons.height),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    ElevatedButton(
                      onPressed: _calcularArea,
                      child: const Text('Area'),
                    ),
                    ElevatedButton(
                      onPressed: _calcularParametro,
                      child: const Text('Parametro'),
                    ),
                    FilledButton.icon(
                      onPressed: _mostrarResultado,
                      icon: const Icon(Icons.visibility),
                      label: const Text('Ver resultado'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _resultado,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}