import 'package:flutter/material.dart';

class EditUserProductScreen extends StatefulWidget {
  static const routeName = '/edit-products';
  @override
  State<EditUserProductScreen> createState() => _EditUserProductScreenState();
}

class _EditUserProductScreenState extends State<EditUserProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imgFocusNode = FocusNode();
  final _imageController = TextEditingController();
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imgFocusNode.addListener((UpdateImageUrl));
    super.initState();
  }

  void UpdateImageUrl() {
    if (!_imgFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Edit Products"),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                label: Text("Title"),
              ),
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text("Price"),
              ),
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descFocusNode);
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text("Description"),
              ),
              maxLines: 3,
              focusNode: _descFocusNode,
              keyboardType: TextInputType.multiline,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 10, right: 6),
                  width: 100,
                  height: 100,
                  child: _imageController.text.isEmpty
                      ? Text("Image URL")
                      : FittedBox(
                          child: Image.network(
                            _imageController.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Image Url",
                    ),
                    keyboardType: TextInputType.url,
                    controller: _imageController,
                    focusNode: _imgFocusNode,
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
