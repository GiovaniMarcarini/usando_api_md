
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:usando_api_md/model/cep.dart';
import 'package:usando_api_md/services/cep_service.dart';

class ConsultaCepFragmet extends StatefulWidget{

  static const title = 'Buscar CEP';

  @override
  State<StatefulWidget> createState() => _ConsultaCepFragmetState();

}
class _ConsultaCepFragmetState extends State<ConsultaCepFragmet>{
  final _service = CepService();
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _loading = false;
  final _cepFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#' : RegExp(r'[0-9]')}
  );

  Cep? _cep;

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'CEP',
                  suffixIcon: _loading ? const Padding(
                      padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ) : IconButton(
                      onPressed: null,
                      icon: Icon(Icons.search),
                  ),
                ),
                inputFormatters: [_cepFormatter],
                validator: (String? value){
                  if (value == null || value.isEmpty ||
                      !_cepFormatter.isFill()){
                    return 'Informe um cep válido';
                  }
                  return null;
                },
              ),
          ),
        ],
      ),
    );
  }
}
