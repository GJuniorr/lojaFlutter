import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysql_client/mysql_client.dart';

class enderecoUser extends StatefulWidget {

  final String? Usuario;
  final String? Senha;
  final String? Email;
  final String? Telefone;
  final String? Nome;

  const enderecoUser({
    super.key,
    required this.Usuario,
    required this.Senha,
    required this.Email, 
    required this.Telefone, 
    required this.Nome,});

  @override
  State<enderecoUser> createState() => _enderecoUserState();
}

class _enderecoUserState extends State<enderecoUser> {

 List<Map<String, String>> dados = [];
  late MySQLConnection conn;

  
  String Usuario = '';

  String Senha = '';

  String Email = '';

  String Telefone = '';

  String Nome = '';

  @override
  void initState() {
    super.initState();
    getConnection();
    Usuario = widget.Usuario!;
    Senha = widget.Senha!;
    Email = widget.Email!;
    Telefone = widget.Telefone!;
    Nome = widget.Nome!;
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

    //await carregarDados();
    //await conn.close();
}

 Future salvarDados(String Usuario, String Senha, String Email, String Telefone, String Nome, String Bairro, String AvRua, String Numero, String CEP) async {
    try {
    final Map<String, dynamic> parametros = {'Usuario': Usuario, 'Senha': Senha, 'Email': Email, 'Telefone': Telefone, 'Nome': Nome, 'Bairro': Bairro, 'AvRua': AvRua, 'Numero': Numero, 'CEP': CEP};

    // Executa a consulta SQL com o mapa de parâmetros
    await conn.execute('INSERT INTO usuarios (Usuario, Senha, Email, Telefone, Nome, Bairro, AvRua, Numero, CEP) VALUES (:Usuario, :Senha, :Email, :Telefone, :Nome, :Bairro, :AvRua, :Numero, :CEP)', parametros);

    await conn.execute('COMMIT');
    print('Cadastro feito com sucesso');
  } catch (e) {
    print('Erro ao finalizar cadastro: $e');
  }
 }


  String Bairro = '';

  String AvRua = '';

  String Numero = '';

  String CEP = '';


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Center(
                child: Text('Tela de Endereço',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),),
                ),
            ),
            Padding(
              padding:   const EdgeInsets.only(top: 30),
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
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          onChanged: (valueB) {
                            Bairro = valueB;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Bairro',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ), 
                          ),
                        ),
                      ),
                      ),
        
                       Padding(
                      padding: const EdgeInsets.only(top: 20, right: 48),
                      child: SizedBox(
                        width: 320,
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          onChanged: (valueAV) {
                            AvRua = valueAV;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Av/Rua',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ), 
                          ),
                        ),
                      ),
                      ),
        
                       Padding(
                      padding: const EdgeInsets.only(top: 20, right: 48),
                      child: SizedBox(
                        width: 320,
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          onChanged: (valueNum) {
                            Numero = valueNum;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Número',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ), 
                          ),
                        ),
                      ),
                      ),
        
                      Padding(
                      padding: const EdgeInsets.only(top: 20, right: 48),
                      child: SizedBox(
                        width: 320,
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          onChanged: (valueCEP) {
                            CEP = valueCEP;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'CEP',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ), 
                          ),
                        ),
                      ),
                      ),
        
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 10),
                            child: TextButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.white) ,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, 'cadastroUser');
                              }, child: const Text('Voltar',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),)),
                          ),
        
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 0),
                            child: TextButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.white) ,
                              ),
                              onPressed: () {
                              Navigator.pushNamed(context, 'loginUser');
                              }, child: const Text('Já tenho uma conta',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                              ),
                          ),
        
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 10),
                            child: TextButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.white) ,
                              ),
                              onPressed: () {
                               salvarDados(Usuario, Senha, Email, Telefone, Nome, Bairro, AvRua, Numero, CEP);
                               Navigator.pushNamed(context, 'loginUser');
                              }, child: const Text('Cadastrar',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),)),
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
