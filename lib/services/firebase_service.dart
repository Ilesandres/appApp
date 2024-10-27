import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


FirebaseFirestore db=FirebaseFirestore.instance;

Future<List> getPeople() async{
List people =[];
CollectionReference collectionReferencePeople= db.collection('people');
QuerySnapshot QuerryPeople= await collectionReferencePeople.get();
QuerryPeople.docs.forEach((documento){ 
people.add (documento.data());
});
return people;
}