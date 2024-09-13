import 'package:flutter/material.dart';
import '../../components/icones_ong.dart';

class Apresentacao4 extends StatefulWidget {
  const Apresentacao4({super.key});

  static const routeName = '/apresentacao4';

  @override
  State<Apresentacao4> createState() => _Apresentacao4State();
}

class _Apresentacao4State extends State<Apresentacao4> {
  // Lista para armazenar os tipos de itens selecionados
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 40, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Selecione focos de Instituições que você é mais inclinado a doar:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF28730E),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: iconesOng.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      final item = iconesOng[index];
                      return buildDoacaoItem(item);
                    },
                  ),
                ),
              ],
            ),
          ),

          if (selectedItems.isNotEmpty)
          Positioned(
            bottom: 30.0,
            right: 16.0,
            child: SizedBox(
              width: 100,
              child: TextButton(
                onPressed: () async {
                  Navigator.pushReplacementNamed(context, '/apresentacao5');
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                child: Text(
                  'Próximo',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDoacaoItem(Map<String, dynamic> item) {
    bool isSelected = selectedItems.contains(item["tipo"]);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedItems.remove(item["tipo"]);
          } else {
            selectedItems.add(item["tipo"]);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? const Color(0xFF28730E) : Colors.transparent,
          border: Border.all(color: const Color(0xFF28730E), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isSelected ? item['icon-white'] : item['icon-green'],
              width: 40,
              height: 40,
            ),
            const SizedBox(height: 10),
            Text(
              item['tipo'],
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF28730E),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
