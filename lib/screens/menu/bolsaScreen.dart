import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojapflutter/screens/homepage.dart';
import 'package:lojapflutter/screens/menu/listaScreen.dart';
import 'package:lojapflutter/screens/menu/pedidos/formaPagar.dart';
import 'package:lojapflutter/screens/menu/pedidosScreen.dart';
import 'package:lojapflutter/screens/menu/perfilScreen.dart';
import 'package:mysql_client/mysql_client.dart';

class bolsaScreen extends StatefulWidget {

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

  const bolsaScreen({
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
  State<bolsaScreen> createState() => _BolsaScreenState();
}

class _BolsaScreenState extends State<bolsaScreen> {

  String? IDU = '';
  String? ProdutoID = '';
  String? ProdutoN = '';
  double? ProdutoP = 0;
  int? ProdutoQ = 0;
  String? ProdutoE = '';
  String? Usuario = '';
  String? EmailU = '';
  String? TelefoneU = '';
  String? NomeU = '';
  String? BairroU = '';
  String? AvRuaU = '';
  String? NumeroU = '';
  String? CEPU = '';
  List? freteG = [];
  int? count = 0;
  String? ProdutoNL = '';
  List<Map<String, String>> dados = [];


  @override
  void initState() {
    super.initState();
    getConnection();
    //Produtos(ProdutoN);
    
    IDU = widget.IDU!;
    ProdutoID = widget.ProdutoID;
    ProdutoN = widget.ProdutoN;
    ProdutoP = widget.ProdutoP;
    ProdutoE = widget.ProdutoE;
    Usuario = widget.Usuario;
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

  late MySQLConnection conn;


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
      print('Conexão bem sucedida. ID do produto é: $ProdutoID ID do Usuario é: $IDU. Nome do Produto: $ProdutoN. Preço do Produto: $ProdutoP. Estoque: $ProdutoE');
      //await BolsaSelect();
      setState(() {
        BolsaSelect();
      });

      
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
    //await entrarUser();
    //await conn.close();
  }

 Future BolsaSelect() async {
      var resultadoBS = await conn.execute("SELECT Produto, Quantidade, Preço, Estoque FROM bolsa WHERE ID_Usuario = '$IDU' ORDER BY Quantidade DESC");
     
      var resultadoBSS = await conn.execute("SELECT * FROM bolsa WHERE ID_Usuario = '$IDU' ");
     setState(() {
       count = resultadoBSS.numOfRows;
        print(count);
     });

      

      
    List<Map<String, String>> list = [];

    for (final row in resultadoBS.rows) {
      final data = {
        'Produto': row.colAt(0)!,
        'Quantidade': row.colAt(1)!,
        'Preço': row.colAt(2)!,
        'Estoque': row.colAt(3)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
        for (var element in resultadoBS.rows) {
        Map data = element.assoc();
        ProdutoQ = int.tryParse(data['Quantidade'] ?? '0') ?? 0;
          }
  }
    //await entrarUser();
    //await conn.close();

  Future AdicionarBolsa() async {

    var resultadoAB = await conn.execute(
      "UPDATE bolsa SET Quantidade = Quantidade + 1 WHERE ID_Usuario = '$IDU' AND ID_Produto = '$ProdutoID' ");
       await BolsaSelect();
      print('Quantidade adicionada e agora é: $ProdutoQ');
  }

  Future RemoverBolsa() async {
    
    var resultadoRB = await conn.execute(
      "UPDATE bolsa SET Quantidade = Quantidade - 1 WHERE ID_Usuario = '$IDU' AND ID_Produto = '$ProdutoID' "
    );
   await BolsaSelect();

    var resultadoQtdZero = await conn.execute(
    "SELECT Quantidade FROM bolsa WHERE ID_Usuario = :IDU AND ID_Produto = :ProdutoID",
    {
      'IDU': IDU,
      'ProdutoID': ProdutoID,
    },
  );

  for (var element in resultadoRB.rows) {
        Map data = element.assoc();
        ProdutoQ = int.tryParse(data['Quantidade'] ?? '0') ?? 0;
          }
      print('Quantidade é $ProdutoQ');

  // Se a quantidade for 0, excluir a linha inteira
  if (ProdutoQ == 0) {
    await conn.execute(
      "DELETE FROM bolsa WHERE ID_Usuario = :IDU AND ID_Produto = :ProdutoID",
      {
        'IDU': IDU,
        'ProdutoID': ProdutoID,
      },
    );
    await BolsaSelect();

  }
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
        freteG: freteG!,
        count: count,
        )));
        print('ID: $IDU. IDP: $ProdutoID. ProdutoN: $ProdutoN');
    break;

    case 1:
    Navigator.pushNamed(context, 'anelNoivScreen');
    break;

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
        freteG: freteG!,
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
        freteG: freteG!,
        count: count,
        )));

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
        freteG: freteG!,
        count: count,
        )));
    break;
   }
  }

  
  @override
  Widget build(BuildContext context) {
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
                        freteG: freteG!,
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
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dados.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text('Produto: ${dados[index] ['Produto']?? ''}'),
                        Text('(${dados[index] ['Quantidade']})'),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Preço: R\$ ${int.parse(dados[index]['Preço']!) * int.parse(dados[index]['Quantidade']!)}',
                            style: const TextStyle(
                              color: Colors.green
                            ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text('( R\$ ${dados[index] ['Preço']} X ${dados[index] ['Quantidade']} = R\$ ${int.parse(dados[index]['Preço']!) * int.parse(dados[index]['Quantidade']!)})',
                            style: const TextStyle(
                              color: Colors.green
                            ),)
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                        
                        if (dados[index] ['Estoque'] == 'Disponível')
                        const Text('Disponível no Estoque',
                        style: TextStyle(
                          color: Colors.green
                          ),
                        )
                        else if (dados[index] ['Estoque'] == 'Não Disponível')
                        const Text('Não disponível no Estoque',
                        style: TextStyle(
                          color: Colors.red
                        ),
                        ),
                        const SizedBox(width: 20,),
                       TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.white)
                        ),
                      onPressed: () {
                        Navigator.push(context,
                              MaterialPageRoute(builder: (context) => formaPagar(
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
                                freteG: freteG!,
                                count: count,
                        )));
                      }, child: const Text('Comprar',
                      style: TextStyle(
                        color: Colors.black
                      ),
                      ),
                      ),
                     
                      IconButton(
                      onPressed: () {
                          AdicionarBolsa();
                      }, icon: const Icon(Icons.add,
                      color: Colors.green,)
                      ),
                      IconButton(
                      onPressed: () {
                          RemoverBolsa();
                      }, icon: const Icon(Icons.remove_circle,
                      color: Colors.red,)
                      ),
                      ],
                    ),
                      ],
                    ),
                  );
                },
                ),
            ],
          ),
        ),
    );
  }
}