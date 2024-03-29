import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Definindo a máscara para o telefone
var phoneMaskFormatter = MaskTextInputFormatter(
  mask: '(##) #####-####',
  filter: {"#": RegExp(r'[0-9]')},
);

var cnpjMaskFormatter = MaskTextInputFormatter(
  mask: '##.###.###/####-##',
  filter: {'#': RegExp(r'[0-9]')},
);

var cepMaskFormatter = MaskTextInputFormatter(
  mask: '#####-###',
  filter: {'#': RegExp(r'[0-9]')},
);

var cpfMaskFormatter = MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {'#': RegExp(r'[0-9]')},
);
