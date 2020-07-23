class QueryResultCategory {
  List<Layer1CategoryLists> layer1Category;
  List<Layer2CategoryLists> layer2Category;
}

class Layer1CategoryLists {
  final int id;
  final String name;
  final bool isActive;

  Layer1CategoryLists(this.id, this.name, this.isActive);

  @override
  String toString() {
    return '{ ${this.name}, ${this.id}, ${this.isActive} }';
  }
}

class Layer2CategoryLists {
  final int id;
  final String name;
  final List<Layer3CategoryLists> layer3Category;

  Layer2CategoryLists(this.id, this.name, this.layer3Category);

  @override
  String toString() {
    return '{ ${this.name}, ${this.id} }';
  }
}

class Layer3CategoryLists {
  final int id;
  final String name;

  Layer3CategoryLists(this.id, this.name);

  @override
  String toString() {
    return '{ ${this.name}, ${this.id} }';
  }
}
