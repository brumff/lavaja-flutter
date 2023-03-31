import 'package:flutter/material.dart';
import 'package:lavaja/models/lavacar.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:provider/provider.dart';

import '../components/disponibilidade_component.dart';

class LavacarForm extends StatefulWidget {
  @override
  State<LavacarForm> createState() => _LavacarFormState();
}

class _LavacarFormState extends State<LavacarForm> {
  final _form = GlobalKey<FormState>();
  bool _isAtivo = false;
  TimeOfDay _horaInicio = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _horaFim = TimeOfDay(hour: 0, minute: 0);

  // final Map<String, dynamic> _formData = {};
  bool isLoading = true;
  bool isEditing = true;
  Lavacar? lavacar;
  @override
  initState() {
    super.initState();
    Provider.of<LavacarProvider>(context, listen: false)
        .getLavacar()
        .whenComplete(() {
      lavacar = Provider.of<LavacarProvider>(context, listen: false).lavacar;
      setState(() {
        isLoading = false;
      });
    });
  }

  void save() {
    final isValid = _form.currentState?.validate();

    if (isValid!) {
      _form.currentState!.save();

      Provider.of<LavacarProvider>(context, listen: false).createLavacar(
        lavacar?.cnpj ?? '',
        lavacar?.nome ?? '',
        lavacar?.logradouro ?? '',
        lavacar?.numero ?? '',
        lavacar?.complemento ?? '',
        lavacar?.bairro ?? '',
        lavacar?.cidade ?? '',
        lavacar?.cep ?? '',
        lavacar?.telefone1 ?? '',
        lavacar?.telefone2 ?? '',
        lavacar?.email ?? '',
        lavacar?.ativo ?? false,
      );
      Navigator.of(context).pop();
    }
  }

  void edit(){

  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Lava car'),
        //para realizar updaload da imagem/logo
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                      'https://img.freepik.com/vetores-gratis/ilustracao-de-galeria-icone_53876-27002.jpg?w=740&t=st=1679449312~exp=1679449912~hmac=ee1fc64f18337be42c14e1f416549d65b7c0674f7d4a074b156ac936e5a54283'),
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.cnpj,
                  decoration: InputDecoration(labelText: 'CNPJ'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => lavacar?.cnpj = value,
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.nome,
                  decoration: InputDecoration(labelText: 'Nome'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => lavacar?.nome = value,
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.logradouro,
                  decoration: InputDecoration(labelText: 'Logradouro'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => lavacar?.logradouro = value,
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.numero,
                  decoration: InputDecoration(labelText: 'Nº'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => lavacar?.numero = value,
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.complemento,
                  decoration: InputDecoration(labelText: 'Complemento'),
                  //fazer validação CNPJ, formatação CNPJ
                  onChanged: (value) => lavacar?.complemento = value,
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.bairro,
                  decoration: InputDecoration(labelText: 'Bairro'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => lavacar?.bairro = value,
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.cidade,
                  decoration: InputDecoration(labelText: 'Cidade'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => lavacar?.cidade = value,
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.cep,
                  decoration: InputDecoration(labelText: 'Cep'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => lavacar?.cep = value,
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.telefone1,
                  decoration: InputDecoration(labelText: 'Telefone'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => lavacar?.telefone1 = value,
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.telefone2,
                  decoration: InputDecoration(labelText: 'Telefone Opcional'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => lavacar?.telefone2 = value,
                ),
                TextFormField(
                  enabled: !isEditing,
                  initialValue: lavacar?.email,
                  decoration: InputDecoration(labelText: 'Email'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => lavacar?.email = value,
                ),
                CheckboxListTile(
                  enabled: !isEditing,
                  title: Text("Ativo"),
                  value: lavacar?.ativo ?? false,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      lavacar?.ativo = value;
                    });
                  },
                ),
                Text(
                  'Horário de funcionamento',
                  style: TextStyle(fontSize: 18),
                ),
                DisponibilidadeComponent(),
                ElevatedButton(onPressed: () {
                  setState(() {
                    isEditing = false;
                  });
                  if(isEditing == false){
                    save();
                  }
                }, child: Text(isEditing? 'Editar' : 'Salvar')),
              ],
            )),
      ),
    );
  }
}
