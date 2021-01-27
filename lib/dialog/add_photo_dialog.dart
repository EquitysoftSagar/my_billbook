import 'dart:html';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/model/photo.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/text_field/photo_text_field.dart';
import 'package:my_billbook/util/methods.dart';

class AddPhotoDialog extends StatefulWidget {
final Function addPhotoFunction;
final Function editPhotoFunction;
final int index;
final bool forEdit;
final Photo photo;
  const AddPhotoDialog({Key key, this.addPhotoFunction,this.editPhotoFunction,this.forEdit,this.photo,this.index}) : super(key: key);

  @override
  _AddPhotoDialogState createState() => _AddPhotoDialogState();
}

class _AddPhotoDialogState extends State<AddPhotoDialog>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();

  final _descriptionController = TextEditingController();
  Animation<double> _animation;
  AnimationController _animationController;
  Uint8List _image;
  String _imageLink;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation =
    new CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.dismissed) {
        Navigator.pop(context);
      }
    });
    if(widget.forEdit){
      _nameController.text = widget.photo.name;
      _descriptionController.text = widget.photo.description;
      _image = widget.photo.imageByte;
      _imageLink = widget.photo.imageLink;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 400,
          padding: EdgeInsets.only(
            bottom: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                height: 50,
                decoration: BoxDecoration(
                    color: MyColors.accent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )),
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Photo',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20,),
                        _imageLink != null ? _imageView() : _image == null ? _selectImageView() : _imageView(),
                        SizedBox(height: 30,),
                        PhotoTextField(
                          labelText: 'Name',
                          controller: _nameController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        PhotoTextField(
                          labelText: 'Description',
                          controller: _descriptionController,
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    onPressed: () {
                      _animationController.reverse();
                    },
                    child: Text('Cancel'),
                    color: Colors.white,
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      onSaveTap(context);
                    },
                    child: Text('Save'),
                    color: MyColors.accent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectImageView() {
    return InkWell(
      onTap: _pickImage,
      child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(5),
          dashPattern: [6, 3, 6, 3],
          child: Container(
              width: double.infinity,
              height: 150,
              alignment: Alignment.center,
              child: Text('Click to pick photo'))
      ),
    );
  }

  Widget _imageView() {

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            width: double.infinity,
            child: _imageLink != null ? Image.network(_imageLink, height: 150, fit: BoxFit.fitHeight,errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace){
              // toastError('Image is not loaded');
              return _onErrorImageView();
            },) : Image.memory(_image, height: 150, fit: BoxFit.fitHeight,errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace){
      toastError('Please select image file');
      return _onErrorImageView();
    },)),
        FlatButton(onPressed: _onImageDeleteTap,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: CircleBorder(),
            padding: EdgeInsets.all(15),
            child: Icon(Icons.delete,color: Colors.redAccent,))
      ],
    );
  }

  Widget _onErrorImageView(){
    return Container(
      height: 150,
      child: Icon(Icons.image_not_supported,color: Colors.grey,size: 100,),
    );
  }

  void _pickImage() async {
    InputElement _pickImageElement = FileUploadInputElement();
    _pickImageElement.accept = 'image/*';
    _pickImageElement.click();

    _pickImageElement.onChange.listen((e) {
      // read file content as dataURL
      final files = _pickImageElement.files;
      if (files.length == 1) {
       final file = files[0];
        FileReader reader = FileReader();
        reader.onLoadEnd.listen((e) {
          setState(() {
            _image = reader.result;
          });
        });
        reader.onError.listen((fileEvent) {
          toastError("Some Error occured while reading the file");
        });
        reader.readAsArrayBuffer(file);
      }
    });
  }

  void onSaveTap(BuildContext context) {
    if(_image != null){
      var p = Photo();
      p.name = _nameController.text;
      p.description = _descriptionController.text;
      p.imageByte = _image;
      widget.forEdit ? widget.editPhotoFunction(widget.index,p) : widget.addPhotoFunction(p);
      _animationController.reverse();
    }
  }

  void _onImageDeleteTap() {
    setState(() {
      _image = null;
      _imageLink = null;
    });
  }
}
