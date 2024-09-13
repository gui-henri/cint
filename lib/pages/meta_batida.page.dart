import 'package:flutter/material.dart';
import '../../components/icones_ong.dart';
import '../components/title_back.dart';

class MetaBatida extends StatefulWidget {
  const MetaBatida({super.key});

  static const routeName = '/MetaBatida';

  @override
  State<MetaBatida> createState() => _MetaBatidaState();
}

class _MetaBatidaState extends State<MetaBatida> {
  String? selectedFrequency = '1 vez';
  String? selectedPeriod = 'por semana';

  final List<String> frequencyOptions = ['1 vez', '2 vezes', '3 vezes', '4 vezes', '5 vezes'];
  final List<String> periodOptions = ['por dia', 'por semana', 'por mês', 'por ano'];

  final double progress = 1;

  bool isButtonEnabled = false;

  void _checkButtonState() {
    setState(() {
      isButtonEnabled = selectedFrequency != null && selectedPeriod != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Parabéns por atingir sua meta!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF28730E),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Uma instituição solicitou sua oferta e você acaba de doar pela primeira vez essa semana',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF28730E),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.fromLTRB(13, 10, 0, 10), // Espaçamento interno do container
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Percentual à esquerda
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Barra de Progresso
                        Expanded(
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF28730E)),
                                    minHeight: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Escolha sua próxima meta de doação:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF28730E),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

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
                              _checkButtonState();
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
                              _checkButtonState();
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

                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Com cada doação, você fica mais perto de avançar para a próxima categoria e receber novos títulos e insígnias!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF28730E),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),

            Positioned(
              bottom: 100.0,
              right: 40.0,
              left: 40.0,
              child: SizedBox(
                child: TextButton(
                  onPressed: isButtonEnabled
                        ? () async {
                            // Ação do botão
                            Navigator.pop(context);
                          }
                        : null, // Desabilita o botão se não estiver habilitado
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
                      const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    backgroundColor: WidgetStateProperty.all<Color>( isButtonEnabled ? const Color(0xFF28730E) : const Color.fromARGB(127, 39, 115, 14)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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

            Positioned(
              bottom: 30.0,
              right: 40.0,
              left: 40.0,
              child: SizedBox(
                child: TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
                      const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF28730E)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Manter mesma meta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            titleBack(context, '', '/perfil', null),
          ],
        ),
      ),
    );
  }
}
