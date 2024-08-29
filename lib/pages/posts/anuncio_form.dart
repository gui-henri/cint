import 'dart:convert';

import 'package:cint/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import '../../components/campo_texto.dart';

import '../../components/post_oferta.dart';
import '../posts/salvos/lista_meus_posts.dart';
import 'package:cint/repositorys/anuncios.repository.dart';

class AnuncioForm extends StatefulWidget {
  final dynamic isEditing;

  AnuncioForm({Key? key, this.isEditing}) : super(key: key);

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
  List fotosKeys = [];
  Map<String, dynamic> fotosMap = {'fotos' : []};

  late List<dynamic> args;

    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
      isEditing = args[0] as bool;
    }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {return;}
    //envio remoto
    var uuid = const Uuid();
    String uniqueKey = uuid.v4();  // Gera um UUID v4
    print('Unique Key: $uniqueKey');
    final imageExtension = pickedImage.path.split('.').last.toLowerCase();
    final imageBytes = await pickedImage.readAsBytes();
    final userId = supabase.auth.currentUser!.id;
    final imagePath = '/$userId/$uniqueKey';
    await supabase.storage
      .from('anuncio')
      .uploadBinary(imagePath, 
      imageBytes, 
      fileOptions: FileOptions(upsert: true, contentType: 'image/$imageExtension'));
      final imageUrl = supabase.storage.from('anuncio').getPublicUrl(imagePath);
      print('url: $imageUrl');
    //lista local
    if (pickedImage != null) {
      final arquivo = File(pickedImage.path); // Converte XFile para File
      setState(() {
        fotos.add(arquivo);
        print(fotos);
        fotosKeys.add(imageUrl);

        // preparando map
        fotosMap['fotos'].add(imageUrl);
        print('fotosMap: $fotosMap');
      });

      
    }
  }

  void _showImageDialog(String foto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(children: [
            Container(
              child: Image.network(
                foto,
                fit: BoxFit.contain,
              ),
            ),
            IconButton(
              onPressed: () async {
                setState(() {
                  fotosKeys.remove(foto);
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
    //final args = ModalRoute.of(context)!.settings.arguments as List;
    //isEditing = args[0] as bool;
/*     if (isEditing) {
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
    } */

    if (args[2]!=null) {
      print('aaaaaaaaaaaaa');
      //final linha = supabase.from('anuncio').stream(primaryKey: ['id']).eq('id', args[1]);
      final dadosPost = args[2] as PostOferta;
      setState(() {
        _controllerProduto.text = dadosPost.produto;
        _controllerQuantidade.text = dadosPost.quantidade.toString();
        _controllerCondicoes.text = dadosPost.condicoes.toString();
        _controllerCategoria.text = dadosPost.categoria.toString();
        _controllerTelefone.text = dadosPost.telefone;
        _controllerInfo.text = dadosPost.info;
        fotosKeys = dadosPost.fotosPost;
      });
    } else {print('args 2 null');}
    print('está editandoForm: $isEditing');
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
            Navigator.pushNamed(context, '/minhasofertas');
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
            fotosKeys.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: fotosKeys.map((photo) {
                      int index = fotosKeys.indexOf(photo);
                      return GestureDetector(
                        onTap: () => _showImageDialog(photo),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
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

      //if (isEditing == false) {
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

        late dynamic idPost;
        if (!isEditing) {
          idPost = await rep.createPost(
          _controllerProduto.text,
          int.parse(_controllerQuantidade.text),
          int.parse(_controllerCondicoes.text),
          int.parse(_controllerCategoria.text),
          jsonEncode(fotosKeys)
        );
        final postof = PostOferta(
          _controllerProduto.text, 
          int.parse(_controllerQuantidade.text), 
          int.parse(_controllerCondicoes.text), 
          int.parse(_controllerCategoria.text), 
          '', 
          '', 
          '', 
          idPost, 
          0,
          fotosKeys
          );
        if (mounted) {
          Navigator.pushNamed(context, '/nova_oferta', arguments: [fotos, idPost, postof]);
        }
        print('Id da linha nova: $idPost');
        } else {
          print('oioioioi');
          var idArgument = args[1];
          idPost = await rep.updateForm(
            idArgument,
          _controllerProduto.text,
          int.parse(_controllerQuantidade.text),
          int.parse(_controllerCondicoes.text),
          int.parse(_controllerCategoria.text),
          jsonEncode(fotosKeys)
        );
          if (mounted) {
            Navigator.pushNamed(context, '/nova_oferta', arguments: [fotos, idPost, args[2]]);
          }
          print('Id da linha editada: $idPost');
        }
        


      //}
/*       if (isEditing) {
        setState(() {
          dadosPostEditado.produto = _controllerProduto.text;
          dadosPostEditado.quantidade = int.parse(_controllerQuantidade.text);
          dadosPostEditado.condicoes = int.parse(_controllerCondicoes.text);
          dadosPostEditado.categoria = int.parse(_controllerCategoria.text);
          dadosPostEditado.telefone = _controllerTelefone.text;
          dadosPostEditado.info = _controllerInfo.text;
        });
        Navigator.pushNamed(context, '/nova_oferta', arguments: fotos);
      } */
      
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
