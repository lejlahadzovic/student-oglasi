import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Kategorija/kategorija.dart';
import 'package:studentoglasi_admin/models/Objava/objava.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/kategorije_provider.dart';
import 'package:studentoglasi_admin/providers/objave_provider.dart';

class ObjaveDetailsDialog extends StatefulWidget {
  Objava? objava;
  SearchResult<Kategorija>? kategorijeResult;
  ObjaveDetailsDialog({super.key, this.objava, this.kategorijeResult});

  @override
  _ObjaveDetailsDialogState createState() => _ObjaveDetailsDialogState();
}

class _ObjaveDetailsDialogState extends State<ObjaveDetailsDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _intialValue = {};
  // TextEditingController _naslovController = TextEditingController();
  // TextEditingController _sadrzajController = TextEditingController();
  // late KategorijaProvider _kategorijeProvider;
  // Kategorija? _selectedKategorija;
  late ObjaveProvider _objaveProvider;

  @override
  void initState() {
    super.initState();
    _objaveProvider = context.read<ObjaveProvider>();
    // _kategorijeProvider = context.read<KategorijaProvider>();

    // if (widget.objava != null) {
    //   _naslovController.text = widget.objava!.naslov ?? '';
    //   _sadrzajController.text = widget.objava!.sadrzaj ?? '';
    //   if (widget.kategorijeResult != null &&
    //       widget.kategorijeResult!.result.isNotEmpty) {
    //     _selectedKategorija = widget.kategorijeResult!.result.firstWhere(
    //       (kategorija) => kategorija.id == widget.objava!.kategorija?.id
    //     );
    //   }
    // }

    _intialValue = {
      'naslov': widget.objava?.naslov,
      'sadrzaj': widget.objava?.sadrzaj,
      'slika': widget.objava?.slika ?? 'Image not available',
      'kategorijaId': widget.objava?.kategorijaId.toString()
    };
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Dodaj novost'),
      content: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          initialValue: _intialValue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilderTextField(
                name: 'slika',
                decoration: InputDecoration(
                  labelText: 'Slika',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                        name: 'naslov',
                        decoration: InputDecoration(
                          labelText: 'Naslov',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: FormBuilderDropdown<String>(
                      name: 'kategorijaId',
                      decoration: InputDecoration(
                        labelText: 'Kategorija',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: widget.kategorijeResult?.result
                              .map((Kategorija kategorija) => DropdownMenuItem(
                                    value: kategorija.id.toString(),
                                    child: Text(kategorija.naziv ?? ''),
                                  ))
                              .toList() ??
                          [],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                name: 'sadrzaj',
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Sadržaj',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            _formKey.currentState?.saveAndValidate();
            var request = Map.from(_formKey.currentState!.value);

            try {
              widget.objava == null
                  ? await _objaveProvider.insert(request)
                  : await _objaveProvider.update(widget.objava!.id!, request);

              Navigator.pop(context, true);
            } on Exception catch (e) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"))
                        ],
                      ));
            }
          },
          child: Text('Sačuvaj'),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blue.shade800),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
