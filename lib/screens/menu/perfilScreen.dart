import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lojapflutter/screens/homepage.dart';
import 'package:lojapflutter/screens/menu/bolsaScreen.dart';
import 'package:lojapflutter/screens/menu/listaScreen.dart';
import 'package:lojapflutter/screens/menu/pedidosScreen.dart';
import 'package:mysql_client/mysql_client.dart';

class perfilScreen extends StatefulWidget {

    final String? IDU;
    final String? Usuario;
    final String? EmailU;
    final String? TelefoneU;
    final String? NomeU;
    final String? BairroU;
    final String? AvRuaU;
    final String? NumeroU;
    final String? CEPU;
    final List freteG;
    final int? count;

  const perfilScreen({
    super.key, 
    required this.IDU, 
    required this.Usuario, 
    required this.EmailU, 
    required this.TelefoneU, 
    required this.NomeU, 
    required this.BairroU, 
    required this.AvRuaU, 
    required this.NumeroU, 
    required this.CEPU, 
    required this.freteG,
    required this.count,
    });

  @override
  State<perfilScreen> createState() => _perfilScreenState();
}



class _perfilScreenState extends State<perfilScreen> {

   int? count;
   String ProdutoID = '';
   String ProdutoN = 'Aliança de Ouro';
   double ProdutoP = 0;
   String ProdutoE = '';
   double frete = 10.00;
   String SenhaU = '';

  String PedidoN = '';

  late MySQLConnection conn;

  

   @override
  void initState() {
    super.initState();
    getConnection();
    //Produtos(ProdutoN);
    
    IDU = widget.IDU!;
    Usuario = widget.Usuario!;
    EmailU = widget.EmailU!;
    TelefoneU = widget.TelefoneU!;
    NomeU = widget.NomeU!;
    BairroU = widget.BairroU!;
    AvRuaU = widget.AvRuaU!;
    NumeroU = widget.NumeroU!;
    CEPU = widget.CEPU!;
    freteG = widget.freteG;
    count = widget.count;
  }


  Future getConnection() async {
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
      setState(() {
        
      });
       print('Conexão bem sucedida. ID: $IDU. Usuario: $Usuario. Senha: $SenhaU. Email: $EmailU. Telefone: $TelefoneU. Nome: $NomeU');
      
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
    await SelectUsuario();
    //await conn.close();
  }

  Future SelectUsuario() async{

    var resultadoSU = await conn.execute("SELECT * FROM usuarios WHERE ID_Usuario = '$IDU' ");

    for (var element in resultadoSU.rows) {
        Map data = element.assoc();
        IDU = data['ID_Usuario'];
        Usuario = data['Usuario'];
        SenhaU = data['Senha'];
        EmailU = data['Email'];
        TelefoneU = data['Telefone'];
        NomeU = data['Nome'];
        BairroU = data['Bairro'];
        AvRuaU = data['AvRua'];
        NumeroU = data['Numero'];
        CEPU = data['CEP'];
          }
  }

   Future UpdateContaU()async{

    try {
    //final Map<String, dynamic> parametrosUC = {'Usuario': Usuario, 'Senha': SenhaU, 'Email': EmailU, 'Telefone': TelefoneU, 'Nome': NomeU};

      final Map<String, dynamic> parametrosUCU = {'Usuario': Usuario, 'ID_Usuario': IDU};

    var update = await conn.execute(
      'UPDATE usuarios SET Usuario = :Usuario WHERE ID_Usuario = :ID_Usuario', 
      {
        'Usuario': Usuario,
        'ID_Usuario':IDU
      },);
    print(update.affectedRows);
    await conn.execute('COMMIT');
    print('Usuario atualizado com sucesso');
  } catch (e) {
    print('Erro ao atualizar Usuario: $e. Usuario que iria ser modificado $Usuario');
  }

  }

  Future UpdateContaS()async{

    try {
    //final Map<String, dynamic> parametrosUC = {'Usuario': Usuario, 'Senha': SenhaU, 'Email': EmailU, 'Telefone': TelefoneU, 'Nome': NomeU};

      final Map<String, dynamic> parametrosUCS = {'SenhaU': SenhaU, 'ID_Usuario': IDU};

    var update = await conn.execute(
      'UPDATE usuarios SET Senha = :SenhaU WHERE ID_Usuario = :ID_Usuario', 
      {
        'SenhaU': SenhaU,
        'ID_Usuario':IDU
      },);
    print(update.affectedRows);
    await conn.execute('COMMIT');
    print('Senha atualizada com sucesso. Senha nova $SenhaU');
  } catch (e) {
    print('Erro ao atualizar Senha: $e. Senha que iria ser modificado $SenhaU');
  }

  }

  Future UpdateContaN()async{

    try {
    //final Map<String, dynamic> parametrosUC = {'Usuario': Usuario, 'Senha': SenhaU, 'Email': EmailU, 'Telefone': TelefoneU, 'Nome': NomeU};

      final Map<String, dynamic> parametrosUCN = {'NomeU': NomeU, 'ID_Usuario': IDU};

    var update = await conn.execute(
      'UPDATE usuarios SET NomeU = :NomeU WHERE ID_Usuario = :ID_Usuario', 
      {
        'NomeU': NomeU,
        'ID_Usuario':IDU
      },);
    print(update.affectedRows);
    await conn.execute('COMMIT');
    print('Nome atualizado com sucesso. Novo Nome: $NomeU');
  } catch (e) {
    print('Erro ao atualizar Nome: $e. Nime que iria ser modificado $NomeU');
  }

  }


  Future UpdateContaE()async{

    try {
    //final Map<String, dynamic> parametrosUC = {'Usuario': Usuario, 'Senha': SenhaU, 'Email': EmailU, 'Telefone': TelefoneU, 'Nome': NomeU};

      final Map<String, dynamic> parametrosUCE = {'EmailU': EmailU, 'ID_Usuario': IDU};

    var update = await conn.execute(
      'UPDATE usuarios SET Email = :EmailU WHERE ID_Usuario = :ID_Usuario', 
      {
        'EmailU': EmailU,
        'ID_Usuario':IDU
      },);
    print(update.affectedRows);
    await conn.execute('COMMIT');
    print('Email atualizado com sucesso. Novo Email $EmailU');
  } catch (e) {
    print('Erro ao atualizar Email: $e. Email que iria ser modificado $EmailU');
  }

  }

  Future UpdateContaT()async{

    try {
    //final Map<String, dynamic> parametrosUC = {'Usuario': Usuario, 'Senha': SenhaU, 'Email': EmailU, 'Telefone': TelefoneU, 'Nome': NomeU};

      final Map<String, dynamic> parametrosUCT = {'TelefoneU': TelefoneU, 'ID_Usuario': IDU};

    var update = await conn.execute(
      'UPDATE usuarios SET TelefoneU = :TelefoneU WHERE ID_Usuario = :ID_Usuario', 
      {
        'TelefoneU': TelefoneU,
        'ID_Usuario':IDU
      },);
    print(update.affectedRows);
    await conn.execute('COMMIT');
    print('Telefone atualizado com sucesso. Novo Telefone $TelefoneU');
  } catch (e) {
    print('Erro ao atualizar Telefone: $e. Telefone que iria ser modificado $TelefoneU');
  }

  }

  Future UpdateContaB()async{

    try {
    //final Map<String, dynamic> parametrosUC = {'Usuario': Usuario, 'Senha': SenhaU, 'Email': EmailU, 'Telefone': TelefoneU, 'Nome': NomeU};

      final Map<String, dynamic> parametrosUCB = {'BairroU': BairroU, 'ID_Usuario': IDU};

    var update = await conn.execute(
      'UPDATE usuarios SET BairroU = :BairroU WHERE ID_Usuario = :ID_Usuario', 
      {
        'BairroU': BairroU,
        'ID_Usuario':IDU
      },);
    print(update.affectedRows);
    await conn.execute('COMMIT');
    print('Bairro atualizado com sucesso. Novo Bairro $BairroU');
  } catch (e) {
    print('Erro ao atualizar Bairro: $e. Bairro que iria ser modificado $BairroU');
  }

  }

  Future UpdateContaAv()async{

    try {
    //final Map<String, dynamic> parametrosUC = {'Usuario': Usuario, 'Senha': SenhaU, 'Email': EmailU, 'Telefone': TelefoneU, 'Nome': NomeU};

      final Map<String, dynamic> parametrosUCAV = {'AvRuaU': AvRuaU, 'ID_Usuario': IDU};

    var update = await conn.execute(
      'UPDATE usuarios SET AvRuaU = :AvRuaU WHERE ID_Usuario = :ID_Usuario', 
      {
        'AvRuaU': AvRuaU,
        'ID_Usuario':IDU
      },);
    print(update.affectedRows);
    await conn.execute('COMMIT');
    print('AvRua atualizado com sucesso. Novo AvRua $AvRuaU');
  } catch (e) {
    print('Erro ao atualizar AvRua: $e. AvRua que iria ser modificado $AvRuaU');
  }

  }

   Future UpdateContaNum()async{

    try {
    //final Map<String, dynamic> parametrosUC = {'Usuario': Usuario, 'Senha': SenhaU, 'Email': EmailU, 'Telefone': TelefoneU, 'Nome': NomeU};

      final Map<String, dynamic> parametrosUCAV = {'NumeroU': NumeroU, 'ID_Usuario': IDU};

    var update = await conn.execute(
      'UPDATE usuarios SET NumeroU = :NumeroU WHERE ID_Usuario = :ID_Usuario', 
      {
        'NumeroU': NumeroU,
        'ID_Usuario':IDU
      },);
    print(update.affectedRows);
    await conn.execute('COMMIT');
    print('Numero atualizado com sucesso. Novo Numero $NumeroU');
  } catch (e) {
    print('Erro ao atualizar Numero: $e. Numero que iria ser modificado $NumeroU');
  }

  }

  Future UpdateContaCEP()async{

    try {
    //final Map<String, dynamic> parametrosUC = {'Usuario': Usuario, 'Senha': SenhaU, 'Email': EmailU, 'Telefone': TelefoneU, 'Nome': NomeU};

      final Map<String, dynamic> parametrosUCEP = {'CEPU': CEPU, 'ID_Usuario': IDU};

    var update = await conn.execute(
      'UPDATE usuarios SET CEPU = :CEPU WHERE ID_Usuario = :ID_Usuario', 
      {
        'CEPU': CEPU,
        'ID_Usuario':IDU
      },);
    print(update.affectedRows);
    await conn.execute('COMMIT');
    print('CEP atualizado com sucesso. Novo CEP $CEPU');
  } catch (e) {
    print('Erro ao atualizar CEP: $e. CEP que iria ser modificado $CEPU');
  }

  }


  String? IDU;
  String? Usuario;
  String? EmailU;
  String? TelefoneU;
  String? NomeU;
  String? BairroU;
  String? AvRuaU;
  String? NumeroU;
  String? CEPU;
  List freteG = [];
  
  int bagValue = 0;

  int selectIndex = 0;

  int selectedIndexStarO = 0;

  int avlStarO = 0;

  List starO = List.generate(5, (index) => false);

  

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
   switch(selectIndex){
    case 0:
    //print('O Usuario é $Usuario, O Email é $EmailU, O ID é $IDU. FreteG é $freteG. Bairro é $BairroU');
    print('ID: $IDU. $Usuario é: $Usuario. Senha é: $SenhaU. Email é: $EmailU. Telefone é: $TelefoneU. Nome é: $NomeU');
    Navigator.push(context,
       MaterialPageRoute(builder: (context) => Homepage(
        IDU: IDU,
        ProdutoID: ProdutoID,
        ProdutoN: ProdutoN,
        ProdutoP: ProdutoP,
        ProdutoE: ProdutoE,
        Usuario: Usuario,
        EmailU: EmailU,
        TelefoneU: TelefoneU,
        NomeU: NomeU,
        BairroU: BairroU,
        AvRuaU: AvRuaU,
        NumeroU: NumeroU,
        CEPU: CEPU,
        freteG: freteG,
        count: count,
        ),
        ),
        );
    break;

    case 1:
    Navigator.pushNamed(context, 'anelNoivScreen');

    case 2:
    Navigator.push(context,
       MaterialPageRoute(builder: (context) => Pedidos(
        IDU: IDU,
        ProdutoID: ProdutoID,
        ProdutoN: ProdutoN,
        ProdutoP: ProdutoP,
        ProdutoE: ProdutoE,
        Usuario: Usuario,
        EmailU: EmailU,
        TelefoneU: TelefoneU,
        NomeU: NomeU,
        BairroU: BairroU,
        AvRuaU: AvRuaU,
        NumeroU: NumeroU,
        CEPU: CEPU,
        freteG: freteG,
        count: count,
        )));
    break;

    case 3:
    Navigator.push(context,
       MaterialPageRoute(builder: (context) => perfilScreen(
        IDU: IDU,
        Usuario: Usuario,
        EmailU: EmailU,
        TelefoneU: TelefoneU,
        NomeU: NomeU,
        BairroU: BairroU,
        AvRuaU: AvRuaU,
        NumeroU: NumeroU,
        CEPU: CEPU,
        freteG: freteG,
        count: count,
        )));
        break;

   case 4:
    Navigator.push(context,
       MaterialPageRoute(builder: (context) => listaScreen(
        IDU: IDU,
        ProdutoID: ProdutoID,
        ProdutoN: ProdutoN,
        ProdutoP: ProdutoP,
        ProdutoE: ProdutoE,
        Usuario: Usuario,
        EmailU: EmailU,
        TelefoneU: TelefoneU,
        NomeU: NomeU,
        BairroU: BairroU,
        AvRuaU: AvRuaU,
        NumeroU: NumeroU,
        CEPU: CEPU,
        freteG: freteG,
        count: count,
        )));
    break;
   }
  }

  bool usuarioEdit = false;
  bool senhaInv = false;
  bool nomeEdit = false;
  bool emailEdit = false;
  bool telefoneEdit = false;

  bool bairroEdit = false;
  bool avRuaEdit = false;
  bool numeroEdit = false;
  bool cepEdit = false;


  @override
  Widget build(BuildContext context) {
    TextEditingController UsuarioController = TextEditingController(text: Usuario);
    TextEditingController SenhaController = TextEditingController(text: SenhaU);
    TextEditingController EmailController = TextEditingController(text: EmailU);
    TextEditingController TelefoneController = TextEditingController(text: TelefoneU);
    TextEditingController NomeController = TextEditingController(text: NomeU);
    TextEditingController BairroController = TextEditingController(text: BairroU);
    TextEditingController AvRuaController = TextEditingController(text: AvRuaU);
    TextEditingController NumeroController = TextEditingController(text: NumeroU);
    TextEditingController CEPController = TextEditingController(text: CEPU);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade100,
        title: const Text('JoiasTeens'),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
        fontSize: 20),
        leading:  IconButton(
          onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context){
              return  AlertDialog(
                title: const Text('Avaliação do Produto',
                textAlign: TextAlign.center,),
                actions: [
                  Column(
                    children: [
                      const Text('A nota ao lado da estrela amarela significa a média de avaliação que esse produto recebeu dos usuários. A média vai de 0.0 até 5.0\n\nPara avaliar o produto, você deve clicar na estrela que represente sua satisfação e depois clicar no botão "Avaliar".\n\nExemplo: Se sua satisfação com o produto for 1.0 clique na primeira estrela e depois em "Avaliar".\nSe for 2 estrelas clique na segunda estrela e depois em "Avaliar"'),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        children: [
                          Text('Ícone para clicar: '),
                      Icon(Icons.star,
                      color: Colors.grey,),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            }, child: const Text('Fechar',
                            style: TextStyle(color: Colors.white))),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: const Text('Ir até a bolsa',
                                      textAlign: TextAlign.center),
                                      actions: [
                                        Column(
                                          children: [
                                            const Text('Para ir até a bolsa, clique no ícone da bolsa que fica no canto SUPERIOR direito, ao lado do número que representa a quantidade de items que você adicionou ao carrinho'),
                                            const SizedBox(
                                              height: 8),
                                              const Row(
                                                children: [
                                                  Text('Ícone para clicar: '),
                                                  Icon(Icons.shopping_bag,
                                                  color: Colors.blueAccent,)
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TextButton(
                                                onPressed:() {
                                                  Navigator.of(context).pop();
                                                }, child: const Text('Fechar',
                                                style: TextStyle(color: Colors.white),)),
                                                TextButton(
                                                  onPressed: () {
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context){
                                                      return  AlertDialog(
                                                        title:
                                                            const Text('Navegação entre telas',
                                                            textAlign: TextAlign.center,),
                                                        
                                                        actions: [
                                                          Column(
                                                            children: [
                                                              const Text('Para navegar até uma tela, escolha um dos ícones presentes no canto inferior'),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                    }, child: const Text('Fechar',
                                                                    style: TextStyle(
                                                                      color: Colors.white
                                                                    ),)),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    });
                                                }, child: const Text('Próximo',
                                                style: TextStyle(color: Colors.white),))
                                                ],
                                              )
                                          ],
                                        )
                                      ],
                                    );
                                  });
                              }, child: const Text('Próximo',
                              style: TextStyle(
                                color: Colors.white
                              ),))
                        ],
                      ),
                    ],
                  )
                ],
              );
            });
          }, 

          icon: const Icon(Icons.help),
          iconSize: 30,),
       actions:  [
        Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: Row(
            children: [
               Text('$count',
              style: const TextStyle(fontSize: 20,
              color: Colors.blueAccent),),
             
               IconButton(
                onPressed: () {
                   print('O produto é $ProdutoN, preço: $ProdutoP, estoque: $ProdutoE');
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => bolsaScreen(
                        IDU: IDU,
                        ProdutoID: ProdutoID,
                        ProdutoN: ProdutoN,
                        ProdutoP: ProdutoP,
                        ProdutoE: ProdutoE,
                        Usuario: Usuario,
                        EmailU: EmailU,
                        TelefoneU: TelefoneU,
                        NomeU: NomeU,
                        BairroU: BairroU,
                        AvRuaU: AvRuaU,
                        NumeroU: NumeroU,
                        CEPU: CEPU,
                        freteG: freteG,
                        count: count,
                        ),
                        ),
                        );
                },
                icon: const Icon((Icons.shopping_bag),
                size: 30), 
           color: Colors.blueAccent,),
          
            ],
          ),
        )
       ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.blueAccent,
        unselectedFontSize: 14,
        backgroundColor: Colors.orange.shade100,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Pedidos'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',),
              BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',)
        ]
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Icon(Icons.person,
                size: 30,),
                const SizedBox(
                  height: 5,
                ),
                const Text('Informações da conta',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                ),
                const SizedBox(
                  height: 0,
                ),
                
                Row(
                  children: [
                   SizedBox(
                    height: 60,
                    width: 300,

                     child: TextField(
                            enabled: usuarioEdit,
                            controller: UsuarioController,
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueU) {
                              Usuario = valueU;
                            },
                            decoration:  const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              
                              labelText: 'Usuario',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                   ),
                     IconButton(
                  onPressed: () {
                    setState(() {
                      if (usuarioEdit) {
                        Usuario = UsuarioController.text;
                        UpdateContaU(); // Chama a função UpdateContaU se senhaInv for true
                        usuarioEdit = !usuarioEdit;
                      } else {
                        usuarioEdit = !usuarioEdit; // Alterna o valor de senhaInv se senhaInv for false
                      }
                    });
                  },
                  icon: Icon(
                    usuarioEdit ? Icons.check : Icons.edit,
                    size: 20,
                  ),
                ),
                Visibility(
                  visible: usuarioEdit,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        usuarioEdit = !usuarioEdit;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                  
                  Row(
                    children: [
                      if(senhaInv == true)
                      SizedBox(
                    height: 60,
                    width: 300,

                     child: TextField(
                            controller: SenhaController,
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueU) {
                              SenhaU = valueU;
                            },
                            decoration:  const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              
                              labelText: 'Senha',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                   )
                      else
                      const Text('Senha: ******',
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 15 
                      ),
                  ),
                 IconButton(
                  onPressed: () {
                    setState(() {
                      if (senhaInv) {
                        UpdateContaS();
                        senhaInv = !senhaInv;
                      } else {
                        senhaInv = !senhaInv; // Alterna o valor de senhaInv se senhaInv for false
                      }
                    });
                  },
                  icon: Icon(
                    senhaInv ? Icons.check : Icons.remove_red_eye,
                    size: 20,
                  ),
                ),
                 Visibility(
                  visible: senhaInv,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        senhaInv = !senhaInv;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                    ],
                  ),

                const SizedBox(
                  height: 12,
                ),

                Row(
                  children: [
                    SizedBox(
                    height: 60,
                    width: 300,

                     child: TextField(
                            enabled: nomeEdit,
                            controller: NomeController,
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueU) {
                              NomeU = valueU;
                            },
                            decoration:  const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              
                              labelText: 'Nome',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                   ),
                     IconButton(
                  onPressed: () {
                    setState(() {
                      if (nomeEdit) {
                        NomeU = NomeController.text;
                        UpdateContaN(); // Chama a função UpdateContaU se senhaInv for true
                        nomeEdit = !nomeEdit;
                      } else {
                        nomeEdit = !nomeEdit; // Alterna o valor de senhaInv se senhaInv for false
                      }
                    });
                  },
                  icon: Icon(
                    nomeEdit ? Icons.check : Icons.edit,
                    size: 20,
                  ),
                ),
                 Visibility(
                  visible: nomeEdit,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        nomeEdit = !nomeEdit;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                  ],
                ),
               
               const SizedBox(
                height: 12,
               ),
        
                Row(
                  children: [
                    SizedBox(
                    height: 60,
                    width: 300,

                     child: TextField(
                            enabled: emailEdit,
                            controller: EmailController,
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueU) {
                              EmailU = valueU;
                            },
                            decoration:  const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                   ),
                     IconButton(
                  onPressed: () {
                    setState(() {
                      if (emailEdit) {
                        EmailU = EmailController.text;
                        UpdateContaE(); // Chama a função UpdateContaU se senhaInv for true
                        emailEdit = !emailEdit;
                      } else {
                        emailEdit = !emailEdit; // Alterna o valor de senhaInv se senhaInv for false
                      }
                    });
                  },
                  icon: Icon(
                    nomeEdit ? Icons.check : Icons.edit,
                    size: 20,
                  ),
                ),
                 Visibility(
                  visible: emailEdit,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        emailEdit = !emailEdit;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                  ],
                ),
                
                const SizedBox(
                  height: 12,
                ),
        
                Row(
                  children: [
                     SizedBox(
                    height: 60,
                    width: 300,

                     child: TextField(
                            enabled: telefoneEdit,
                            controller: TelefoneController,
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueU) {
                              TelefoneU = valueU;
                            },
                            decoration:  const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              
                              labelText: 'Telefone',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                   ),
                     IconButton(
                  onPressed: () {
                    setState(() {
                      if (telefoneEdit) {
                        TelefoneU = TelefoneController.text;
                        UpdateContaT(); // Chama a função UpdateContaU se senhaInv for true
                        telefoneEdit = !telefoneEdit;
                      } else {
                        telefoneEdit = !telefoneEdit; // Alterna o valor de senhaInv se senhaInv for false
                      }
                    });
                  },
                  icon: Icon(
                    telefoneEdit ? Icons.check : Icons.edit,
                    size: 20,
                  ),
                ),
                 Visibility(
                  visible: telefoneEdit,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        telefoneEdit = !telefoneEdit;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),
               
                    const Text('Endereço',
                     style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                    ),

                    const SizedBox(
                  height: 12,
                ),
        
                Row(
                  children: [
                    SizedBox(
                    height: 60,
                    width: 300,

                     child: TextField(
                            enabled: bairroEdit,
                            controller: BairroController,
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueU) {
                              BairroU = valueU;
                            },
                            decoration:  const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              
                              labelText: 'Bairro',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                   ),
                     IconButton(
                  onPressed: () {
                    setState(() {
                      if (telefoneEdit) {
                        BairroU = BairroController.text;
                        UpdateContaB(); 
                        bairroEdit = !bairroEdit;
                      } else {
                        bairroEdit = !bairroEdit; 
                      }
                    });
                  },
                  icon: Icon(
                    bairroEdit ? Icons.check : Icons.edit,
                    size: 20,
                  ),
                ),
                 Visibility(
                  visible: bairroEdit,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        bairroEdit = !bairroEdit;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),
                
        
                Row(
                  children: [
                    SizedBox(
                    height: 60,
                    width: 300,

                     child: TextField(
                            enabled: avRuaEdit,
                            controller: AvRuaController,
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueU) {
                              AvRuaU = valueU;
                            },
                            decoration:  const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              
                              labelText: 'Av/Rua',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                   ),
                     IconButton(
                  onPressed: () {
                    setState(() {
                      if (avRuaEdit) {
                        AvRuaU = AvRuaController.text;
                        UpdateContaAv(); 
                        avRuaEdit = !avRuaEdit;
                      } else {
                        avRuaEdit = !avRuaEdit; 
                      }
                    });
                  },
                  icon: Icon(
                    avRuaEdit ? Icons.check : Icons.edit,
                    size: 20,
                  ),
                ),
                 Visibility(
                  visible: avRuaEdit,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        avRuaEdit = !avRuaEdit;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                  ],
                ),
               
               const SizedBox(
                  height: 12,
                ),
        
                Row(
                  children: [
                    SizedBox(
                    height: 60,
                    width: 300,

                     child: TextField(
                            enabled: numeroEdit,
                            controller: NumeroController,
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueU) {
                              NumeroU = valueU;
                            },
                            decoration:  const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              
                              labelText: 'Numero',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                   ),
                     IconButton(
                  onPressed: () {
                    setState(() {
                      if (numeroEdit) {
                        NumeroU = NumeroController.text;
                        UpdateContaNum(); 
                        numeroEdit = !numeroEdit;
                      } else {
                        numeroEdit = !numeroEdit; 
                      }
                    });
                  },
                  icon: Icon(
                   numeroEdit ? Icons.check : Icons.edit,
                    size: 20,
                  ),
                ),
                 Visibility(
                  visible: numeroEdit,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        numeroEdit = !numeroEdit;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                  ],
                ),
               
               const SizedBox(
                  height: 12,
                ),
                
                Row(
                  children: [
                    SizedBox(
                    height: 60,
                    width: 300,

                     child: TextField(
                            enabled: cepEdit,
                            controller: CEPController,
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueU) {
                              CEPU = valueU;
                            },
                            decoration:  const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              
                              labelText: 'CEP',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                   ),
                     IconButton(
                  onPressed: () {
                    setState(() {
                      if (cepEdit) {
                        CEPU = CEPController.text;
                        UpdateContaCEP(); 
                        cepEdit = !cepEdit;
                      } else {
                        cepEdit = !cepEdit; 
                      }
                    });
                  },
                  icon: Icon(
                   cepEdit ? Icons.check : Icons.edit,
                    size: 20,
                  ),
                ),
                 Visibility(
                  visible: cepEdit,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        cepEdit = !cepEdit;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
                  ],
                ),
                
                const SizedBox(
                  height: 12,
                ),

                const Text('Frete',
                 style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                ),
                

                if (freteG.contains(BairroU))
                            const Text('Grátis',
                         style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreenAccent
                         ),
                         )

                          else
                              Text('R\$ $frete',
                              style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreenAccent
                            ),
                            ),

                           
              ],
        ),
        ),
        ),
    );
  }
}