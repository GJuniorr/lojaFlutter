import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lojapflutter/screens/homepage.dart';
import 'package:mysql_client/mysql_client.dart';

class loginUser extends StatefulWidget {
  const loginUser({super.key});

  @override
  State<loginUser> createState() => _loginUserState();
}

class _loginUserState extends State<loginUser> {

  List freteG = [
    'Bairro Jardins',
    'Jardins',
    '13 de Julho',
    'Farolândia',
    'Augusto Franco'
  ];

  int? count = 0;

  String? ProdutoID;

  String? ProdutoN;

  double? ProdutoP;
  
  String? ProdutoE;

  String Username = '';

  String UserID = '';

  String Usuario = '';

  String Senha = '';

  String UserSenha = '';

  String UserEmail = '';

  String UserTelefone = '';

  String UserNome = '';

  String UserBairro = '';

  String UserAvRua = '';

  String UserNumero = '';

  String UserCEP = '';

  List<Map<String, String>> dados = [];
  late MySQLConnection conn;

  @override
  void initState() {
    super.initState();
    getConnection();
  }

  Future getConnection() async {
    conn = await MySQLConnection.createConnection(
      host: '',
      port: ,
      userName: '',
      password: '',
      databaseName: 'apploja',
    );
    try {
      await conn.connect();
      print('Conexão bem sucedida');
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }

    //await conn.close();
  }


  Future BolsaSelect() async {
      var resultadoBS = await conn.execute("SELECT * FROM bolsa WHERE ID_Usuario = '$UserID' ");
     
     setState(() {
       count = resultadoBS.numOfRows;
       print('Quantidade na bolsa $count');
     });
      

      for (var element in resultadoBS.rows) {
        Map data = element.assoc();
        ProdutoID = data['ID_Produto'];
        ProdutoN = data['Produto'];
        ProdutoP = double.tryParse(data['Preço'])!;
        ProdutoE = data['Estoque'];
          }
          
  }

  Future entrarUser(String User, String password) async {

      var resultado = await conn.execute("SELECT * FROM usuarios WHERE Usuario = '$User' AND Senha = '$password' ");

     

      for (var element in resultado.rows) {
        Map data = element.assoc();
        UserID = data['ID_Usuario'];
        Username = data['Usuario'];
        UserSenha = data['Senha'];
        UserEmail = data['Email'];
        UserTelefone = data['Telefone'];
        UserNome = data['Nome'];
        UserBairro = data['Bairro'];
        //UserBairro = UserBairro.toUpperCase();
        UserAvRua = data['AvRua'];
        UserNumero = data['Numero'];
        UserCEP = data['CEP'];

        print(
            'Id: ${data['ID_Usuario']}, Username: ${data['Usuario']}, Password: ${data['Senha']}, Email: ${data['Email']}, Telefone: ${data['Telefone']}, Nome: ${data['Nome']}, Bairro: ${data['Bairro']}, AvRua: ${data['AvRua']}, Numero: ${data['Numero']}, CEP: ${data['CEP']}');
          }

    if (User == Username && password == UserSenha) {
      print("ID: $UserID. O usuário é $Username e a senha é $UserSenha. ");
       var resultadoBS = await conn.execute("SELECT * FROM bolsa WHERE ID_Usuario = '$UserID' ");
     
      setState(() {
       count = resultadoBS.numOfRows;
       print('Quantidade na bolsa $count');
     });

      Navigator.push(context,
       MaterialPageRoute(builder: (context) => Homepage(
        IDU: UserID,
        ProdutoID: ProdutoID,
        ProdutoN: ProdutoN,
        ProdutoP: ProdutoP,
        ProdutoE: ProdutoE,
        Usuario: Username,
        EmailU: UserEmail,
        TelefoneU: UserTelefone,
        NomeU: UserNome,
        BairroU: UserBairro,
        AvRuaU: UserAvRua,
        NumeroU: UserNumero,
        CEPU: UserCEP,
        freteG: freteG,
        count: count,
        
       ),));
    }else{
      print("O usuário é $User e a senha é $password");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro de Login'),
          content: const Text('Usuário ou senha incorretos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
        );
    }
  }
  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Center(
                child: Text('Tela de Login',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
                ),
                ),
            ),
            Padding(
            padding:  const EdgeInsets.only(top: 30),
            child: Container(
              color: Colors.lightBlue,
              width: 500,
              height: 500,
              child:  Column(
                children: [
                   Padding(
                    padding: const EdgeInsets.only(top: 20, right: 48),
                    child: SizedBox(
                      width: 320,
                      child: SizedBox(
                        width: 320,
                        child: TextField(
                          onChanged: (valueU) {
                            Usuario = valueU;
                          },
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Usuário',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ), 
                          ),
                        ),
                      ),
                    ),
                    ),
        
                     Padding(
                    padding: const EdgeInsets.only(top: 20, right: 48),
                    child: SizedBox(
                      width: 320,
                      child: SizedBox(
                        width: 320,
                        child: TextField(
                          onChanged: (valueS) {
                            Senha = valueS;
                          },
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Senha',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ), 
                          ),
                        ),
                      ),
                    ),
                    ),
        
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Column(
                         children: [
                           Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: TextButton(
                            style: const ButtonStyle(
                              //backgroundColor: MaterialStatePropertyAll(Colors.white)
                            ),
                            onPressed: () {
                              
                            }, child: const Text('Não tem conta?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            ),
                            ),
                           Padding(
                            padding: const EdgeInsets.only(top: 05, left: 20),
                            child: TextButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.white)
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, 'cadastroUser');
                            }, child: const Text('Cadastrar',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            ),
                            ),
                         ],
                       ),
        
                      Padding(
                      padding: const EdgeInsets.only(bottom: 33, right: 70),
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.white)
                        ),
                        onPressed: () {
                          entrarUser(Usuario, Senha);
                          //BolsaSelect();
                        }, child: const Text('Entrar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),),
                        ),
                      ),
                    ],
                   )
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
