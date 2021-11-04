import 'package:cadastrar_livro/cadastro.dart';
import 'package:cadastrar_livro/databaseHelper.dart';
import 'package:cadastrar_livro/livro.dart';
import 'package:flutter/material.dart';

class Adicionar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdicionarState();
  }
}

enum Lido { lido, nao_lido }

class AdicionarState extends State<Adicionar> {
  // ignore: unused_field
  String _titulo = ' ';
  // ignore: unused_field
  String _autor = ' ';
  // ignore: unused_field
  String _editora = ' ';
  Lido? _lido;
  String li = 'lido';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Widget _buildTitulo() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
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
        _titulo = value!;
      },
    );
  }

  Widget _buildEditora() {
    return TextFormField(
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
        _editora = value!;
      },
    );
  }

  Widget _buildAutor() {
    return TextFormField(
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
        _autor = value!;
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
            title: Text('Adicionar Livro'),
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
                      child: Text('Cadastrar Livro'),
                      onPressed: () async {
                        if (!_formkey.currentState!.validate()) {}
                        _formkey.currentState!.save();
                        await DatabaseHelper.instance.add(Livro(
                            titulo: _titulo,
                            autor: _autor,
                            editora: _editora,
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
