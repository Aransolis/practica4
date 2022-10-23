
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ndialog/ndialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:path_provider/path_provider.dart';

import 'package:practica1/screens/databaseuser_helper.dart';
import '../models/users_model.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  PickedFile? imageFile;
  DatabaseHelper? _database;
  bool ban = false;
  String imagePath ="";
  
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();
  TextEditingController txtConPhone = TextEditingController();
  TextEditingController txtConGit = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _database = DatabaseHelper();
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      this.setState(() {
        imageFile = picture as PickedFile?;

      });
      Navigator.of(context).pop();
  }
  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.platform.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture as PickedFile?;
    });
    Navigator.of(context).pop();
  }
  Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(File(imageFile!.path), width: 500, height: 500);
    } else {
      return Image.asset('assets/');
    }
  }
  bool _val(){
    if(imageFile!=null){
      return true;
    }else{
      return false;
    }
  }
  bool _valPR(){
    if(ModalRoute.of(context)!.settings.arguments != null){
      final User = ModalRoute.of(context)!.settings.arguments as Map;
      imagePath = User['imagen'];
    }
    if("".compareTo(imagePath)!=0){
      return true;
    }else{
      return false;
    }
  }
   Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Donde buscar la imagen?"),
          content: SingleChildScrollView(
            child: ListBody(
              
              children: <Widget>[
                FloatingActionButton(
                  child: const Icon(Icons.image),
                  onPressed: () {
                    _openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                FloatingActionButton(
                  child: const Icon(Icons.camera_alt),
                  onPressed: () {
                    _openCamera(context);
                  },
                )
              ],
            ),
          )
        );
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {

    if(ModalRoute.of(context)!.settings.arguments != null){
      final User = ModalRoute.of(context)!.settings.arguments as Map;
      ban=true;
      imagePath = User['imagen'];
      txtConName.text=User['nombre'];
      txtConEmail.text = User ['correo'];
      txtConPhone.text = User['numero'];
      txtConGit.text= User['urlGit'];
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Información de perfil'),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15
        ),
        children: [
          Container(
            
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width /5),
            height: MediaQuery.of(context).size.height / 4,
            
            child: Stack(
              
              alignment: Alignment.bottomRight,
              children: [

                FutureBuilder(
                  future: _database!.getUser(),
                  builder: (context, AsyncSnapshot<List<UsersDAO>> snapshot){
                    if(_val()){
                      return Hero(
                        tag: 'profile', 
                        child: 
                        CircleAvatar(
                          radius: 200,
                          backgroundImage: FileImage(File(imageFile!.path)),  
                        ) 
                      );
                    }else{
                      if(snapshot.hasData&&snapshot.data?.length!=0){
                    
                        return Hero(
                          tag: 'profile', 
                          child: 
                          CircleAvatar(
                            radius: 200,
                            backgroundImage: FileImage(File(imagePath)),  
                          ) 
                        );
                      }else{
                        return Hero(
                          tag: 'profile', 
                          child: 
                          CircleAvatar(
                            radius: 200,
                            backgroundImage: AssetImage('assets/default-user-image.jpg',),  
                          ),
                        );
                      }
                    }
                  }
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius:BorderRadius.circular(100)
                    ),
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => _showSelectionDialog(context),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          TextField(
            controller: txtConName,
            decoration: InputDecoration(
              labelText: 'Nombre ',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              hintText: 'Ingresar nombre'
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          TextField(
            controller: txtConEmail,
            decoration: InputDecoration(
              labelText: 'Correo',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              hintText: 'ejemplo@correo.com'
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          IntlPhoneField(
            
            controller: txtConPhone,
            decoration: InputDecoration(
              
              labelText: 'Numero Telefono',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            /*onChanged: (phone) {
              print(phone.completeNumber);
            },*/
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
          TextField(
            controller: txtConGit,
            decoration: InputDecoration(
              labelText: 'Pagina de GitHub',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              hintText: 'https://github.com/'
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(  
                  child: const Text(
                    'Guardar',
                    style: TextStyle(fontSize: 10),
                
                  ),
                  onPressed: () async {
                    if(txtConName.text.isEmpty||txtConEmail.text.isEmpty||txtConPhone.text.isEmpty||txtConGit.text.isEmpty||!(_val()||_valPR())){
                      await DialogBackground(
                        dialog: AlertDialog(
                          title: Text("Alert Dialog"),
                          content: Text("Necesitas completar todos los campos y revisar que se añadio una imagen"),
                          backgroundColor: Color.fromARGB(255, 222, 86, 76),
                          titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
                          contentTextStyle: TextStyle(color: Colors.white),
                          
                        ),
                      ).show(context);
                    }else{

                      
                      if(!ban){
                        final File image = File(imageFile!.path);
                        Directory carpeta = await getApplicationDocumentsDirectory();
                        final String path = carpeta.path;
                        final File localImage = await image.copy('$path/image.jpg');
                        _database?.insertar({
                          'imagen':localImage.path,
                          'nombre':txtConName.text,
                          'correo':txtConEmail.text,
                          'numero':txtConPhone.text,
                          'urlGit':txtConGit.text
                        }, 'tblUser').then((value) {
                          Navigator.pop(context);
                          final snackBar =
                              SnackBar(content: Text('Datos de Usuario Registrados Correctamente!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }else{
                        if(_val()){
                          final File image = File(imageFile!.path);
                          Directory carpeta = await getApplicationDocumentsDirectory();
                          final String path = carpeta.path;
                          final File localImage = await image.copy('$path/image.jpg');
                          _database?.actualizarUsers({
                            'id_Usuario': 1,
                            'imagen':localImage.path,
                            'nombre':txtConName.text,
                            'correo':txtConEmail.text,
                            'numero':txtConPhone.text,
                            'urlGit':txtConGit.text
                          }, 'tblUser').then((value) {
                            Navigator.pop(context);
                            final snackBar =
                                SnackBar(content: Text('Datos de Usuario Actualizados Correctamente!'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          });
                        }else{
                          _database?.actualizarUsers({
                            'id_Usuario': 1,
                            'imagen':imagePath,
                            'nombre':txtConName.text,
                            'correo':txtConEmail.text,
                            'numero':txtConPhone.text,
                            'urlGit':txtConGit.text
                          }, 'tblUser').then((value) {
                            Navigator.pop(context);
                            final snackBar =
                                SnackBar(content: Text('Datos de Usuario Actualizados Correctamente!'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          });

                        }
                        
            
                      }
                    }
                    
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(75, 75),
                    shape: const CircleBorder(), 
                  ),
                ),
              ),
              
            ]
          ),
        ],
      ), 
    );
  }
}