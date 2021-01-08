
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_billbook/firebase/collection.dart';
import 'package:my_billbook/firebase/field.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/util/methods.dart';

User firebaseUser;

class FirebaseService {

  static FirebaseAuth _firebaseAuth;
  static FirebaseFirestore _firebaseFirestore;

  static void init(){
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  static Future<bool> signIn(String email,String password)async{
    try{
      var _result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser = _result.user;
      toastSuccess('Login Successfully');
      return true;
    }on FirebaseAuthException catch (error) {
      print('Firebase login error code ==> ${error.code}');
      if (error.code == 'user-not-found') {
        toastError('User is not found with this email');
      } else if (error.code == 'email-already-in-use') {
        toastError('The account already exists for that email.');
      } else if (error.code == 'wrong-password') {
        toastError('Password is wrong');
      } else if (error.code == 'too-many-requests') {
        toastError('too-many-requests try again after some time');
      } else if (error.code == 'network-request-failed') {
        toastError('network-request-failed try again after some time');
      }
      return false;
    } catch (e) {
      print('Firebase login error ===> $e');
      toastError('Something went wrong in login try again after some time');
      return false;
    }
  }

  //Customer

  static Stream<QuerySnapshot> getCustomer(){
    try{
     return _firebaseFirestore.collection(Collection.customer).where(Field.userId,isEqualTo: firebaseUser.uid).snapshots();
    }catch (e){
      print('Catch on get customer ==>$e');
    }
    return null;
  }
  static Future<void> deleteCustomer(String id)async{
    try{
      await _firebaseFirestore.collection(Collection.customer).doc(id).delete();
      toastSuccess('Deleted successfully');
    }catch (e){
      toastError('Error when deleting customer');
      print('Catch on get customer ==>$e');
    }
  }
  static Future<bool> addCustomer(Customer customer)async{
    try{
      await _firebaseFirestore.collection(Collection.customer).add(customer.toJson());
      toastSuccess('Added successfully');
      return true;
    }catch (e){
      toastError('Error when adding customer');
      print('Catch on add customer ==>$e');
      return false;
    }
  }
  static Future<bool> editCustomer(String id ,Customer customer)async{
    try{
      await _firebaseFirestore.collection(Collection.customer).doc(id).update(customer.toJson());
      toastSuccess('Update successfully');
      return true;
    }catch (e){
      toastError('Error when updating customer');
      print('Catch on update customer ==>$e');
      return false;
    }
  }

  // Items

  static Stream<QuerySnapshot> getItem(){
    try{
      return _firebaseFirestore.collection(Collection.item).where(Field.userId,isEqualTo: firebaseUser.uid).snapshots();
    }catch (e){
      print('Catch on get item ==>$e');
    }
    return null;
  }
  static Future<void> deleteItem(String id)async{
    try{
      await _firebaseFirestore.collection(Collection.item).doc(id).delete();
      toastSuccess('Deleted successfully');
    }catch (e){
      toastError('Error when deleting item');
      print('Catch on get item ==>$e');
    }
  }
  static Future<bool> addItem(Item item)async{
    try{
      await _firebaseFirestore.collection(Collection.item).add(item.toJson());
      toastSuccess('Added successfully');
      return true;
    }catch (e){
      toastError('Error when adding item');
      print('Catch on add item ==>$e');
      return false;
    }
  }
  static Future<bool> editItem(String id ,Item item)async{
    try{
      await _firebaseFirestore.collection(Collection.item).doc(id).update(item.toJson());
      toastSuccess('Update successfully');
      return true;
    }catch (e){
      toastError('Error when updating item');
      print('Catch on update item ==>$e');
      return false;
    }
  }

  static Future<bool> addTrash(Item item)async{
    try{
      await _firebaseFirestore.collection(Collection.trash).add({
        'item':[item.toJson()]
      });
      toastSuccess('Trashed successfully');
      return true;
    }catch (e){
      toastError('Error when trash item');
      print('Catch on trash item ==>$e');
      return false;
    }
  }
}