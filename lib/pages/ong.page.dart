import 'package:cint/components/adress_box.dart';
import 'package:cint/components/footer.dart';
import 'package:cint/repositorys/ong.repository.dart';
import 'package:flutter/material.dart';

class OngArguments {
  final String ongId;

  OngArguments({required this.ongId});
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
    late final ong = OngRepository().getOneWithPhotos(args.ongId);

    return FutureBuilder(
      future: ong, 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar ONG'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma ONG encontrada'));
        }

        final img = Image.network(
          snapshot.data![0]['foto_instituicao'][0]['url'],
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
          body: Row(
            children: [
              Column(
                children: [
                  Text(snapshot.data![0]['nome']),
                  const Icon(Icons.star, color: Colors.yellow),
                  Text(snapshot.data![0]['nota'].toString()),
                  const Icon(Icons.chat),
                  const Icon(Icons.phone),
              ],),
              SizedBox(
                width: 200,
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
              // Text(snapshot.data![0]['nome']),
              // Text(snapshot.data![0]['endereco']),
              // Text(snapshot.data![0]['nota'].toString()),
            ],
          ),
          bottomNavigationBar: const Footer(),
        );
      });
  }
}