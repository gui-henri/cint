import 'package:cint/components/icones_ong.dart';
import 'package:cint/components/main_title.dart';
import 'package:cint/objetos/instituicao.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OngsDetalhes extends StatelessWidget {
  Instituicao ong;
  OngsDetalhes({Key? key, required this.ong}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Wrap(
          children: [
            Image.network(
              ong.foto,
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(padding: EdgeInsets.all(24), child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        MainTitle(
                          texto: ong.nome
                        ),
                        Row(
                          children: [
                          const Icon(
                            Icons.location_on_sharp,
                            size: 20,
                            color: Color(0xFF28730E),
                          ),
                            Text(ong.endereco),
                          ],
                        ),
                      ]
                    ),
                    Image.asset(iconesOng.firstWhere(
                            (item) => item["tipo"] == iconesOng[ong.idCategoria-1]['tipo']
                          )['icon-green'],),
                  ],
                ),
                SizedBox(height: 20,),
                Text(ong.historia, textAlign: TextAlign.left,),
                SizedBox(height: 40,),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}