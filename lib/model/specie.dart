class Specie {
  int id;
  String name;

  Specie(this.id, this.name);
  bool operator ==(dynamic other) =>
      other != null && other is Specie && this.id == other.id;

  @override
  int get hashCode => super.hashCode;
}
