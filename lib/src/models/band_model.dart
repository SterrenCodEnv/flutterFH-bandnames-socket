class Band {
  // declaracion de variables
  String id;
  String name;
  int votes;

  // constructor para setear valores por parametros
  Band({this.id, this.name, this.votes});

  // refactorización de map a objetos
  factory Band.fromMap(Map<String, dynamic> obj) =>
      Band(id: obj['id'], name: obj['name'], votes: obj['votes']);
}
