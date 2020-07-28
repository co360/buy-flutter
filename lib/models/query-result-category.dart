class QueryResultCategory {
  List<Layer1CategoryLists> layer1Category;
  List<Layer2CategoryLists> layer2Category;
}

class Layer1CategoryLists {
  final int id;
  final String name;
  final String code;
  final bool isActive;

  Layer1CategoryLists(this.id, this.name, this.code, this.isActive);

  @override
  String toString() {
    return '{ ${this.name}, ${this.id}, ${this.code}, ${this.isActive} }';
  }
}

class Layer2CategoryLists {
  final int id;
  final String name;
  final String code;
  final List<Layer3CategoryLists> layer3Category;

  Layer2CategoryLists(this.id, this.name, this.code, this.layer3Category);

  @override
  String toString() {
    return '{ ${this.name}, ${this.id}, ${this.code}  }';
  }
}

class Layer3CategoryLists {
  final int id;
  final String code;
  final String name;

  Layer3CategoryLists(this.id, this.name, this.code);

  @override
  String toString() {
    return '{ ${this.name}, ${this.id}, ${this.code} }';
  }
}
