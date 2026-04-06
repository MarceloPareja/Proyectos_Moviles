import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'dart:io';
import '../entities/pregunta.dart';
import '../entities/prueba.dart';
import 'package:file_picker/file_picker.dart';
class PdfGenerator {

  //Genera el pdf, y lo guarda
   Future<File> generatePdf(Prueba prueba, String docente, int nrc, List<Pregunta> preguntas) async {

     //Se usan todos los datos disponibles para el pdf
    final pdfFile = pw.Document();
    pdfFile.addPage(pw.MultiPage(
      build: (context) => [pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          testHeader(prueba, docente, nrc),
          ...questions(preguntas)
          ])]
    ));
    String nombre = "${nrc}-${prueba.titulo.replaceAll(" ", "_")}";
    return savePdf(filename: "$nombre.pdf", pdf: pdfFile);
  }
  Future<void> openPdf(File file) async {
    await OpenFile.open(file.path);
  }

  //Almacena el pdf temporalmente en el dispositivo
  Future<File> savePdf({required String filename, required pw.Document pdf})async{
     final bytes = await pdf.save();
     final dir = await Directory.systemTemp.createTemp();
     final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes);
      return file;
  }

  //Encabezado
  pw.Widget testHeader(Prueba prueba, String docente, int nrc)
  {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        // Título de la prueba
        pw.Center(
          child: pw.Text(
            prueba.titulo,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),

        pw.SizedBox(height: 12),

        // Información básica
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Del lado izquierdo:
            //Estudiante: ______________________
            //Fecha: _____________________
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Estudiante: ____________________', style: pw.TextStyle(fontSize: 9)),
                  pw.SizedBox(height: 5),
                  pw.Text('Fecha: ${prueba.fecha.day}-${prueba.fecha.month}-${prueba.fecha.year}',
                      style: pw.TextStyle(fontSize: 9)),
                ],
              ),
            ),

            // Del lado izquierdo:
            //Profesor: ______________________
            //NRC: _____________________
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text('Docente: ${docente}', style: pw.TextStyle(fontSize: 9)),
                  pw.SizedBox(height: 5),
                  pw.Text('NRC: ${nrc}', style: pw.TextStyle(fontSize: 9)),
                ],
              ),
            ),
          ],
        ),

        instructions(prueba.introduccion),
      ] ,
    );
  }

  //Instrucciones en caso de se hayan agregado a la prueba
  pw.Widget instructions(String instrucciones)
  {
    if(instrucciones != "")
    {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Indicaciones:',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            instrucciones,
            textAlign: pw.TextAlign.justify,
          )
        ]
      );
  }
  else
    {
      //Si no hay instrucciones, simplemente se deja un espacio
    return pw.SizedBox(height: 15);
    }
  }

  List<pw.Widget> questions(List<Pregunta> preguntas)
  {
    return preguntas.map(
        (pregunta){
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '${pregunta.numero+1}. ${pregunta.enunciado}',
                  style: pw.TextStyle(fontSize: 9),
                ),
                pw.SizedBox(height: 1),
                ...optionMap(pregunta.opciones),
                pw.SizedBox(height: 9)
              ]);
        }
    ).toList();
  }

  List<pw.Widget> optionMap(Map<String, dynamic> options)
  {
    List<String> answers = [];
    options.forEach((k,v)=>answers.add("$k) $v"));
    return answers.map(
        (answer){
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(answer,style: pw.TextStyle(fontSize: 9)),
                pw.SizedBox(height: 1)
              ]
          );
        }
    ).toList();
  }
}



