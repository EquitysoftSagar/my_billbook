import 'package:flutter/material.dart';
import 'package:my_billbook/model/photo.dart';
import 'package:my_billbook/style/colors.dart';

class InvoicePhotoItemView extends StatelessWidget {
  final Photo photo;
  final Function editFunction;
  final Function removeFunction;
  final int index;

  const InvoicePhotoItemView({Key key, this.photo,this.editFunction,this.removeFunction,this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          photo.imageLink != null ? Image.network(photo.imageLink,height: 80,width: 80,fit: BoxFit.cover,errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace){
            // toastError('Image is not loaded');
            return _onErrorImageView();
          },) : Image.memory(photo.imageByte,height: 80,width: 80,fit: BoxFit.cover,),
          SizedBox(width: 15,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(photo.name,style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),),
              SizedBox(height: 10,),
              Text(photo.description,style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),),
            ],
          ),
          Spacer(),
          Tooltip(
            message: 'Edit',
            child: InkWell(
              child: Icon(
                Icons.edit,
                color: Colors.blueAccent,
              ),
              onTap: (){
                editFunction(photo,index);
              },
            ),
          ),
          SizedBox(width: 5,),
          Tooltip(
            message: 'Edit',
            child: InkWell(
              child: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onTap: (){
                removeFunction(photo);
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _onErrorImageView(){
    return Container(
      height: 80,
      child: Icon(Icons.image_not_supported,color: Colors.grey,size: 80,),
    );
  }
}
