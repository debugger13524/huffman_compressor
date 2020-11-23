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
    var s=ht.getCodedText(_toEncode);

    var rem=(8-s.length %8)%8;

    var padding="";
    for(var i=0;i<rem;i++)
      {
        padding=padding+"0";

      }

    s=s+padding;
    print("\n\n\n\n\n$s");
    String result="";
    for(int i=0;i<s.length;i=i+8)
      {
        int num=0;
        for(int j=0;j<8;j++)
          {
            int c =(s[i+j].codeUnitAt(0))-48;

            num=num*2 +c;
            print('1111111');
//            num=num*2 + (s[i+j]-'0');
          }

        result=result+String.fromCharCode(num);
      }
    return result;
  }

  String getCharactersCodes()
  {
    return ht.getCodesForEachCharacter();
  }
}
