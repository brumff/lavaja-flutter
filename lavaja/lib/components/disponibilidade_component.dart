import 'package:flutter/material.dart';

class DisponibilidadeComponent extends StatefulWidget {
  @override
  _DisponibilidadeComponentState createState() =>
      _DisponibilidadeComponentState();
}

class _DisponibilidadeComponentState extends State<DisponibilidadeComponent> {
  bool _isAtivo = false;
  TimeOfDay _horaInicio = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _horaFim = TimeOfDay(hour: 0, minute: 0);

 @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ativar horário:'),
                Switch(
                  value: _isAtivo,
                  onChanged: (bool valor) {
                    setState(() {
                      _isAtivo = valor;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Início:'),
                TextFormField(
                  decoration: InputDecoration(
                   // hintText: 'Horário de início',
                  ),
                  onTap: () async {
                    TimeOfDay? horaSelecionada = await showTimePicker(
                      context: context,
                      initialTime: _horaInicio,
                    );
                    if (horaSelecionada != null) {
                      setState(() {
                        _horaInicio = horaSelecionada;
                      });
                    }
                  },
                  controller: TextEditingController(
                      text: _horaInicio.format(context).toString()),
                  enabled: _isAtivo,
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fim:'),
                TextFormField(
                  decoration: InputDecoration(
                    //hintText: 'Horário de fim',
                  ),
                  onTap: () async {
                    TimeOfDay? horaSelecionada = await showTimePicker(
                      context: context,
                      initialTime: _horaFim,
                    );
                    if (horaSelecionada != null) {
                      setState(() {
                        _horaFim = horaSelecionada;
                      });
                    }
                  },
                  controller: TextEditingController(
                      text: _horaFim.format(context).toString()),
                  enabled: _isAtivo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}