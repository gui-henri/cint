class PostOferta {
  String produto;
  int quantidade;
  String condicoes;
  String categoria;
  String telefone;
  String info;
  int icon;
  String textoPrincipal;
  String id;
  List<dynamic> fotosPost;
  String usuario;

  PostOferta(
    this.telefone,
    this.info,
    this.id,
    this.usuario,
    {
    required this.produto,
    required this.quantidade,
    required this.condicoes,
    required this.categoria,
    required this.icon,
    required this.textoPrincipal,
    required this.fotosPost,
  });

  factory PostOferta.fromJson(Map<String, dynamic> json) {
    return PostOferta(
      json['telefone'],
      json['informacao_relevante'],
      json['id'],
      json['usuario'],
      produto: json['nome_produto'],
      quantidade: json['quantidade'],
      condicoes: json['condicao'],
      categoria: json['categoria'],
      icon: json['tipo_id'],
      textoPrincipal: json['texto_anuncio'],
      fotosPost: json['fotos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome_produto': produto,
      'quantidade': quantidade,
      'condicao': condicoes,
      'categoria': categoria,
      'tipo_id': icon,
      'telefone' : telefone,
      'informacao_relevante' : info,
      'texto_anuncio': textoPrincipal,
      'fotos': fotosPost,
      'usuario' : usuario,
    };
  }
}