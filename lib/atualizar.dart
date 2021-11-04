import 'package:flutter/material.dart';

import 'package:cadastrar_livro/cadastro.dart';
import 'package:cadastrar_livro/databaseHelper.dart';
import 'package:cadastrar_livro/livro.dart';

class Atualizar extends StatefulWidget {
  final Livro livro;
  Atualizar({required this.livro});
  @override
  State<StatefulWidget> createState() {
    return AtualizarState();
  }
}

enum Lido { lido, nao_lido }

class AtualizarState extends State<Atualizar> {
  TextEditingController _titulo = TextEditingController();
  TextEditingController _autor = TextEditingController();
  TextEditingController _editora = TextEditingController();
  late Livro _livro;
  Lido? _lido;
  late String li;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setState(() {
      _livro = widget.livro;
      _titulo = TextEditingController(text: _livro.titulo);
      _autor = TextEditingController(text: _livro.autor);
      _editora = TextEditingController(text: _livro.editora);
      li = _livro.lido;
    });
  }

  Widget _buildTitulo() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      controller: _titulo,
      style: TextStyle(fontSize: 24),
      decoration: new InputDecoration(
        hintText: 'Título',
        hintStyle: TextStyle(
          fontSize: 24,
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Título deve ser preenchido';
        }
      },
      onSaved: (String? value) {
        _titulo.text = value!;
      },
    );
  }

  Widget _buildEditora() {
    return TextFormField(
      controller: _editora,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontSize: 24),
      decoration: new InputDecoration(
        hintText: 'Editora',
        hintStyle: TextStyle(
          fontSize: 24,
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Editora deve ser preenchido';
        }
      },
      onSaved: (String? value) {
        _editora.text = value!;
      },
    );
  }

  Widget _buildAutor() {
    return TextFormField(
      controller: _autor,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontSize: 24),
      decoration: new InputDecoration(
        hintText: 'Autor',
        hintStyle: TextStyle(
          fontSize: 24,
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Autor deve ser preenchido';
        }
      },
      onSaved: (String? value) {
        _autor.text = value!;
      },
    );
  }

  Widget _buildLido() {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Lido',
            style: TextStyle(fontSize: 18),
          ),
          leading: Radio<Lido>(
            value: Lido.lido,
            groupValue: _lido,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (Lido? value) {
              setState(() {
                _lido = value;
                li = 'Lido';
              });
            },
          ),
        ),
        ListTile(
            title: Text('Não Lido',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 18)),
            leading: Radio<Lido>(
              value: Lido.nao_lido,
              groupValue: _lido,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (Lido? value) {
                setState(() {
                  _lido = value;
                  li = 'nao lido';
                });
              },
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Theme.of(context),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Editar Livro'),
          ),
          body: Container(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _formkey,
                child: Column(children: <Widget>[
                  _buildTitulo(),
                  SizedBox(
                    height: 30,
                  ),
                  _buildAutor(),
                  SizedBox(
                    height: 30,
                  ),
                  _buildEditora(),
                  SizedBox(
                    height: 30,
                  ),
                  _buildLido(),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () async {
                        if (!_formkey.currentState!.validate()) {}
                        _formkey.currentState!.save();
                        await DatabaseHelper.instance.update(Livro(
                            id: _livro.id,
                            titulo: _titulo.text,
                            autor: _autor.text,
                            editora: _editora.text,
                            lido: li));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cadastro()));
                      },
                    ),
                  )
                ]),
              )),
        ));
  }
}
