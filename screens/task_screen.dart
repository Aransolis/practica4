import 'package:flutter/material.dart';
import 'package:practica1/screens/database_helper.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({ Key? key }) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DatabaseHelper? _database;
  bool ban = false;

@override
  void initState() {
    super.initState();
    _database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtFecha = TextEditingController();
    TextEditingController txtDesc = TextEditingController();
    int idTarea = 0;

    if(ModalRoute.of(context)!.settings.arguments != null){
      final tarea = ModalRoute.of(context)?.settings.arguments as Map;
      ban = true;
      txtFecha.text = tarea['fechaEnt'];
      txtDesc.text = tarea['dscTarea'];
      idTarea = tarea['idTarea'];
    }



    final txtFechaEnt = TextField(
      controller: txtFecha, 
      decoration: InputDecoration(border: OutlineInputBorder())
      );
    final txtDescTask = TextField(controller: txtDesc, 
    decoration: InputDecoration(border: OutlineInputBorder()),
    maxLines: 8,);

  final btnGuardar = ElevatedButton(
    onPressed: (){
    if(!ban){
    _database!.insertar({
      'dscTarea': txtDesc.text,
      'fechaEnt': txtFecha.text,
      }, 'tblTareas').then((value) {
        final snackBar = SnackBar(content: Text('Tarea registrada correctamente'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }else{
      _database!.actualizar({
        'idTarea': idTarea,
        'dscTarea': txtDesc.text,
        'fechaEnt': txtFecha.text,
      }, 'tblTareas').then(
        (value){
           final snackBar = 
            SnackBar(content: Text('Tarea actualizada correctamente'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      );
    }
    Navigator.pop(context);

  }, child: Text('Guardar'),);
    return Scaffold(
      appBar: AppBar(title: ban == false ?  Text('Add Task') : Text('Update Task'),
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
        children: [
          txtFechaEnt,
          Padding(
            padding: const EdgeInsets.symmetric(vertical:10),
            child: txtDescTask),
          btnGuardar
      ],
      ),
    );
  }
}