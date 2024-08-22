import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../components/campo_texto.dart';

import '../../components/post_oferta.dart';
import '../posts/salvos/lista_meus_posts.dart';
import 'package:cint/repositorys/anuncios.repository.dart';

class AnuncioForm extends StatefulWidget {
  const AnuncioForm({super.key});

  static const routeName = '/anuncio_form';

  @override
  State<AnuncioForm> createState() => _AnuncioFormState();
}

class _AnuncioFormState extends State<AnuncioForm> {
  late PostOferta dadosPostEditado;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerProduto = TextEditingController();
  final TextEditingController _controllerQuantidade = TextEditingController();
  final TextEditingController _controllerCondicoes = TextEditingController();
  final TextEditingController _controllerCategoria = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();
  final TextEditingController _controllerInfo = TextEditingController();
  List fotos = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final arquivo = File(pickedImage.path); // Converte XFile para File
      setState(() {
        fotos.add(arquivo);
        print(fotos);
      });
    }
  }

  void _showImageDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(children: [
            Container(
              child: Image.file(
                fotos[index],
                fit: BoxFit.contain,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  fotos.remove(fotos[index]);
                  Navigator.pop(context);
                });
              },
              icon: Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      setState(() {
        dadosPostEditado =
            ModalRoute.of(context)!.settings.arguments as PostOferta;
        tempForm.clear();
        tempForm = [
          dadosPostEditado.produto,
          dadosPostEditado.quantidade,
          dadosPostEditado.condicoes,
          dadosPostEditado.categoria,
          dadosPostEditado.telefone,
          dadosPostEditado.info,
        ];
        //fotos = dadosPostEditado.fotosPost;
        ofertaEditada = dadosPostEditado;
      });
    }

    if (tempForm.isNotEmpty) {
      setState(() {
        _controllerProduto.text = tempForm[0];
        _controllerQuantidade.text = tempForm[1];
        _controllerCondicoes.text = tempForm[2];
        _controllerCategoria.text = tempForm[3];
        _controllerTelefone.text = tempForm[4];
        _controllerInfo.text = tempForm[5];
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ))),
          onPressed: () {
            setState(() {
              isEditing = false;
              tempForm.clear();
            });
            Navigator.pop(context);
          },
        ),
        title: FractionallySizedBox(
          widthFactor: 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset('assets/icons/icon-megaphone-solid.png'),
              const Text(
                'Anuncie',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Placeholder for when no image
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CampoTexto('Informe o produto a ser doado', true,
                        _controllerProduto),
                    CampoTexto(
                        'Quantidade do produto', true, _controllerQuantidade),
                    CampoTexto(
                        'Condições do produto', true, _controllerCondicoes),
                    CampoTexto(
                        'Categoria do produto', true, _controllerCategoria),
                    CampoTexto(
                        'Telefone para contato',
                        false,
                        size: 11,
                        keyboard: TextInputType.number,
                        _controllerTelefone),
                    CampoTexto(
                        'Há mais alguma informação relevante sobre o\nproduto que gostaria de compartilhar?',
                        false,
                        _controllerInfo),
                  ],
                ),
              ),
            ),
            fotos.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: fotos.map((photo) {
                      int index = fotos.indexOf(photo);
                      return GestureDetector(
                        onTap: () => _showImageDialog(index),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                photo,
                                height: 60.0,
                                width: 60.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox(),
            BotaoFoto(),
            const SizedBox(
              height: 20,
            ),
            BotaoEnviar(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> enviarForm() async {
    if (_formKey.currentState!.validate()) {  
             
        final rep = AnunciosRepository();
        final userEmail = rep.getUserEmail();
        print('id do user é...: $userEmail');

      if (isEditing == false) {
        tempForm = [
          _controllerProduto.text,
          _controllerQuantidade.text,
          _controllerCondicoes.text,
          _controllerCategoria.text,
          _controllerTelefone.text,
          _controllerInfo.text,
          null,
          null,
        ];

      final idPost = await rep.createPost(
        _controllerProduto.text,
        int.parse(_controllerQuantidade.text),
        int.parse(_controllerCondicoes.text),
        int.parse(_controllerCategoria.text)
      );
      print('Id da linha nova: $idPost');
      Navigator.pushNamed(context, '/nova_oferta', arguments: [fotos, idPost]);
      }
      if (isEditing) {
        setState(() {
          dadosPostEditado.produto = _controllerProduto.text;
          dadosPostEditado.quantidade = int.parse(_controllerQuantidade.text);
          dadosPostEditado.condicoes = int.parse(_controllerCondicoes.text);
          dadosPostEditado.categoria = int.parse(_controllerCategoria.text);
          dadosPostEditado.telefone = _controllerTelefone.text;
          dadosPostEditado.info = _controllerInfo.text;
        });
        Navigator.pushNamed(context, '/nova_oferta', arguments: fotos);
      }
      
    }
  }

  Widget BotaoEnviar() {
    return TextButton(
      onPressed: () {
        enviarForm();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
            side: const BorderSide(
              width: 1,
              color: Color(0xFF28730E),
            ),
          ),
        ),
      ),
      child: Container(
        width: 130,
        height: 30,
        child: const Center(
          child: Text(
            'Enviar',
            style: TextStyle(
              color: Color(0xFF28730E),
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget BotaoFoto() {
    return TextButton(
      child: Container(
        height: 37,
        width: 299,
        child: const Center(
          child: Text('Anexar foto do produto'),
        ),
      ),
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        backgroundColor: const MaterialStatePropertyAll(Color(0xFF28730E)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
      onPressed: () {
        _pickImage();
      },
    );
  }
}
