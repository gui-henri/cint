import 'package:flutter/material.dart';

import '../../components/footer.dart';
import '../../components/header.dart';
import '../../components/title_back.dart';

class Desempenho extends StatefulWidget {
  const Desempenho({super.key});

  static const routeName = '/Desempenho';

  @override
  State<Desempenho> createState() => _DesempenhoState();
}

class _DesempenhoState extends State<Desempenho> {
  String? selectedFrequency = '1 vez';
  String? selectedPeriod = 'por semana';

  final List<String> frequencyOptions = ['1 vez', '2 vezes', '3 vezes', '4 vezes', '5 vezes'];
  final List<String> periodOptions = ['por dia', 'por semana', 'por mês', 'por ano'];

  final double progress = 0.15;

  bool isButtonEnabled = false;

  void _checkButtonState() {
    setState(() {
      isButtonEnabled = selectedFrequency != null && selectedPeriod != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        atualizarBusca: (value) {},
      ),
      bottomNavigationBar: const Footer(),
      body:Stack(
        children: [
        
        ListView(
          padding: const EdgeInsets.only(top: 80, left: 20, right: 20,),
          children: <Widget>[
            const Text(
                'Faltam 15 ações para ganhar a próxima insígnia e desbloquear um novo título!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
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
                            padding: const EdgeInsets.only(right: 45), // Distância entre o ícone e a barra
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
                          
                          Positioned(
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Container(
                                  width: 40, // Largura do ícone
                                  height: 40, // Altura do ícone
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/icone_doador.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Editar Meta',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

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
            ],
          ),
           Positioned(
                bottom: 30.0,
                right: 40.0,
                left: 40.0,
                child: SizedBox(
                  child: TextButton(
                    onPressed: isButtonEnabled
                          ? () async {
                              // Ação do botão
                              Navigator.pushReplacementNamed(context, '/home');
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
                      'Editar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
          titleBack(context, 'Desempenho', '/perfil', null),
        ],
      ),
    );
  }
}
