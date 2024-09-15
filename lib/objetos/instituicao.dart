import 'package:cint/repositorys/ong.repository.dart';

class Instituicao {
  final String id;
  final String nome;
  final num nota;
  final String endereco;
  final String descricao;
  final String pix;
  final String missao;
  final String historia;
  final int meta;
  final int idCategoria;
  final String foto;

  Instituicao({
    required this.id,
    required this.nome,
    required this.nota,
    required this.endereco,
    required this.descricao,
    required this.pix,
    required this.missao,
    required this.historia,
    required this.meta,
    required this.idCategoria,
    required this.foto,
  });

  // Construtor para criar uma instância de Instituicao a partir de um JSON
  factory Instituicao.fromJson(Map<String, dynamic> json) {
    return Instituicao(
      id: json['id'],
      nome: json['nome'],
      nota: json['nota'],
      endereco: json['endereco'],
      descricao: json['descricao'],
      pix: json['pix'],
      missao: json['missao'],
      historia: json['historia'],
      meta: json['meta'],
      idCategoria: json['id_categoria'],
      foto: json['foto'],
    );
  }

   // Método para converter uma instância de Instituicao de volta para JSON
  Map<String, dynamic> toJson() {
    return {
      id: id,
      nome: nome,
      nota.toString(): nota,
      endereco: endereco,
      descricao: descricao,
      pix: pix,
      missao: missao,
      historia: historia,
      meta.toString(): meta,
      idCategoria.toString(): idCategoria,
      foto: foto,
    };
  }
}


class ListaInstituicoes {
  ListaInstituicoes._privateConstructor();
  static final ListaInstituicoes _instance = ListaInstituicoes._privateConstructor();
  factory ListaInstituicoes() {
    return _instance;
  }

  final OngRepository _ongRepository = OngRepository();
  List<Instituicao> ongsInstancias = [];

  Future<void> loadOngs() async {
    ongsInstancias = await _ongRepository.gerarOngs();
  }
}
