import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojapflutter/screens/teladeLogin/teladeCadastro/enderecoUser.dart';
import 'package:mysql_client/mysql_client.dart';

class cadastroUser extends StatefulWidget {
  const cadastroUser({super.key});

  @override
  State<cadastroUser> createState() => _cadastroUserState();
}

class _cadastroUserState extends State<cadastroUser> {

  bool senhaVizu = false;

  String usuario = '';

  String senha = '';

  String email = '';

  String telefone = '';

  String nome = '';

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
                  child: Text('Tela de Cadastro',
                  style: TextStyle(fontSize: 22,
                  fontWeight: FontWeight.bold),
                  ),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.only(top: 30.0),
              child: Container(
                color: Colors.lightBlue,
                width: 400,
                height: 522,
                child:  Column(
                  children: [
                     Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 48),
                      child: SizedBox(
                        width: 320,
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          onChanged: (valueU) {
                            usuario = valueU;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Usuário',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ),
                    ),
        
                     Row(
                       children: [
                          Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 15),
                          child: SizedBox(
                            width: 320,
                            child: TextField(
                              
                              onChanged: (valueS) {
                                senha = valueS;
                              },
                              style: const TextStyle(color: Colors.black),
                              obscureText: senhaVizu,
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
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                senhaVizu = !senhaVizu;
                              });
                            }, icon: const Icon(Icons.remove_red_eye),
                            iconSize: 28,
                            ),
                       ],
                     ),
                       Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 48),
                      child: SizedBox(
                        width: 320,
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          onChanged: (valueE) {
                            email = valueE;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ),
                    ),
        
                      Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 48),
                      child: SizedBox(
                        width: 320,
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          onChanged: (valueT) {
                            telefone = valueT;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Telefone',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ),
                    ),
        
                      Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 48),
                      child: SizedBox(
                        width: 320,
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black
                          ),
                         onChanged: (valueN) {
                           nome = valueN;
                         },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Nome',
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
                              padding: const EdgeInsets.only(left: 20.0, top: 20),
                            child: TextButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.white)
                              ),
                              onPressed: 
                            () {
                              Navigator.pushNamed(context, 'loginUser');
                            }, child: 
                                const  Text('Voltar',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),),   
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 60.0, top: 20),
                            child: TextButton(
                              style:  const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.white)
                              ),
                              onPressed: 
                            () {
                              Navigator.push(context,
                               MaterialPageRoute(builder: (context) => enderecoUser(
                                Usuario: usuario,
                                Senha: senha,
                                Email: email,
                                Telefone: telefone,
                                Nome: nome,
        
                               )));
                            }, child: 
                                const  Text('Próximo',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),),   
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}