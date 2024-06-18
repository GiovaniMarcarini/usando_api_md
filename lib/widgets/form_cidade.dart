import 'package:flutter/cupertino.dart';
import '../model/cidade.dart';
import '../services/cidade_service.dart';
import 'package:flutter/material.dart';

class FormCidadePage extends StatefulWidget{
  final Cidade? cidade;

  const FormCidadePage({this.cidade});

  @override
  State<StatefulWidget> createState() => _FormCidadePageState();
}

class _FormCidadePageState extends State<FormCidadePage>{
  final _service = CidadeService();
  var _saving = false;
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  String? _currentUf;

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),

    );
  }

  AppBar _criarAppBar(){
    final String title;
    if(widget.cidade == null){
      title = 'Nova Cidade';
    }else{
      title = 'Alterar Cidade';
    }

    final Widget titleWidget;
    if(_saving){
      titleWidget = Row(
        children: [
          Expanded(
              child: Text(title),
          ),
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ),
        ],
      );
    }else{
      titleWidget = Text(title);
    }
    return AppBar(
      title:  titleWidget,
      actions: [
        if(_saving){
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
          )
        }
      ],
    );
  }

  Widget _criarBody() => Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(widget.cidade?.codigo != null){
            Text('Código: ${widget.cidade!.codigo}'),
            }
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome da Cidade',
                  ),
                  controller: _nomeController,
                  validator: (String? value){
                    if (value == null || value.trim().isEmpty){
                      return 'Informe o nome da cidade';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  value: _currentUf,
                  decoration: InputDecoration(
                    labelText: 'Selecione a UF'
                  ),
                  items: _buildDropDownItens(),
                  onChanged: (String? value){
                    setState(() {
                      _currentUf = value;
                    });
                  },
                  validator: (String? value){
                    if (value == null || value.trim().isEmpty){
                      return 'Selecione uma UF';
                    },
                    return null;
                  },
                ),
            ],
          ),
        ),
      ),
  )

  List<DropdownMenuItem<String>> _buildDropDownItens(){
    const ufs = ['AC', 'AL', 'AP', 'GO', 'PR', 'SC', 'SP', 'RS'];
    final List<DropdownMenuItem<String>> itens = [];
    for (final uf in ufs){
      itens.add(DropdownMenuItem(
          value: uf,
          child: Text(uf),
      ));
    }
    return itens;
  }

  Future<void> _save() async{
    if(_formKey.currentState == null || !_formKey.currentState!.validate()){
      return;
    }
    setState(() {
      _saving = true;
    });
    try{
      await = _service.saveCidade(Cidade(
    codigo: widget.cidade?.codigo,
    nome: _nomeController.text,
    uf: _currentUf! ));
    Navigator.pop(context, true);
    return;
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Não foi possível salvar a cidade, tente novamente!'),
    ));
    }
    setState(() {
      _saving = false;
    });
  }
}



