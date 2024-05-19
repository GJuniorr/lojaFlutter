import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:lojapflutter/screens/menu/bolsaScreen.dart';
import 'package:lojapflutter/screens/menu/listaScreen.dart';
import 'package:lojapflutter/screens/menu/pedidosScreen.dart';
import 'package:lojapflutter/screens/menu/perfilScreen.dart';
import 'package:mysql_client/mysql_client.dart';

class Homepage extends StatefulWidget {

    final String? IDU;
    final String? ProdutoID;
    final String? ProdutoN;
    final double? ProdutoP;
    final String? ProdutoE;
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

   const Homepage( {
    super.key, 
    required this.IDU,
    required this.ProdutoID,
    required this.ProdutoN,
    required this.ProdutoP,
    required this.ProdutoE, 
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
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

    int? count;
    String? IDU;
    String? Usuario;
    String? ProdutoID;
    String? ProdutoN;
    double? ProdutoP;
    String? ProdutoE;
    String? EmailU;
    String? TelefoneU;
    String? NomeU;
    String? BairroU;
    String? AvRuaU;
    String? NumeroU;
    String? CEPU;
    List freteG = [];

  List<Map<String, String>> dados = [];
  late MySQLConnection conn;

  bool readNome = false;

  var res = '';
  var targetId = '';

  @override
  void initState() {
    super.initState();
    getConnection();
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
    count = widget.count!;
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
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }


    await BolsaSelect();
    setState(() {
      
    });
    //await conn.close();
  }

  Future BolsaSelect() async {
      var resultadoBS = await conn.execute("SELECT * FROM bolsa WHERE ID_Usuario = '$IDU' ");
     
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

  Future Produtos(String ProdutoN) async {

      var resultado = await conn.execute("SELECT * FROM produtos WHERE Nome = '$ProdutoN' ");


      for (var element in resultado.rows) {
        Map data = element.assoc();
        ProdutoID = data['ID_Produto'];
        ProdutoN = data['Nome'];
        ProdutoP = double.tryParse(data['Preço'])!;
        ProdutoE = data['Estoque'];
          }
          setState(() {
            
          });
  }



  
  int selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
   switch(selectIndex){

    case 0:
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
        )));
    break;

    

    case 1:
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

    case 2:
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

   case 3:
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade100,
        title: 
             const Text('JoiasTeens'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 20),
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
                  setState(() {
                    BolsaSelect();
                  });
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
        ),
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
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        //borderRadius: BorderRadius.circular(8.0),
                        // ignore: sized_box_for_whitespace
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                            height: 170,
                            width: 130,
                            //color: Colors.white,
                            child: Column(
                              children: [
                                     GestureDetector(
                                      onTap: () {
                                        ProdutoN = 'Aliança de Ouro';
                                          Produtos(ProdutoN!);
                                          print(' NOME: $ProdutoN. PREÇO: $ProdutoP. ESTOQUE: $ProdutoE ');
                                        //Produtos(ProdutoN!);
                                        Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => AnOuroScreen(
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
                                        print('Usuario é $Usuario, Email é $EmailU, ID é $IDU. $freteG. O bairro é $BairroU');
                                      },
                                      child: Image.asset('assets/images/alianOuro.png'),
                                    ),
                                    const Text('Aliança de Ouro',),
                                    const Text('R\$ 120',)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: SizedBox(
                          height: 170,
                          width: 130,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => anelNoivScreen(
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
                                },
                                child: Image.asset('assets/images/anelNoivado.png'),
                              ),
                              const Text('Anel de Noivado'),
                              const Text('R\$ 200')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: SizedBox(
                              height: 170,
                              width: 130,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                       Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => anelPrataScreen(
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
                                          )
                                          )
                                       );
                                    },
                                    child: Image.asset('assets/images/anelPrata.png'),
                                  ),
                                  const Text('Anel de Prata'),
                                  const Text('R\$ 80')
                                ],
                              ),
                            ),
                          ),
                          Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: SizedBox(
                          height: 170,
                          width: 130,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => braceletePanScreen(
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
                                          )
                                          )
                                       );
                                },
                                child: Image.asset('assets/images/braceletePan.png'),
                              ),
                              const Text('Bracelete de ouro'),
                              const Text('R\$ 100')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: SizedBox(
                              height: 170,
                              width: 130,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => braceletePretoScreen(
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
                                          )
                                          )
                                       );
                                    },
                                    child: Image.asset('assets/images/braceletePreto.png'),
                                  ),
                                  const Text('Bracelete de Prata'),
                                  const Text('R\$ 60')
                                ],
                              ),
                            ),
                          ),
                          Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: SizedBox(
                          height: 170,
                          width: 130,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                 Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => colarAzulScreen(
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
                                          )
                                          )
                                       );
                                },
                                child: Image.asset('assets/images/colarAzul.png'),
                              ),
                              const Text('Colar Azul'),
                              const Text('R\$ 75')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: SizedBox(
                              height: 170,
                              width: 130,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => colarCoracaoScreen(
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
                                          )
                                          )
                                       );
                                    },
                                    child: Image.asset('assets/images/colarCoracao.png'),
                                  ),
                                  const Text('Colar coração'),
                                  const Text('R\$ 79,99')
                                ],
                              ),
                            ),
                          ),
                          Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: SizedBox(
                          height: 170,
                          width: 130,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => colarOuroScreen(
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
                                          )
                                          )
                                       );
                                },
                                child: Image.asset('assets/images/colarOuro.png'),
                              ),
                              const Text('Colar de Ouro'),
                              const Text('R\$ 99,99')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: SizedBox(
                              height: 170,
                              width: 130,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                       Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => colarPersoScreen(
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
                                          )
                                          )
                                       );
                                    },
                                    child: Image.asset('assets/images/colarPerso.png'),
                                  ),
                                  const Text('Colar personalizado'),
                                  const Text('R\$ 65')
                                ],
                              ),
                            ),
                          ),
                          Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: SizedBox(
                          height: 170,
                          width: 130,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                   Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => colarPrataScreen(
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
                                          )
                                          )
                                       );
                                },
                                child: Image.asset('assets/images/colarPrata.png'),
                              ),
                              const Text('Colar de Prata'),
                              const Text('R\$ 60')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}