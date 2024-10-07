import 'package:flutter/material.dart';
import 'package:lojapflutter/screens/homepage.dart';
import 'package:lojapflutter/screens/menu/bolsaScreen.dart';
import 'package:lojapflutter/screens/menu/listaScreen.dart';
import 'package:lojapflutter/screens/menu/pedidosScreen.dart';
import 'package:lojapflutter/screens/menu/perfilScreen.dart';
import 'package:mysql_client/mysql_client.dart';

class anelPrataScreen extends StatefulWidget {

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

  const anelPrataScreen({
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
    required this.count,});

  @override
  State<anelPrataScreen> createState() => _anelPrataScreenState();
}

class _anelPrataScreenState extends State<anelPrataScreen> {

   int? count;
   int ProdutoQ = 0;
   String ProdutoID = '';
   String ProdutoN = 'Anel de Prata';
   double ProdutoP = 0;
   String ProdutoE = '';
   double frete = 10.00;

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
       host: '',
        port: ,
        userName: '',
        password: '',
      databaseName: 'apploja',
    );
    try {
      await conn.connect();
      print('Conexão bem sucedida');
      await Produtos(ProdutoN);
      setState(() {
        
      });
      print('Inicio de tudo: $ProdutoID, $ProdutoN, $ProdutoP, $ProdutoE. Agora a QTD $ProdutoQ');
      
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
    //await entrarUser();
    //await conn.close();
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
  }
    //await entrarUser();
    //await conn.close();

  Future BolsaTeste() async{

      final Map<String, dynamic> parametrosB = {'IDU': IDU, 'Usuario': Usuario, 'ProdutoID': ProdutoID, 'Produto': ProdutoN, 'ProdutoQ': ProdutoQ, 'ProdutoP': ProdutoP, 'ProdutoE': ProdutoE};

       var resultadoTeste = await conn.execute(
      "SELECT * FROM bolsa WHERE ID_Usuario = :IDU AND ID_Produto = :ProdutoID", parametrosB);

      for (var element in resultadoTeste.rows) {
        Map data = element.assoc();
        IDU = data['ID_Usuario'];
        Usuario = data['Usuario'];
        ProdutoQ = int.tryParse(data['Quantidade'] ?? '0') ?? 0;
      }
      print('A quantidade do Produto AGORA AGORA é: $ProdutoQ');

  }


  Future Bolsa(String IDU, String ProdutoID, String Usuario, String ProdutoN, ProdutoQ, double ProdutoP, String ProdutoE) async {

      final Map<String, dynamic> parametrosB = {'IDU': IDU, 'Usuario': Usuario, 'ProdutoID': ProdutoID, 'Produto': ProdutoN, 'ProdutoQ': ProdutoQ, 'ProdutoP': ProdutoP, 'ProdutoE': ProdutoE};

       var resultadoTeste = await conn.execute(
      "SELECT * FROM bolsa WHERE ID_Usuario = :IDU AND ID_Produto = :ProdutoID", parametrosB);

      for (var element in resultadoTeste.rows) {
        Map data = element.assoc();
        IDU = data['ID_Usuario'];
        Usuario = data['Usuario'];
        ProdutoQ = int.tryParse(data['Quantidade'] ?? '0') ?? 0;
      }

        print('Antes do IF: $ProdutoQ');

        var resultadoB = await conn.execute(
        "SELECT * FROM bolsa WHERE ID_Usuario = :IDU AND ID_Produto = :ProdutoID",parametrosB,);

      try {
         if (resultadoB.numOfRows > 0){
          ProdutoQ = ProdutoQ + 1;
        await conn.execute("UPDATE bolsa SET Quantidade = Quantidade + 1 WHERE ID_Usuario = :IDU AND ID_Produto = :ProdutoID",
        parametrosB);
        setState(() {
          ProdutoQ;
        });
        print('Quantidade adicionada com sucesso. $ProdutoQ');
      }else{
        await conn.execute("INSERT INTO bolsa (ID_Usuario, Usuario, ID_Produto, Produto, Preço, Estoque) VALUES (:IDU, :Usuario, :ProdutoID, :Produto, :ProdutoP, :ProdutoE)", parametrosB);
        setState(() {
          
        });
        print('Valor inserido com sucesso. Valor agora: $ProdutoQ');
      }
      } catch (e) {
        print('Algo deu errado $e');
      }


      var countAffectd = resultadoB.affectedRows;
      int countAffectdInt = countAffectd.toInt();
      try {
        if(countAffectdInt > 0){
        //print('Valor inserido com sucesso. $IDU, $Usuario, $ProdutoID, $ProdutoN');
        }else{
          //print('Erro ao inserir');
        }
      } catch (e) {
        print('Erro ao inserir valor $e');
      }



      setState(() {
        ProdutoQ;
      });

      for (var element in resultadoB.rows) {
        Map data = element.assoc();
        IDU = data['ID_Usuario'];
        Usuario = data['Usuario'];
        ProdutoQ = int.tryParse(data['Quantidade'] ?? '0') ?? 0;
          }
          setState(() {
            ProdutoQ;
          });
          print('Quantidade agora é: $ProdutoQ');

    
  }

  Future BolsaSelect() async {
      var resultadoBS = await conn.execute("SELECT * FROM bolsa WHERE ID_Usuario = '$IDU' ");
     
     setState(() {
       count = resultadoBS.numOfRows;
      print('Contagem nada a ver $count');
     });
      

      for (var element in resultadoBS.rows) {
        Map data = element.assoc();
        ProdutoID = data['ID_Produto'];
        Usuario = data['Usuario'];
        ProdutoN = data['Produto'];
        ProdutoP = double.tryParse(data['Preço'])!;
        ProdutoE = data['Estoque'];
          }
          
  }


  Future Lista(String IDU, String Usuario, String ProdutoID, String ProdutoN, double ProdutoP, String ProdutoE) async {

      final Map<String, dynamic> parametrosL = {'IDU': IDU, 'Usuario': Usuario, 'ProdutoID': ProdutoID, 'Produto': ProdutoN, 'ProdutoP': ProdutoP, 'ProdutoE': ProdutoE};
      var resultadoL = await conn.execute("INSERT INTO lista (ID_Usuario, Usuario, ID_Produto, Produto, Preço, Estoque) VALUES (:IDU, :Usuario, :ProdutoID, :Produto, :ProdutoP, :ProdutoE)", parametrosL);

      for (var element in resultadoL.rows) {
        Map data = element.assoc();
        Usuario = data['Usuario'];
        ProdutoN = data['Produto'];
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
    print('O produto é $ProdutoN, preço: $ProdutoP, estoque: $ProdutoE');
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
        break;


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
  int bagValueanelPrata = 0;

  int selectIndexanelPrata = 0;

  int selectedIndexStarOanelPrata = 0;

  int avlStarOanelPrata = 0;

  List starOanelPrata = List.generate(5, (index) => false);



  @override
  Widget build(BuildContext context) {

    double valorTotal = ProdutoP + frete;

    return Scaffold(
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
        currentIndex: selectIndexanelPrata,
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
        scrollDirection: Axis.horizontal,
      
          child: Row(
              children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 0, left: 0),
                   child: Column(
                     children: [
                       SizedBox(
                        height: 207,
                        child: Image.asset('assets/images/anelPrata.png')),
                        Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                              height: 308,
                              width: 235,
                              color: Colors.blueAccent,
                              child: const Text('Forjada com precisão e qualidade, este Anel de Prata é projetada para resistir ao desgaste diário e manter sua beleza ao longo do tempo.Sua forma ergonômica e suavemente arredondada garante um ajuste confortável ao redor do dedo, permitindo o uso prolongado sem irritação.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 15
                              )),
                            ),
                          ),
                     ],
                   ),
                 ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Container(
                        color: Colors.blueAccent,
                        height: 600,
                        width: 176,
                        child: Column(
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, right: 0),
                          child: Text(ProdutoN,
                          style: const TextStyle(fontSize: 20)),
                        ), 
                        const SizedBox(height: 5,),

                          Text('R\$ $ProdutoP',
                         style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreenAccent
                         ),),

                          if (freteG.contains(BairroU))
                            const Text('Frete: Grátis',
                         style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreenAccent
                         ),
                         )

                          else
                           Column(
                            children: [
                              Text('Frete: R\$ $frete',
                              style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreenAccent
                            ),
                            ),
                            
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Valor total: R\$ $valorTotal',
                         style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreenAccent
                         ),),
                          const SizedBox(
                            height: 5,
                          ),

                            Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 0.0),
                                child: Text('${avlStarOanelPrata + 1.0}',
                                style: const TextStyle(fontSize: 16,)
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 0.0),
                                child: Icon(Icons.star,
                                color: Colors.yellow,),
                              )
                        ],
                                          ),
                                          Row(
                                //mainAxisSize: MainAxisSize.min,
                                children: List.generate(5, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: SizedBox(
                                      width: 30,
                                      child: IconButton(
                                        onPressed:() {
                                          setState(() {
                                            selectedIndexStarOanelPrata = index;
                                            starOanelPrata[index] = !starOanelPrata[index];
                                            for (int i = 0; i < starOanelPrata.length; i++) {
                                                    starOanelPrata[i] = i <= index;
                                                  }
                                          });
                                        }, icon: Icon(Icons.star,
                                        color: starOanelPrata[index] ? Colors.yellow : Colors.grey,)),
                                    ),
                                  );
                                }),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              FloatingActionButton.extended(
                                heroTag: null,
                                onPressed: () {
                                  setState(() {
                                    avlStarOanelPrata = selectedIndexStarOanelPrata;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Avaliação confirmada',
                                          textAlign: TextAlign.center,),
                                          content: Text('Sua avaliação foi: ${avlStarOanelPrata + 1.0}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              }, child: const Text('Fechar',
                                              style: TextStyle(color: Colors.blueAccent),))
                                          ],
                                        );
                                      });
                                  });
                              },
                              backgroundColor: Colors.lightBlue,
                              label: const Text('Avaliar',
                              style: TextStyle(fontSize: 15,
                              fontWeight: FontWeight.bold)
                              ),
                              ),
                             const SizedBox(height: 12,),
                              
                              if(ProdutoE == 'Disponível')
                               Text(ProdutoE,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreenAccent
                              ),
                              )

                              else
                              Text(ProdutoE,
                              style:  const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 143, 11, 30)
                              ),
                              ),

                              const SizedBox(
                                height: 12,
                              ),
                              
                              SizedBox(
                                width: 140,
                                child: FloatingActionButton.extended(
                                  heroTag: null,
                                  onPressed: () {
                                    Bolsa(IDU!, ProdutoID, Usuario!, ProdutoN, ProdutoQ, ProdutoP, ProdutoE);
                                    BolsaSelect();
                                    BolsaTeste();
                                    setState(() {
                                      ProdutoQ;
                                      count;
                                    });
                                },
                                backgroundColor: Colors.lightBlue,
                                
                                label: const Text('Adicionar a bolsa',
                                style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold)
                                ),
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              
                              SizedBox(
                                width: 140,
                                child: FloatingActionButton.extended(
                                  heroTag: null,
                                  onPressed: () {
                                    setState(() {
                                      Lista(IDU!, Usuario!, ProdutoID, ProdutoN, ProdutoP, ProdutoE );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                            title: const Text('Item adicionado a Lista',
                                            textAlign: TextAlign.center),
                                            actions: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    }, child: const Text('Fechar',
                                                    style: TextStyle(
                                                      color: Colors.white
                                                    ))),
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                    });
                                },
                                backgroundColor: Colors.lightBlue,
                                
                                label: const Text('Adicionar a Lista',
                                style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold)
                                ),
                                ),
                              ),
                                      ],
                                    ),
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


  
