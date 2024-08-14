import 'package:flutter/material.dart';
import '../../components/post_oferta.dart';

class EditarForm extends StatefulWidget {
  const EditarForm({super.key});

  static const routeName = '/editar_form';

  @override
  State<EditarForm> createState() => _EditarFormState();
}

class _EditarFormState extends State<EditarForm> {
  @override
  Widget build(BuildContext context) {
    final postAtual = ModalRoute.of(context)!.settings.arguments as PostOferta;
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text(postAtual.produto),
          ),
          ListTile(
            title: Text(postAtual.quantidade),
          ),
          ListTile(
            title: Text(postAtual.condicoes),
          ),
          ListTile(
            title: Text(postAtual.categoria),
          ),
          ListTile(
            title: Text(postAtual.telefone),
          ),
          ListTile(
            title: Text(postAtual.info),
          ),
        ],
      ),
    );
  }
}
