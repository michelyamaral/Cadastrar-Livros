import 'package:cadastrar_livro/atualizar.dart';
import 'package:flutter/material.dart';
import 'package:cadastrar_livro/databaseHelper.dart';
import 'package:cadastrar_livro/livro.dart';

import 'adicionar.dart';

class Cadastro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CadastroState();
  }
}

class CadastroState extends State<Cadastro> {
  @override
  void initState() {
    super.initState();
  }

  Widget _builList() {
    return FutureBuilder<List<Livro>>(
      future: DatabaseHelper.instance.getLivros(),
      builder: (BuildContext context, AsyncSnapshot<List<Livro>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            padding: EdgeInsets.all(30),
            child: Text('Carregando...',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(71, 40, 54, 1.0), fontSize: 20)),
          );
        }
        return snapshot.data!.isEmpty
            ? Container(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Text('Não há livros cadastrados',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(71, 40, 54, 1.0),
                          fontSize: 20)),
                ),
              )
            : ListView(
                children: snapshot.data!.map((livros) {
                  return Card(
                    child: ListTile(
                      title: Text('${livros.titulo}, ${livros.autor}'),
                      subtitle: Text('${livros.editora}'),
                      trailing: Text('${livros.lido}'),
                      onLongPress: () {
                        setState(() {
                          DatabaseHelper.instance.remove(livros.id!);
                        });
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Atualizar(livro: livros)));
                      },
                    ),
                  );
                }).toList(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastrar Livro'),
        ),
        body: Container(
            padding: EdgeInsets.all(30),
            child: Expanded(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: _builList(),
            ))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Adicionar()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
