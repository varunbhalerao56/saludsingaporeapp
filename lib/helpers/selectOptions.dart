import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saludsingapore/models/export_models.dart';
import 'package:smart_select/smart_select.dart';

class FeaturesSinglePopup extends StatefulWidget {
  @override
  _FeaturesSinglePopupState createState() => _FeaturesSinglePopupState();

}

class _FeaturesSinglePopupState extends State<FeaturesSinglePopup> {
  List<SmartSelectOption<String>>
   fruits = [
    SmartSelectOption<String>(value: 'app', title: 'Apple'),
    SmartSelectOption<String>(value: 'ore', title: 'Orange'),
    SmartSelectOption<String>(value: 'mel', title: 'Melon'),
  ];

  List<SmartSelectOption<String>> frameworks = [
    SmartSelectOption<String>(value: 'ion', title: 'Ionic'),
    SmartSelectOption<String>(value: 'flu', title: 'Flutter'),
    SmartSelectOption<String>(value: 'rea', title: 'React Native'),
  ];
  TextEditingController abc = TextEditingController();
  String _fruit = 'mel';
  String _framework = 'flu';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[


        Container(height: 7),
        SmartSelect<String>.single(
          title: 'Fruit',
          value: _fruit,
          options: fruits,
          leading: const Icon(Icons.shopping_cart),
          onChange: (val) => setState(() => _fruit = val),
          modalType: SmartSelectModalType.popupDialog,
        ),
        Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Frameworks',
          value: _framework,
          options: frameworks,
          modalType: SmartSelectModalType.popupDialog,
          builder: (context, state, showOption) {
            return ListTile(
              title: Text(state.title),
              subtitle: Text(
                state.valueDisplay,
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                    '${state.valueDisplay[0]}',
                    style: TextStyle(color: Colors.white)
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => showOption(context),
            );
          },
          onChange: (val) => setState(() => _framework = val),
        ),
        Container(height: 7),
      ],
    );
  }
}
class FeaturesMultiPopup extends StatefulWidget {
  @override
  _FeaturesMultiPopupState createState() => _FeaturesMultiPopupState();
}

class _FeaturesMultiPopupState extends State<FeaturesMultiPopup> {

  List<String> _items1 = ['Drinks'];
  List<String> _items2 = ['Drinks'];

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<List<Categories>>(context);
    List <String>abc;
    List<SmartSelectOption<String>> categoryItem = [];
    for (var data in category)
      categoryItem.add(SmartSelectOption<String>(value: data.categoryName, title: data.categoryName));

    print(categoryItem);

    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.multiple(
          title: 'Choose items',
          value: _items1,
          isTwoLine: true,
          options: categoryItem,
          modalType: SmartSelectModalType.popupDialog,
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.shopping_cart),
          ),
          onChange: (val) => setState(() => _items1 = val),
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Choose items 2',
          value: _items2,
          options: categoryItem,
          modalType: SmartSelectModalType.popupDialog,
          builder: (context, state, showOptions) {
            return ListTile(
              title: Text(state.title),
              subtitle: Text(
                state.valueDisplay,
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(_items2.length.toString(),
                    style: TextStyle(color: Colors.white)),
              ),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => showOptions(context),
            );
          },
          onChange: (val) => setState(() => _items2 = val),
        ),
        Container(height: 7),
      ],
    );
  }
}
