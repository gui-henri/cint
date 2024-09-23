import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../components/icones_ong.dart';

class PreferenciasPage extends StatefulWidget {
  const PreferenciasPage({super.key});

  static const routeName = '/preferencias';

  @override
  State<PreferenciasPage> createState() => _PreferenciasPageState();
}

class _PreferenciasPageState extends State<PreferenciasPage> {
  List<int> selectedIndexes = []; 
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();  
  }

  // Função para carregar as preferências do usuário
  Future<void> _carregarPreferencias() async {
    final userId = supabase.auth.currentUser!.id;

    try {
      final List<dynamic> preferenciasIds = await supabase
          .from('usuario_preferencia')
          .select('id_preferencia')
          .eq('id_usuario', userId);

      
      setState(() {
        selectedIndexes = preferenciasIds
            .map((preferencia) => (preferencia['id_preferencia'] as int) - 1)  // Subtrai 1 para mapear ao índice
            .toList();
      });

    } catch (e) {
      print('Erro ao carregar preferências: $e');
    }
  }

  // Função para salvar uma nova preferência
  Future<void> _salvarPreferencia(int preferenciaId) async {
    final userId = supabase.auth.currentUser!.id;

    try {
      await supabase.from('usuario_preferencia').insert({
        'id_usuario': userId,
        'id_preferencia': preferenciaId,
      });

    } catch (e) {
      print('Erro ao salvar preferência: $e');
    }
  }

  // Função para excluir uma preferência
  Future<void> _excluirPreferencia(int preferenciaId) async {
    final userId = supabase.auth.currentUser!.id;

    try {
      await supabase
          .from('usuario_preferencia')
          .delete()
          .eq('id_usuario', userId)
          .eq('id_preferencia', preferenciaId);

      print('Preferência $preferenciaId excluída com sucesso!');
    } catch (e) {
      print('Erro ao excluir preferência: $e');
    }
  }

  // Função para salvar as preferências do usuário ao clicar em "Próximo"
  Future<void> salvarPreferencias() async {
    final userId = supabase.auth.currentUser!.id;

    try {
      for (int index in selectedIndexes) {
        final preferenciaId = index + 1;

        final List<dynamic> response = await supabase
            .from('usuario_preferencia')
            .select()
            .eq('id_usuario', userId)
            .eq('id_preferencia', preferenciaId);

        if (response.isEmpty) {
          await _salvarPreferencia(preferenciaId);
        }
      }

      Navigator.popAndPushNamed(context, '/perfil');
    } catch (e) {
      print('Erro ao salvar preferências: $e');
    }
  }

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
                      return buildDoacaoItem(item, index);
                    },
                  ),
                ),
              ],
            ),
          ),

          if (selectedIndexes.isNotEmpty)
            Positioned(
              bottom: 30.0,
              right: 16.0,
              child: SizedBox(
                width: 100,
                child: TextButton(
                  onPressed: () => {Navigator.popAndPushNamed(context, '/perfil')}, // Chama a função para salvar as preferências
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

  Widget buildDoacaoItem(Map<String, dynamic> item, int index) {
    bool isSelected = selectedIndexes.contains(index);

    return GestureDetector(
      onTap: () async {
        setState(() {
          if (isSelected) {
            // Remove da lista de selecionados e exclui do banco
            selectedIndexes.remove(index);
            _excluirPreferencia(index + 1);  // Chama a função para excluir do banco
          } else {
            // Adiciona à lista de selecionados e insere no banco
            selectedIndexes.add(index);
            _salvarPreferencia(index + 1);  // Chama a função para salvar no banco
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
