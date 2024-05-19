import 'package:flutter/material.dart';
import 'package:lojapflutter/screens/menu/bolsaScreen.dart';
import 'package:lojapflutter/screens/menu/listaScreen.dart';
import 'package:lojapflutter/screens/menu/pedidos/formaPagar.dart';
import 'package:lojapflutter/screens/menu/pedidosScreen.dart';
import 'package:lojapflutter/screens/menu/perfilScreen.dart';
import 'package:lojapflutter/screens/teladeLogin/loginUser.dart';
import 'package:lojapflutter/screens/teladeLogin/teladeCadastro/cadastroUser.dart';
import 'package:lojapflutter/screens/homepage.dart';
import 'package:lojapflutter/screens/joias/anOuroScreen.dart';
import 'package:lojapflutter/screens/joias/anelNoivScreen.dart';
import 'package:lojapflutter/screens/joias/anelPrataScreen.dart';
import 'package:lojapflutter/screens/joias/braceletePanScreen.dart';
import 'package:lojapflutter/screens/joias/braceletePretoScreen.dart';
import 'package:lojapflutter/screens/joias/colarAzulScreen.dart';
import 'package:lojapflutter/screens/joias/colarCoracaoScreen.dart';
import 'package:lojapflutter/screens/joias/colarOuroScreen.dart';
import 'package:lojapflutter/screens/joias/colarPersoScreen.dart';
import 'package:lojapflutter/screens/joias/colarPrataScreen.dart';
import 'package:lojapflutter/screens/teladeLogin/teladeCadastro/enderecoUser.dart';
import 'package:mysql_client/mysql_client.dart';

class App_widget extends StatefulWidget {
  const App_widget({super.key});

  @override
  State<App_widget> createState() => _App_widgetState();
}

class _App_widgetState extends State<App_widget> {

  /*Future getConnection() async {
    conn = await MySQLConnection.createConnection(
      host: '10.0.2.2',
      port: 3306,
      userName: 'root',
      password: 'kinafox223',
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
  }*/

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.blueAccent
          )
        )
      ),
      initialRoute: 'loginUser',
      routes: {
        'formaPagar':(context) => const formaPagar(
          IDU: '', 
          ProdutoID: '', 
          ProdutoN: '', 
          ProdutoP: 0, 
          ProdutoE: '', 
          Usuario: '', 
          EmailU: '', 
          TelefoneU: '', 
          NomeU: '', 
          BairroU: '', 
          AvRuaU: '', 
          NumeroU: '', 
          CEPU: '', 
          freteG: [], 
          count: 0),
        'perfilScreen':(context) => const perfilScreen(
          IDU: '', 
          Usuario: '', 
          EmailU: '', 
          TelefoneU: '', 
          NomeU: '', 
          BairroU: '', 
          AvRuaU: '', 
          NumeroU: '', 
          CEPU: '', 
          freteG: [], 
          count: 0),
        'listaScreen':(context) => const listaScreen(
          IDU: '', 
          ProdutoID: '', 
          ProdutoN: '', 
          ProdutoP: 0, 
          ProdutoE: '', 
          Usuario: '', 
          EmailU: '', 
          TelefoneU: '', 
          NomeU: '', 
          BairroU: '', 
          AvRuaU: '', 
          NumeroU: '', 
          CEPU: '', 
          freteG: [], 
          count: 0),
        'bolsaScreen':(context) => const bolsaScreen(
          IDU: '',
          ProdutoID: '',
          ProdutoN: '',
          ProdutoE: '',
          ProdutoP: 0,
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'pedidos':(context) => const Pedidos(
          IDU: '',
          ProdutoID: '',
          ProdutoN: '',
          ProdutoE: '',
          ProdutoP: 0,
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'loginUser':(context) => const loginUser(),
        'cadastroUser':(context) => const cadastroUser(),
        'enderecoUser':(context) => const enderecoUser(
          Email: '',
          Nome: '',
          Senha: '',
          Telefone: '',
          Usuario: '',
        ),
        'homepage':(context) => const Homepage(
          IDU: '',
          ProdutoID: '',
          ProdutoN: '',
          ProdutoP: 0,
          ProdutoE: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'AnOuroScreen':(context) => const AnOuroScreen(
          IDU: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'anelNoivScreen':(context) => const anelNoivScreen(
          IDU: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'anelPrataScreen':(context) => const anelPrataScreen(
           IDU: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'braceletePanScreen':(context) => const braceletePanScreen(
           IDU: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'braceletePretoScreen':(context) => const braceletePretoScreen(
          IDU: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'colarAzulScreen':(context) => const colarAzulScreen(
          IDU: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'colarCoracaoScreen':(context) => const colarCoracaoScreen(
          IDU: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'colarOuroScreen':(context) => const colarOuroScreen(
          IDU: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'colarPersoScreen':(context) => const colarPersoScreen(
          IDU: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
        'colarPrataScreen':(context) => const colarPrataScreen(
          IDU: '',
          Usuario: '',
          EmailU: '',
          TelefoneU: '',
          NomeU: '',
          BairroU: '',
          AvRuaU: '',
          NumeroU: '',
          CEPU: '',
          freteG: [],
          count: 0,
        ),
      },
      
    );
  }
}