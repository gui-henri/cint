import 'package:cint/pages/ong.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoarInicio extends StatefulWidget {
  const DoarInicio({Key? key}) : super(key: key);

  static const routeName = '/doar_inicio';

  @override
  State<DoarInicio> createState() => _DoarInicioState();
}

class _DoarInicioState extends State<DoarInicio> {
  @override
  Widget build(BuildContext context) {
    final pix = ModalRoute.of(context)!.settings.arguments;
    if (pix == null) {
      Navigator.pop(context);
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            style: ButtonStyle(
                shape: WidgetStateProperty.all(const CircleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.black,
              ),
            ))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const FractionallySizedBox(
            widthFactor: 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.volunteer_activism, color: Color(0xFF28730E)),
                SizedBox(width: 10),
                Text(
                  'Oferte',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    'Aguardando Oferta',
                    style: TextStyle(
                      color: Color(0xFF28730E),
                      fontSize: 24.0,
                    ),
                  ),
                  const Text(
                    'Copie o código abaixo e utilize o PIX no aplicativo que você vai fazer o pagamento:',
                    style: TextStyle(
                      color: Color(0xFF28730E),
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller:
                              TextEditingController(text: pix.toString()),
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                          textStyle: WidgetStateProperty.all<TextStyle>(
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                            const Color(0xFF28730E),
                          ),
                        ),
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: pix.toString()));
                        },
                        child: const Text('Copiar'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 56,
                  ),
                  const Text('Você tem até 5 minutos para fazer a oferta.'),
                  const SizedBox(height: 56),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                            textStyle: WidgetStateProperty.all<TextStyle>(
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xFF28730E),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                            textStyle: WidgetStateProperty.all<TextStyle>(
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xFF28730E),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/comprovante');
                          },
                          child: const Text('Enviar'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ])));
  }
}
