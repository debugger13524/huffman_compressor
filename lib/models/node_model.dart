class Node {
  String _character;
  int _frequency;
  Node _left, _right;

  Node(String character, int frequency) {
    this._character = character;
    this._frequency = frequency;
    _left = _right = null;
  }

  void setCharacter(String character)
  {
    _character = character;
  }

  void setFrequency(int frequency) {
    _frequency = frequency;
  }

  void updateFrequency() {
    _frequency++;
  }

  void setLeft(Node left) {
    _left = left;
  }

  void setRight(Node right) {
    _right = right;
  }

  String getCharacter() {
    return _character;
  }

  int getFrequency() {
    return _frequency;
  }

  Node getLeft() {
    return _left;
  }

  Node getRight() {
    return _right;
  }

  bool isLeaf() {
    return (_left == null && _right == null);
  }
}