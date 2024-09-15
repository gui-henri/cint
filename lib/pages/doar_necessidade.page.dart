import 'dart:convert';

import 'package:cint/main.dart';
import 'package:cint/objetos/posts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import '../../components/campo_texto.dart';

import '../../components/post_oferta.dart';
import 'package:cint/repositorys/anuncios.repository.dart';

class NecessidadeForm extends StatefulWidget {
  final dynamic isEditing;

  const NecessidadeForm({Key? key, this.isEditing}) : super(key: key);

  static const routeName = '/necessidade_form';

  @override
  State<NecessidadeForm> createState() => _NecessidadeFormState();
}

class _NecessidadeFormState extends State<NecessidadeForm> {
  late PostOferta dadosPostEditado;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerProduto = TextEditingController();
  final TextEditingController _controllerQuantidade = TextEditingController();
  final TextEditingController _controllerCondicoes = TextEditingController();
  final TextEditingController _controllerCategoria = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();
  final TextEditingController _controllerInfo = TextEditingController();
  List fotosKeys = [];
  OverlayEntry? _currentOverlayEntry;

  bool isColetadoSelected = true; // Inicia com "Coletado" selecionado
  bool isEntregueSelected = false;

  late List<dynamic> args;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {return;}
    //envio remoto
    var uuid = const Uuid();
    String uniqueKey = uuid.v4();  // Gera um UUID v4
    print('Unique Key: $uniqueKey');

    //print('bucket aqui blabla: $bucket');
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
        fotosKeys.add(imageUrl);
      });

      
    }
  }

  Future<void> _showImageOverlay(String foto) async {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Material(
          color: Colors.black54,
          child: Stack(
            children: [
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: Image.network(
                    foto,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 20,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _currentOverlayEntry?.remove();
                          _currentOverlayEntry = null;
                        });
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Color(0xFF28730E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 30,
                right: 20,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          fotosKeys.remove(foto);
                          _currentOverlayEntry?.remove();
                          _currentOverlayEntry = null;
                          final rep = AnunciosRepository();
                          rep.deleteFoto(foto);
                        });
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        ),

                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    _currentOverlayEntry?.remove();  // Remove o overlay anterior, se houver
    _currentOverlayEntry = overlayEntry;
    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {

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
                'Faça sua doação',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
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
                        'Quantidade do produto', true, _controllerQuantidade, keyboard: TextInputType.number,),
                    CampoTexto(
                        'Condições do produto', true, _controllerCondicoes),
                    CampoTexto(
                        'Categoria do produto', true, _controllerCategoria),
                    CampoTexto(
                        'Telefone para contato',
                        true,
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
            
            Padding(
              padding:const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'O produto vai ser:',
                    style: TextStyle(
                      color: Color(0xFF28730E),
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(width: 15,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isColetadoSelected = true;
                        isEntregueSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isColetadoSelected ? const Color(0xFF28730E) : Colors.white,
                      foregroundColor: isColetadoSelected ? Colors.white : const Color(0xFF28730E),
                      side: const BorderSide(color: Color(0xFF28730E)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Coletado'),
                  ),
                  const SizedBox(width: 10), // Espaçamento entre os botões
                  // Botão Entregue
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isColetadoSelected = false;
                        isEntregueSelected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEntregueSelected ? const Color(0xFF28730E) : Colors.white,
                      foregroundColor: isEntregueSelected ? Colors.white : const Color(0xFF28730E),
                      side: const BorderSide(color: Color(0xFF28730E)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Entregue'),
                  ),
                ],
              ),
            ),
            fotosKeys.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: fotosKeys.map((photo) {
                      int index = fotosKeys.indexOf(photo);
                      return GestureDetector(
                        onTap: () => _showImageOverlay(photo),
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

  Widget BotaoEnviar() {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.all(16),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Envio de produto",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Parabéns por esse passo! A instituição entrará em contato com você para combinar a entrega do produto.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
        );
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
            side: const BorderSide(
              width: 1,
              color: Color(0xFF28730E),
            ),
          ),
        ),
      ),
      child: const SizedBox(
        width: 130,
        height: 30,
        child: Center(
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
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: const WidgetStatePropertyAll(Color(0xFF28730E)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
      onPressed: () {
        _pickImage();
      },
      child: const SizedBox(
        height: 37,
        width: 299,
        child: Center(
          child: Text('Anexar foto do produto'),
        ),
      ),
    );
  }
}


