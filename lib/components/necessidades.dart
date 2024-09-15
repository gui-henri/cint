import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Necessidades extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> future;

  const Necessidades({super.key, required this.future});

  @override
  State<Necessidades> createState() => _NecessidadesState();
}

class _NecessidadesState extends State<Necessidades> {
  @override
  Widget build(BuildContext context) {
    final necessidades = widget.future;

    return FutureBuilder(
        future: necessidades,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Erro ao carregar necessidades: ${snapshot.error}');
            return const Center(child: Text('Erro ao carregar necessidades.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma necessidade disponível.'));
          }

          List<Map<String, dynamic>> data = snapshot.data!;

          return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.9,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final necessidade = data[index];
                return NecessidadeCard(
                  nome: necessidade['nome'],
                  urgente: necessidade['urgente'],
                );
              });
        });
  }
}

class NecessidadeCard extends StatelessWidget {
  final String nome;
  final bool urgente;

  const NecessidadeCard({super.key, required this.nome, required this.urgente});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: urgente ? Colors.red : Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                nome,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (urgente)
            const Positioned(
              top: -10,
              right: -10,
              child: CircleAvatar(
                radius: 16,                
                backgroundColor: Colors.yellow,
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.black,
                  size: 16,
                ),
              )
            ),
        ],
      ),
    );
  }
}
