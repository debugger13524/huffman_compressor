import 'package:huffmanapp/models/huffman_tree_model.dart';

class EncodeText
{
  HuffmanTree ht;
  String _toEncode;

  EncodeText(this._toEncode);

  void calculateHuffmanCode()
  {
    ht = new HuffmanTree();
    for (int i = 0; i < _toEncode.length; i++)
    {
      ht.insertNode(_toEncode[i], 1);
    }
    ht.generateCodesAndText();
  }

  String getResultText()
  {
    return ht.getCodedText(_toEncode);
  }

  String getCharactersCodes()
  {
    return ht.getCodesForEachCharacter();
  }
}
