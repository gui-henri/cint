import 'package:cint/components/adress_box.dart';
import 'package:cint/components/footer.dart';
import 'package:cint/components/necessidades.dart';
import 'package:cint/objetos/instituicao.dart';
import 'package:cint/objetos/user.dart';
import 'package:cint/repositorys/ong.repository.dart';
import 'package:cint/repositorys/user.repository.dart';
import 'package:flutter/material.dart';

class OngArguments {
  final String ongId;
  final bool? donated;

  OngArguments({required this.ongId, this.donated});
}

class OngPage extends StatefulWidget {
  const OngPage({super.key});

  static const routeName = '/ong';

  @override
  OngPageState createState() => OngPageState();
}

class OngPageState extends State<OngPage> {

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as OngArguments;
    final ongRepository = OngRepository();
    late final ong = ongRepository.getOneWithPhotos(args.ongId);
    late var necessidades = ongRepository.getNecessidades(args.ongId);
    final userRepository = UserRepository();

    return FutureBuilder(
      future: ong,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar ONG'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('ONG não encontrada'));
        }

        bool hasMultiplePhotos = true;
        try {
          hasMultiplePhotos = snapshot.data![0]['foto_instituicao'].length > 0;
        } catch (e) {
          hasMultiplePhotos = false;
        }
        final img = hasMultiplePhotos ? Image.network(
          snapshot.data![0]['foto_instituicao'][0]['url'],
          fit: BoxFit.fill,
        ) : Image.network(
          snapshot.data![0]['foto'],
          fit: BoxFit.fill,
        );

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(235),
            child: AppBar(
              leading: IconButton(
                icon: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.fromBorderSide(BorderSide(color: Color(0xFF28730E))),
                  ),
                  height: 80,
                  width: 80,
                  child: const Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xFF28730E), size: 30),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: Container(
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: img.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.fromBorderSide(BorderSide(color: Colors.black)),
                    ),
                    height: 80,
                    child: const Icon(Icons.share, color: Colors.black, size: 30),
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.fromBorderSide(BorderSide(color: Colors.black)),
                    ),
                    height: 80,
                    child: const Icon(Icons.favorite_border, color: Color(0xFFe74c3c), size: 30),
                  ),
                  onPressed: () async {
                    //mudar cor depois
                    // checar se a ong ja esta favoritada
                    // atualizar lista local de favoritas do usuario
                    print('fav: ${snapshot.data!}');
                    try {
/*                       final List<Map<String, dynamic>> usuarioLogadoJson = await userRepository.getMyUser();
                      final usuarioFromJson = Usuario.fromJson(usuarioLogadoJson[0]); */
                      Usuario().favoritas.add(Instituicao.fromJson(snapshot.data![0]));
                      var user = Usuario().toJson();
                      print('favoroar: ${Usuario().email}');
                      userRepository.updateUserFavoritas(user['favoritas']);
                    } catch(e) {print('erro de fav: $e');}
                    print('Ong adicionada! ${Usuario().favoritas}');
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(snapshot.data![0]['nome'], 
                      style: const TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                    const Icon(
                      Icons.star_outline, 
                      color: Colors.black,
                      size: 30,
                    ),
                    Text(snapshot.data![0]['nota'].toString(), 
                      style: const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold
                        )
                      ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.chat,
                      size: 30,
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.phone,
                      size: 30,
                    ),
                ],),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    children: [
                      AddressBox(address: snapshot.data![0]['endereco']),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 4,
                        endIndent: 4,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Necessidades atuais:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Necessidades(future: necessidades),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 4,
                        endIndent: 4,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child :Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      snapshot.data![0]['descricao'],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.2,
                  child: SizedBox(
                    height: 50,
                    width: 75,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/doar_inicio', arguments: snapshot.data![0]['pix']);
                      },
                      child: const Text('Doar'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          bottomNavigationBar: const Footer(),
        );
      });
  }
}