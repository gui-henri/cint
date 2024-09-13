import 'package:flutter/material.dart';
import '../../components/icones_ong.dart';

class Apresentacao5 extends StatefulWidget {
  const Apresentacao5({super.key});

  static const routeName = '/apresentacao5';

  @override
  State<Apresentacao5> createState() => _Apresentacao5State();
}

class _Apresentacao5State extends State<Apresentacao5> {
  String? selectedFrequency = '1 vez';
  String? selectedPeriod = 'por semana';

  final List<String> frequencyOptions = ['1 vez', '2 vezes', '3 vezes', '4 vezes', '5 vezes'];
  final List<String> periodOptions = ['por dia', 'por semana', 'por mês', 'por ano'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 40, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Qual vai ser sua meta de doação?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF28730E),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    // Primeiro Dropdown (Menor)
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFF28730E), width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0.5,
                              blurRadius: 4,
                              offset: const Offset(0, 5), // Shadow position
                            ),
                          ],
                        ),
                        child: DropdownButton<String>(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          value: selectedFrequency,
                          
                          isExpanded: true,
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedFrequency = newValue;
                            });
                          },
                          items: frequencyOptions.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    // Segundo Dropdown (Maior)
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFF28730E), width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0.5,
                              blurRadius: 4,
                              offset: const Offset(0, 5), // Shadow position
                            ),
                          ],
                        ),
                        child: DropdownButton<String>(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          value: selectedPeriod,
                          hint: const Text('Selecione o período'),
                          isExpanded: true,
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPeriod = newValue;
                            });
                          },
                          items: periodOptions.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                Text(
                  """Sua meta de doação será de $selectedFrequency $selectedPeriod.
Cumpra sua meta para subir de categoria mais rápido e desbloquear novas insígnias e títulos.""",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF28730E),
                  ),
                ),
                
              ],
            ),
          ),
          Positioned(
            bottom: 30.0,
            right: 40.0,
            left: 40.0,
            child: SizedBox(
              child: TextButton(
                onPressed: () async {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
                    const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF28730E)),
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
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
