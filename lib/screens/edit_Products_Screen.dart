import 'package:flutter/material.dart';
import '../providers/product.dart';

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
  final _form = GlobalKey<FormState>();
  var _myProduct =
      Product(id: '', title: '', description: '', price: 0.0, imageUrl: '');
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

  void _savedForm() {
    bool valid = _form.currentState!.validate();
    if (!valid) return;
    _form.currentState!.save();
    print(_myProduct.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Edit Products"),
        actions: <Widget>[
          IconButton(
            onPressed: _savedForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Title"),
                  ),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the title";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _myProduct = Product(
                        id: '',
                        title: value!,
                        description: _myProduct.description,
                        price: _myProduct.price,
                        imageUrl: _myProduct.imageUrl);
                  },
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Price"),
                  ),
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Please enter the price";
                    else if (double.tryParse(value) == null)
                      return "Please enter a valid ";
                    else if (double.parse(value) <= 0)
                      return "Please enter price greater than 0";

                    return null;
                  },
                  onSaved: (value) {
                    _myProduct = Product(
                        id: '',
                        title: _myProduct.title,
                        description: _myProduct.description,
                        price: double.parse(value!),
                        imageUrl: _myProduct.imageUrl);
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      label: Text("Description"),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value!.isEmpty)
                        return "Please enter the Description";
                      else if (value.length <= 10)
                        return "Please enter description greater than 10 words";
                      return null;
                    },
                    focusNode: _descFocusNode,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      _myProduct = Product(
                          id: '',
                          title: _myProduct.title,
                          description: value!,
                          price: _myProduct.price,
                          imageUrl: _myProduct.imageUrl);
                    }),
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
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Please enter the Image URL";
                          else if (!value.startsWith("http") &&
                              !value.startsWith("https"))
                            return "Please enter valid URL";
                          else if (!value.endsWith("jpg") &&
                              !value.endsWith("png") &&
                              !value.endsWith("jpeg"))
                            return "Please enter valid URL";
                          return null;
                        },
                        onSaved: (value) {
                          _myProduct = Product(
                              id: '',
                              title: _myProduct.title,
                              description: _myProduct.description,
                              price: _myProduct.price,
                              imageUrl: value!);
                        },
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
