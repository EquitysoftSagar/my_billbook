import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/collection.dart';
import 'package:my_billbook/firebase/field.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/document.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/model/user.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:my_billbook/util/my_shared_preference.dart';
import 'package:my_billbook/util/routes.dart';

User firebaseUser;

class FirebaseService {
  static FirebaseAuth _firebaseAuth;
  static FirebaseFirestore _firebaseFirestore;

  static void init() {
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      var _result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      firebaseUser = _result.user;
      userModel = await getUserDetails();
      toastSuccess('Login successfully');
      return true;
    } on FirebaseAuthException catch (error) {
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

  static Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  static Future<bool> signUp(UserModel user) async {
    try {
      var _result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      firebaseUser = _result.user;
      await _firebaseFirestore
          .collection(Collection.user)
          .doc(firebaseUser.uid)
          .set(user.toJson());
      await _firebaseFirestore.collection(Collection.bills).add(Bills(
              name: 'Invoice',
              userId: firebaseUser.uid,
              createdAt: Timestamp.fromDate(DateTime.now()),
              updatedAt: Timestamp.fromDate(DateTime.now()))
          .toJson());
      userModel = user;
      toastSuccess('Sign up successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        toastError('The account already exists for that email try login');
      }
      return false;
    } catch (e) {
      toastError('Something went wrong in sing up try again after some time');
      print('Error on sign up ==> $e');
      return false;
    }
  }

  //User
  static Future<UserModel> getUserDetails() async {
    try {
      var _result = await _firebaseFirestore
          .collection(Collection.user)
          .doc(firebaseUser.uid)
          .get();
      return UserModel.fromJson(_result.data());
    } catch (e) {
      toastError('Something error on getting user details');
      print('Catch on get user details ==>$e');
      return null;
    }
  }

  static Future<bool> updateUserNames(String firstName, String lastName) async {
    try {
      await _firebaseFirestore
          .collection(Collection.user)
          .doc(firebaseUser.uid)
          .update({
        Field.firstName: firstName,
        Field.lastName: lastName,
        Field.updatedAt: Timestamp.now().toDate()
      });
      userModel.firstName = firstName;
      userModel.lastName = lastName;
      toastSuccess('Update Successfully');
      return true;
    } catch (e) {
      toastError('Error when update user');
      print('Catch on update user ==>$e');
      return false;
    }
  }

  //Customer

  static Stream<QuerySnapshot> getCustomer() {
    try {
      return _firebaseFirestore
          .collection(Collection.customer)
          .where(Field.userId, isEqualTo: firebaseUser.uid)
          .snapshots();
    } catch (e) {
      print('Catch on get customer ==>$e');
    }
    return null;
  }

  static Future<void> deleteCustomer(String id) async {
    try {
      await _firebaseFirestore.collection(Collection.customer).doc(id).delete();
      toastSuccess('Deleted successfully');
    } catch (e) {
      toastError('Error when deleting customer');
      print('Catch on get customer ==>$e');
    }
  }

  static Future<bool> addCustomer(Customer customer) async {
    try {
      await _firebaseFirestore
          .collection(Collection.customer)
          .add(customer.toJson());
      toastSuccess('Added successfully');
      return true;
    } catch (e) {
      toastError('Error when adding customer');
      print('Catch on add customer ==>$e');
      return false;
    }
  }

  static Future<bool> editCustomer(String id, Customer customer) async {
    try {
      await _firebaseFirestore
          .collection(Collection.customer)
          .doc(id)
          .update(customer.toJson());
      toastSuccess('Update successfully');
      return true;
    } catch (e) {
      toastError('Error when updating customer');
      print('Catch on update customer ==>$e');
      return false;
    }
  }

  // Items

  static Stream<QuerySnapshot> getItem() {
    try {
      return _firebaseFirestore
          .collection(Collection.item)
          .where(Field.userId, isEqualTo: firebaseUser.uid)
          .snapshots();
    } catch (e) {
      print('Catch on get item ==>$e');
    }
    return null;
  }

  static Future<void> deleteItem(String id) async {
    try {
      await _firebaseFirestore.collection(Collection.item).doc(id).delete();
      toastSuccess('Deleted successfully');
    } catch (e) {
      toastError('Error when deleting item');
      print('Catch on get item ==>$e');
    }
  }

  static Future<bool> addItem(Item item) async {
    try {
      await _firebaseFirestore.collection(Collection.item).add(item.toJson());
      toastSuccess('Added successfully');
      return true;
    } catch (e) {
      toastError('Error when adding item');
      print('Catch on add item ==>$e');
      return false;
    }
  }

  static Future<bool> editItem(String id, Item item) async {
    try {
      await _firebaseFirestore
          .collection(Collection.item)
          .doc(id)
          .update(item.toJson());
      toastSuccess('Update successfully');
      return true;
    } catch (e) {
      toastError('Error when updating item');
      print('Catch on update item ==>$e');
      return false;
    }
  }

  static Future<bool> addTrash(Item item) async {
    try {
      await _firebaseFirestore.collection(Collection.trash).add({
        'item': [item.toJson()]
      });
      toastSuccess('Trashed successfully');
      return true;
    } catch (e) {
      toastError('Error when trash item');
      print('Catch on trash item ==>$e');
      return false;
    }
  }

  //bills
  static Stream<QuerySnapshot> getBills() {
    try {
      return _firebaseFirestore
          .collection(Collection.bills)
          .where(Field.userId, isEqualTo: firebaseUser.uid)
          .snapshots();
    } catch (e) {
      print('Catch on get bills ==>$e');
    }
    return null;
  }

  static Future<bool> addBills(Bills bills) async {
    try {
      await _firebaseFirestore.collection(Collection.bills).add(bills.toJson());
      // toastSuccess('Bills added successfully');
      return true;
    } catch (e) {
      toastError('Error when adding bills');
      print('Catch on adding bills==>$e');
      return false;
    }
  }

  static Future<bool> editBills(String id, Bills bills) async {
    try {
      await _firebaseFirestore
          .collection(Collection.bills)
          .doc(id)
          .update(bills.toJson());
      toastSuccess('Update successfully');
      return true;
    } catch (e) {
      toastError('Error when updating bills');
      print('Catch on update bills ==>$e');
      return false;
    }
  }

  static Future<bool> editBillsName(String id, String name) async {
    try {
      await _firebaseFirestore.collection(Collection.bills).doc(id).update({
        Field.name: name,
        Field.updatedAt: Timestamp.fromDate(DateTime.now()),
      });
      toastSuccess('Update successfully');
      return true;
    } catch (e) {
      toastError('Error when updating bills name');
      print('Catch on update bills name ==>$e');
      return false;
    }
  }

  static Future<bool> updateBillsSetting(List<Bills> bills) async {
    try {
      for (Bills b in bills) {
        await _firebaseFirestore
            .collection(Collection.bills)
            .doc(b.id)
            .update(b.toJson());
      }
      toastSuccess('Update successfully');
      return true;
    } catch (e) {
      toastError('Error when updating bills setting');
      print('Catch on update bills setting ==>$e');
      return false;
    }
  }

  static Future<bool> updateSettingSendMeCopy(bool value) async {
    try {
      await _firebaseFirestore
          .collection(Collection.user)
          .doc(firebaseUser.uid)
          .update({
        '${Field.settings}.${Field.settingSendMeCopy}': value,
      });
      toastSuccess('Update successfully');
      return true;
    } catch (e) {
      toastError('Error when updating setting send me copy');
      print('Catch on update setting send me copy ==>$e');
      return false;
    }
  }

  static Future<bool> updateSettingDueInDays(String value) async {
    try {
      await _firebaseFirestore
          .collection(Collection.user)
          .doc(firebaseUser.uid)
          .update({
        '${Field.settings}.${Field.settingDueInDays}': value,
      });
      toastSuccess('Update successfully');
      return true;
    } catch (e) {
      toastError('Error when updating setting due in days');
      print('Catch on update setting due in days ==>$e');
      return false;
    }
  }

  static Future<bool> updateSettingDateFormat(String value) async {
    try {
      await _firebaseFirestore
          .collection(Collection.user)
          .doc(firebaseUser.uid)
          .update({
        '${Field.settings}.${Field.settingDateFormat}': value,
      });
      toastSuccess('Update successfully');
      return true;
    } catch (e) {
      toastError('Error when updating setting date format');
      print('Catch on update setting due in date format ==>$e');
      return false;
    }
  }

  static Future<bool> updateSettingLanguage(String value) async {
    try {
      await _firebaseFirestore
          .collection(Collection.user)
          .doc(firebaseUser.uid)
          .update({
        '${Field.settings}.${Field.settingLanguage}': value,
      });
      toastSuccess('Update successfully');
      return true;
    } catch (e) {
      toastError('Error when updating setting language');
      print('Catch on update setting due in language ==>$e');
      return false;
    }
  }

  static Future<bool> deleteBills(String id) async {
    try {
      await _firebaseFirestore.collection(Collection.bills).doc(id).delete();
      toastSuccess('Deleted successfully');
      return true;
    } catch (e) {
      toastError('Error when deleting bills');
      print('Catch on get bills ==>$e');
      return false;
    }
  }

  static Stream<QuerySnapshot> getDocuments(String billId) {
    try {
      return _firebaseFirestore
          .collection(Collection.bills)
          .doc(billId)
          .collection(Collection.documents)
          .snapshots();
    } catch (e) {
      print('Catch on get documents ==>$e');
    }
    return null;
  }

  static Future<bool> addDocument(
      String billId, Documents documents, int next) async {
    try {
      await _firebaseFirestore
          .collection(Collection.bills)
          .doc(billId)
          .collection(Collection.documents)
          .add(documents.toJson());
      await _firebaseFirestore
          .collection(Collection.bills)
          .doc(billId)
          .update({Field.settingNext: next});
      toastSuccess('Document added successfully');
      return true;
    } catch (e) {
      toastError('Error when adding document');
      print('Catch on adding document==>$e');
      return false;
    }
  }

  static Future<bool> editDocuments(
      String billId, String docId, Documents documents) async {
    try {
      await _firebaseFirestore
          .collection(Collection.bills)
          .doc(billId)
          .collection(Collection.documents)
          .doc(docId)
          .update(documents.toJson());
      toastSuccess('Update successfully');
      return true;
    } catch (e) {
      toastError('Error when updating document');
      print('Catch on update document ==>$e');
      return false;
    }
  }

  static void logOut(BuildContext context) async {
    var _result = await Value.clear();
    if (_result) {
      await _firebaseAuth.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.login, (route) => false);
      return;
    }
    toastError('Something Error when Logout');
  }
}
