import 'package:flutter/material.dart';

class LavacarForm extends StatefulWidget {
  @override
  State<LavacarForm> createState() => _LavacarFormState();
}

class _LavacarFormState extends State<LavacarForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  @override
  initState() {
    super.initState();
    //loadFormData();
  }

  @override
  Widget build(BuildContext context) {
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
                  initialValue: _formData['CNPJ'],
                  decoration: InputDecoration(labelText: 'CNPJ'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['cnpj'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Nome'],
                  decoration: InputDecoration(labelText: 'Nome'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['nome'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Logradouro'],
                  decoration: InputDecoration(labelText: 'Logradouro'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['logradouro'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Numero'],
                  decoration: InputDecoration(labelText: 'Nº'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['numero'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Complemento'],
                  decoration: InputDecoration(labelText: 'Complemento'),
                  //fazer validação CNPJ, formatação CNPJ
                  onChanged: (value) => _formData['complemento'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Bairro'],
                  decoration: InputDecoration(labelText: 'Bairro'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['bairro'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Cidade'],
                  decoration: InputDecoration(labelText: 'Cidade'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['cidade'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Cep'],
                  decoration: InputDecoration(labelText: 'Cep'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['cep'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Telefone1'],
                  decoration: InputDecoration(labelText: 'Telefone'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['telefone1'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Telefone2'],
                  decoration: InputDecoration(labelText: 'Telefone Opcional'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['telefone2'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Email'],
                  decoration: InputDecoration(labelText: 'Email'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['email'] = value,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(onPressed: () {}, child: Text('Salvar'))
              ],
            )),
      ),
    );
  }
}
